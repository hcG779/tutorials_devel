# RFSoC platform migration runner

## Prerequisites

- MATLAB R2025a and AMD Model Composer 2025.1 installed and licensed.
- The mlib_devel fixes identified in ../source-revisions.txt.
- A configured startsg.local, including the CASPER Python environment.
- The original RFSoC4x2 platform model in this tutorial repository.

## Run

From the tutorial repository root:

```bash
bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-migration.sh
```

The runner locates its MATLAB script and the source model relative to
this repository. By default, it uses:

- mlib_devel: $HOME/Desktop/casper-mlib-m2025a
- Local definitions: startsg.local in that mlib_devel directory
- Output parent directory: $HOME/Desktop/casper-checks

To use different locations, provide absolute paths:

```bash
CASPER_MLIB_DIR=/path/to/mlib_devel \
CASPER_LOCALDEFS=/path/to/startsg.local \
CASPER_CHECKS_DIR=/path/to/test-output \
bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-migration.sh
```

The MATLAB, AMD and Python paths are configured in startsg.local.
Use an output directory outside the source repositories.

## Expected result

Each run copies the original model into a new output directory, migrates
the Hub and platform blocks, updates the model, and saves the copy.
The source model is not modified.

Expected markers:

- AMD_HUB_CONVERSION_PASS
- PLATFORM_MIGRATION_PASS
- HUB_MODEL_UPDATE_PASS
- MIGRATED_MODEL_SAVED: followed by the output model path

Check both the process exit status and the log. Exit code 0 alone is
insufficient: an earlier diagnostic query printed ParamEvalDelete errors
without causing a nonzero exit.

## Validation scope

The repository runner passed on the existing test workstation without
ParamEvalDelete messages. Alternative path settings and installation on
a clean shared host have not yet been tested.

This runner tests migration and diagram update only. It does not perform
simulation, FPGA compilation or hardware validation.

The launcher uses a workaround that intercepts the AMD launcher's final
exec call to run MATLAB in batch mode. This depends on the tested AMD
2025.1 launcher behavior and may need revision for other versions.
