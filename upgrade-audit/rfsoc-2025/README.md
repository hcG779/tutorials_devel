# RFSoC CASPER upgrade validation

## Purpose

Evaluate a newer OS and dependency stack for CASPER, document the
required changes, and prepare reproducible instructions for a shared
development host.

This is a test report for one RFSoC 4x2 basic platform design.
It is not a claim that all CASPER tutorials or hardware functions work.

## Version comparison

| Component | Existing RFSoC tutorial | Tested environment |
|---|---|---|
| Ubuntu | 18.04 / 20.04 | 24.04.5 LTS |
| MATLAB / Simulink | R2021a | R2025a Update 1 |
| Vivado / Model Composer | 2021.1 | 2025.1 |
| mlib_devel | m2021a | m2025a-based branch with local fixes |
| Python | Python 3, unspecified | 3.12.3 |
| device-tree-xlnx | xlnx_rel_v2021.2 | xlnx_rel_v2025.1 |
| casperfpga | py38 | py312-dev at 4f64f93 |

Installed casperfpga version:
`0.4.4.dev1390+py312.dev.4f64f93`.

## Changes required

1. Migrate the legacy System Generator block to the Model Composer Hub
   using AMD's conversion function.
2. Replace the legacy RFSoC4x2 platform block with the RFSoC platform
   block and select the RFSoC4x2 device.
3. Guard CASPER GPIO and software-register mask rebuilding during
   platform-initiated Hub parameter scans.
4. Clear the conflicting AMD PYTHONHOME in the MATLAB process before
   selecting the CASPER Python virtual environment.
5. Use the system linker for simulation compilation because the bundled
   linker cannot process the system libraries' .relr.dyn sections.
6. Correct the RFSoC4x2 PS DDR row address count from 17 to 16.
7. Install backports.ssl_match_hostname in the separate casperfpga
   environment; it was missing after installing the project package.

The mask guard is a local workaround requiring further review.

## Validation results

| Check | Result |
|---|---|
| MATLAB startup and clean exit | Pass |
| Simulink library loading | Pass |
| C and C++ MEX compilation and execution | Pass |
| Model Composer and CASPER initialization | Pass |
| Migrated basic platform model update | Pass |
| Short model simulation | Pass |
| Addition: 10 + 20 = 30 | Pass |
| Addition: 0 + 0 = 0 | Pass |
| Addition: 12345 + 6789 = 19134 | Pass |
| Model Composer IP generation | Pass |
| Vivado synthesis, implementation and bitstream generation | Completed |
| Final specified timing constraints | Met |
| FPG configuration payload compared with XSA bitstream payload | Match |
| Updated PS DDR setting in XSA and initialization code | Confirmed |
| casperfpga dependency check and import | Pass |
| casperfpga offline FPG parsing | Pass |
| Device-tree generation command | Completed; resulting overlay empty |

Final timing report: WNS approximately +2.003 ns, WHS +0.027 ns.
Remaining tool and methodology warnings require review.

The offline FPG parser found ain, bin, sum_a_b, counter_ctrl,
counter_value and system registers.

## Limitations and remaining work

- No RFSoC board was available for hardware validation.
- Board boot, communication, programming and register access are untested.
- ADC/DAC, RFDC runtime control and Ethernet data transfer are untested.
- The generated 72-byte DTBO contains no device nodes; functional
  device-tree overlay validation has not been completed.
- Other tutorial models have not been validated.
- Scripts and migration steps still need consolidation and a fresh
  reproducibility check before becoming installation instructions.
