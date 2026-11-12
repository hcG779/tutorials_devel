# RFSoC 4x2 hardware validation — 2026-11-12

## Artifact

- File: `rfsoc4x2_tut_platform_2026-11-11_1528.fpg`
- SHA256: `475a43da8971e96cf5da75e33071dd16cdb8afb8a851aca9164cdd0e230f11fe`
- Platform: RFSoC 4x2
- Client: Python 3.12.3, casperfpga py312-dev at 4f64f93

## Results

| Check | Result |
|---|---|
| FPG upload and programming | Passed |
| Running design and expected device list | Passed |
| Input register write and readback | Passed |
| Addition: 10 + 20 = 30 | Passed |
| Addition: 0 + 0 = 0 | Passed |
| Addition: 12345 + 6789 = 19134 | Passed |
| Counter enable and stop | Passed |
| Counter reset and zero hold | Passed |
| Repeated counter stop and reset | Passed |
| Final counter state | Stopped at zero |

`counter_ctrl` bit 0 controls enable; bit 1 controls reset.
Reset was tested with control value 3, then released with value 0.

## Client cleanup issue

The programming operation passed, but its subsequent disconnect raised
`KeyError: 9` in the katcp/Tornado cleanup path. Later arithmetic and
counter sessions disconnected successfully. The cause remains unresolved;
these later successes do not establish that the issue is fixed.

## Scope and limitations

This validates loading the existing compiled design and its basic register,
adder and counter functions. It does not validate manual model creation,
fresh-host installation, board image installation, boot configuration,
ADC/DAC, RFDC runtime control, high-speed Ethernet, counter frequency
accuracy, overflow boundaries or full CDC correctness.

No separate DTBO was supplied by the client during this programming test.
Functional device-tree overlay validation remains incomplete.

## Evidence

The accompanying logs retain the reported results and cleanup error.
Board IP addresses and the workstation home path have been replaced.
