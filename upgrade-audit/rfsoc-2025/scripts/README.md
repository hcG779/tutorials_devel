# Validated workstation script snapshots

These scripts were used on the test workstation. They retain its
Desktop directory layout and are not yet portable installation scripts.

- check-casper-startup.sh: initialize Model Composer, Python and CASPER.
- test-rfsoc-hub-migration.sh: launch the MATLAB migration test.
- test_rfsoc_hub_migration.m: copy the original tutorial model, convert
  the legacy System Generator block to a Hub, replace the platform
  block, update the model and save the copy.

Before running elsewhere, review all paths, including the startsg.local
configuration and any referenced scripts under Desktop/casper-checks.

## Migration rerun result

The revised migration test completed with exit code 0 and these markers:

- AMD_HUB_CONVERSION_PASS
- PLATFORM_MIGRATION_PASS
- HUB_MODEL_UPDATE_PASS
- MIGRATED_MODEL_SAVED

No ParamEvalDelete messages appeared in this run.

The optional vmchub_get_param diagnostic query was replaced with a
library-reference assertion because that query triggered mask rebuilding
during parameter evaluation. This does not resolve arbitrary Hub API
scan compatibility.

This rerun validates migration and model update on the existing
workstation. It does not repeat simulation, FPGA compilation, or
installation on a clean host.
