#!/bin/bash

source "$HOME/Desktop/casper-mlib-m2025a/startsg" \
       "$HOME/Desktop/casper-mlib-m2025a/startsg.local" || exit 1

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
        echo "找不到 Model Composer 初始化指令"
        return 1
      fi

      builtin exec "$casper_exe" -batch \
        "try; disp('COMPOSER_INIT_BEGIN'); $casper_init; disp('COMPOSER_INIT_PASS'); setenv('PYTHONHOME',''); pyenv('Version',fullfile(getenv('CASPER_PYTHON_VENV_ON_START'),'bin','python')); disp(char(py.sys.version)); disp(char(py.sys.executable)); disp('CASPER_STARTUP_BEGIN'); run(fullfile(getenv('MLIB_DEVEL_PATH'),'startup.m')); assert(bdIsLoaded('casper_library')); assert(bdIsLoaded('xps_library')); disp('CASPER_STARTUP_PASS'); bdclose('all'); catch err; disp(getReport(err,'extended')); exit(1); end;"
      ;;
    *)
      builtin exec "$@"
      ;;
  esac
}
export -f exec

"$COMPOSER_PATH/bin/model_composer" -matlab "$MATLAB_PATH" -nodesktop
