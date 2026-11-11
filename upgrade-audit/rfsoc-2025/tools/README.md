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

## Repository migration and arithmetic simulation

From the tutorial repository root, run:

```bash
bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-simulation.sh
```

This runner initializes the environment, migrates a fresh copy of the
original model, and passes that model directly to the arithmetic test.
It does not obtain the model path from an earlier log.

The simulation uses a scoped system-linker override. Temporary signal
logging blocks are added in memory and are not saved to the model.

Validated cases:

| A | B | Expected result |
|---:|---:|---:|
| 10 | 20 | 30 |
| 0 | 0 | 0 |
| 12345 | 6789 | 19134 |

All three cases passed on the test workstation, with exit code 0 and
the final markers ARITHMETIC_CHECK_PASS and REPOSITORY_SIMULATION_PASS.

Known warnings remain:

- The gpio_ctr output is unconnected.
- Temporary logging branches directly connect Model Composer outputs
  to native Simulink blocks, producing externally-connected-block warnings.

This validates the instrumented arithmetic simulation. It does not
validate all counter behavior, overflow boundaries, FPGA compilation,
or hardware operation.

The test saves rfsoc-arithmetic-case-1.mat through
rfsoc-arithmetic-case-3.mat in CASPER_CHECKS_DIR. These filenames are
reused on subsequent runs; use a different output directory to retain
separate runs.

No board connection or programming is performed.
