#!/bin/bash

# Compile an existing frontend model locally. No board access is performed.
set -o pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: bash run-rfsoc-backend.sh /absolute/path/to/model.slx"
  exit 2
fi

casper_model=$(readlink -f -- "$1") || exit 1
if [ ! -f "$casper_model" ] || [[ "$casper_model" != *.slx ]]; then
  echo "Input must be an existing .slx model."
  exit 2
fi

casper_build="${casper_model%.slx}"
casper_run_dir=$(dirname -- "$casper_model")

if [ ! -s "$casper_build/jasper.per" ]; then
  echo "Frontend peripheral file not found. Run the frontend first."
  exit 2
fi

if [ ! -s "$casper_build/sysgen/ip/component.xml" ]; then
  echo "Expected frontend IP descriptor not found."
  exit 2
fi

if [ -e "$casper_build/myproj" ]; then
  echo "A Vivado project already exists in this build directory."
  echo "Use a fresh frontend run to preserve previous build results."
  exit 2
fi

casper_mlib_dir="${CASPER_MLIB_DIR:-$HOME/Desktop/casper-mlib-m2025a}"
casper_localdefs="${CASPER_LOCALDEFS:-$casper_mlib_dir/startsg.local}"

source "$casper_mlib_dir/startsg" "$casper_localdefs" || exit 1

if [ -z "$CASPER_PYTHON_VENV_ON_START" ]; then
  echo "CASPER_PYTHON_VENV_ON_START must be configured."
  exit 2
fi

casper_python="$CASPER_PYTHON_VENV_ON_START/bin/python"
if [ ! -x "$casper_python" ]; then
  echo "Configured Python executable not found."
  exit 2
fi

unset PYTHONHOME PYTHONPATH
export PATH="$CASPER_PYTHON_VENV_ON_START/bin:$PATH"

casper_jobs="${CASPER_BACKEND_JOBS:-2}"
if ! [[ "$casper_jobs" =~ ^[1-9][0-9]*$ ]]; then
  echo "CASPER_BACKEND_JOBS must be a positive integer."
  exit 2
fi

printf 'BACKEND_MODEL: %s\n' "$casper_model"
printf 'BACKEND_BUILD_DIR: %s\n' "$casper_build"

"$casper_python" -E "$MLIB_DEVEL_PATH/jasper_library/exec_flow.py" \
  -m "$casper_model" \
  -c "$casper_build" \
  --middleware --backend --software \
  --jobs "$casper_jobs" --threads single \
  2>&1 | tee "$casper_run_dir/repository-backend.log"

casper_status=${PIPESTATUS[0]}
printf 'Backend process exit code: %s\n' "$casper_status"
if [ "$casper_status" -ne 0 ]; then
  exit "$casper_status"
fi

for casper_artifact in top.bit top.bin top.xsa; do
  casper_path="$casper_build/myproj/myproj.runs/impl_1/$casper_artifact"
  if [ ! -s "$casper_path" ]; then
    printf 'Missing or empty artifact: %s\n' "$casper_path"
    exit 1
  fi
  ls -lh "$casper_path"
done

shopt -s nullglob
casper_fpgs=("$casper_build"/outputs/*.fpg)
if [ "${#casper_fpgs[@]}" -eq 0 ]; then
  echo "No FPG output found."
  exit 1
fi

for casper_path in "${casper_fpgs[@]}"; do
  if [ ! -s "$casper_path" ]; then
    echo "Empty FPG output found."
    exit 1
  fi
  ls -lh "$casper_path"
done

echo "REPOSITORY_BACKEND_OUTPUTS_PASS"
