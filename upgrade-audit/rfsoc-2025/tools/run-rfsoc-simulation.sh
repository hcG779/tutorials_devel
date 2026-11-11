#!/bin/bash

casper_tools_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)" || exit 1
export CASPER_TUTORIAL_ROOT="$(cd "$casper_tools_dir/../../.." && pwd)" || exit 1
export CASPER_MIGRATION_SCRIPT="$casper_tools_dir/run_migration_and_simulation.m"
export CASPER_CHECKS_DIR="${CASPER_CHECKS_DIR:-$HOME/Desktop/casper-checks}"
mkdir -p "$CASPER_CHECKS_DIR" || exit 1

test -x /usr/bin/ld || exit 1
mkdir -p "$CASPER_CHECKS_DIR/system-linker" || exit 1
casper_linker="$CASPER_CHECKS_DIR/system-linker/ld"
if [ ! -e "$casper_linker" ] && [ ! -L "$casper_linker" ]; then
  ln -s /usr/bin/ld "$casper_linker" || exit 1
fi
if [ "$(readlink -f "$casper_linker")" != "$(readlink -f /usr/bin/ld)" ]; then
  echo "Unexpected simulation linker; stop before running MATLAB."
  exit 1
fi


casper_mlib_dir="${CASPER_MLIB_DIR:-$HOME/Desktop/casper-mlib-m2025a}"
casper_localdefs="${CASPER_LOCALDEFS:-$casper_mlib_dir/startsg.local}"

source "$casper_mlib_dir/startsg" "$casper_localdefs" || exit 1

exec() {
  case "$1" in
    "$HOME/.XILINX_MATLAB_RUNTIME/"*/MATLAB)
      local casper_exe="$1"
      local casper_init=""
      shift

      while [ "$#" -gt 0 ]; do
        if [ "$1" = "-r" ]; then
          casper_init="$2"
          break
        fi
        shift
      done

      if [ -z "$casper_init" ]; then
        echo "Model Composer initialization command not found"
        return 1
      fi

      builtin exec "$casper_exe" -batch \
        "try; disp('COMPOSER_INIT_BEGIN'); $casper_init; disp('COMPOSER_INIT_PASS'); setenv('PYTHONHOME',''); pyenv('Version',fullfile(getenv('CASPER_PYTHON_VENV_ON_START'),'bin','python')); disp(char(py.sys.version)); disp(char(py.sys.executable)); disp('CASPER_STARTUP_BEGIN'); run(fullfile(getenv('MLIB_DEVEL_PATH'),'startup.m')); assert(bdIsLoaded('casper_library')); assert(bdIsLoaded('xps_library')); disp('CASPER_STARTUP_PASS'); run(getenv('CASPER_MIGRATION_SCRIPT')); bdclose('all'); catch err; disp(getReport(err,'extended')); exit(1); end;"
      ;;
    *)
      builtin exec "$@"
      ;;
  esac
}
export -f exec

"$COMPOSER_PATH/bin/model_composer" -matlab "$MATLAB_PATH" -nodesktop
