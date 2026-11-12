RFSoC 2025 Environment Update Notes
==========================================

This page records the environment comparison and upgrade evaluation.
For the environment used by the current workflow, see :doc:`environment`.

Choose an environment for your platform and check its validation scope.
The newer environment below has been evaluated with one RFSoC 4x2 basic
platform design. It is not a compatibility claim for every CASPER tutorial.

Environment profiles
--------------------

.. list-table::
   :header-rows: 1
   :widths: 24 22 24 30

   * - Component
     - Original RFSoC tutorial
     - Upgrade evaluation
     - Notes
   * - Ubuntu
     - 18.04 / 20.04
     - 24.04.5 LTS
     - Tested workstation
   * - MATLAB / Simulink
     - R2021a
     - R2025a Update 1
     - Legacy models require migration
   * - Vivado / Model Composer
     - 2021.1
     - 2025.1
     - Local compatibility fixes required
   * - mlib_devel
     - m2021a
     - m2025a-based branch
     - Includes local fixes
   * - Python
     - Python 3
     - 3.12.3
     - Separate build and control environments
   * - casperfpga
     - py38
     - py312-dev at 4f64f93
     - Import, offline parsing and board connection tested

Validation scope
----------------

.. list-table::
   :header-rows: 1
   :widths: 35 20 45

   * - Check
     - Status
     - Scope
   * - Toolchain startup
     - Passed
     - MATLAB, Model Composer and CASPER initialization
   * - Model migration
     - Passed
     - Original RFSoC 4x2 platform model converted and updated
   * - Arithmetic simulation
     - Passed
     - Three addition cases; counter behavior not yet tested
   * - Model Composer IP generation
     - Passed
     - Repository frontend runner
   * - FPGA build
     - Passed
     - Synthesis, implementation and bitstream generation
   * - Final timing
     - Constraints met
     - Remaining methodology warnings require review
   * - Board connection
     - Passed
     - Network reachability and casperfpga connection only
   * - Board programming and register access
     - Pending
     - Generated design has not been validated on hardware
   * - ADC/DAC and Ethernet data transfer
     - Pending
     - Not covered by the basic platform validation
   * - Device-tree overlay
     - Incomplete
     - Generated overlay is empty
   * - Fresh installation on another host
     - Pending
     - Shared-host reproducibility has not been established

Using the upgrade evaluation
----------------------------

The upgrade requires model migration, local toolflow fixes and environment
configuration. Installing the listed software versions alone does not
reproduce the validated workstation.

See the `upgrade validation report
<https://github.com/hcG779/tutorials_devel/blob/docs/rfsoc-2025-upgrade/upgrade-audit/rfsoc-2025/README.md>`__
for source revisions, required changes and known limitations.

The repository also contains `migration, simulation and build tools
<https://github.com/hcG779/tutorials_devel/tree/docs/rfsoc-2025-upgrade/upgrade-audit/rfsoc-2025/tools>`__.
Review their configuration before running them.

Historical environments
-----------------------

The original compatibility table and installation notes are retained in
:doc:`environment-legacy`. Historical entries describe the original
documentation; they have not all been retested during this evaluation.

.. toctree::
   :hidden:

   environment-legacy
