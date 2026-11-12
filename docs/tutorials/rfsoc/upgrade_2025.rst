RFSoC 4x2: 2025 Toolchain Workflow
==========================================

This workflow covers the existing RFSoC 4x2 basic platform model using
``MATLAB R2025a`` and ``AMD tools 2025.1``. It uses the migration and validation
scripts included in this repository.

.. important::

   This is a workstation-validated evaluation workflow, not a complete
   installation guide for a clean host. Simulation and FPGA compilation
   passed. Loading the generated design, register access, three addition
   cases and basic counter control also passed on the RFSoC 4x2.
   This does not establish that every hardware function has been tested.

Prerequisites
---------------------

Before running these commands, prepare:

* The evaluation environment described in :doc:`../../environment`.
* Installed and licensed ``MATLAB R2025a`` and ``Model Composer / Vivado 2025.1``.
* The ``mlib_devel`` compatibility fixes recorded in the
  `validation report <https://github.com/hcG779/tutorials_devel/blob/docs/rfsoc-2025-upgrade/upgrade-audit/rfsoc-2025/README.md>`__.
* A configured ``startsg.local`` selecting the ``MATLAB``, AMD tools and CASPER
  build Python environment.
* The original ``rfsoc/tut_platform/rfsoc4x2_tut_platform.slx`` model.

The default workstation layout is:

.. code-block:: text

   ~/Desktop/casper-tutorial-devel
   ~/Desktop/casper-mlib-m2025a
   ~/Desktop/casper-checks

For other layouts, configure ``CASPER_MLIB_DIR``, ``CASPER_LOCALDEFS`` and
``CASPER_CHECKS_DIR`` as described in the
`runner documentation <https://github.com/hcG779/tutorials_devel/tree/docs/rfsoc-2025-upgrade/upgrade-audit/rfsoc-2025/tools>`__.
Alternative path settings have not yet been validated.

Run the following commands in an Ubuntu terminal. The migration,
simulation and compilation runners work locally and do not connect
to or program a board.

.. _rfsoc-2025-step-1:

1. Migrate the original model
-------------------------------------

From the tutorial repository root:

.. code-block:: bash

   bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-migration.sh

The runner copies the original model into a new output directory,
converts the ``System Generator`` block to a ``Model Composer`` Hub, replaces
the legacy platform block, updates the diagram and saves the copy.
The original tutorial model is not modified.

Check for exit code 0 and all of these markers:

.. code-block:: text

   AMD_HUB_CONVERSION_PASS
   PLATFORM_MIGRATION_PASS
   HUB_MODEL_UPDATE_PASS
   MIGRATED_MODEL_SAVED: <generated model path>

Inspect the log for errors as well. Exit code 0 alone is insufficient:
an earlier diagnostic query printed ``ParamEvalDelete`` errors without
returning a failing exit code.

.. _rfsoc-2025-step-2:

2. Validate arithmetic in simulation
--------------------------------------------

.. code-block:: bash

   bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-simulation.sh

This runner migrates a fresh model copy and tests three addition cases:
10 + 20 = 30, 0 + 0 = 0, and 12345 + 6789 = 19134.

Expected final markers:

.. code-block:: text

   ARITHMETIC_CHECK_PASS
   REPOSITORY_SIMULATION_PASS

The test adds temporary logging branches in memory. They are not saved
to the model. Known warnings concern the unconnected ``gpio_ctr`` output
and direct connections from ``Model Composer`` outputs to Simulink logging
blocks.

This test does not establish counter behavior or overflow correctness.
Result filenames are reused; use a separate ``CASPER_CHECKS_DIR`` to retain
results from different runs.

.. _rfsoc-2025-step-3:

3. Generate Model Composer IP
-------------------------------------

.. code-block:: bash

   bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-frontend.sh

This runner migrates another fresh model copy and generates its IP in
a separate build directory.

Check for exit code 0, ``IP_DESCRIPTOR_COUNT`` of at least 1, and
``REPOSITORY_FRONTEND_PASS``.

Record the path printed after ``FRONTEND_MODEL``. The next step must use
that exact generated model path.

.. _rfsoc-2025-step-4:

4. Build and package the FPGA design
--------------------------------------------

Replace the example model path below with ``FRONTEND_MODEL`` from step 3:

.. code-block:: bash

   bash upgrade-audit/rfsoc-2025/tools/run-rfsoc-backend.sh /absolute/path/to/model.slx

The backend runs CASPER middleware, ``Vivado`` synthesis and implementation,
bitstream generation and software packaging.

Expected final marker:

.. code-block:: text

   REPOSITORY_BACKEND_OUTPUTS_PASS

The runner checks that ``.bit``, ``.bin``, ``.xsa`` and ``.fpg`` outputs are nonempty.
It refuses a build directory that already contains ``myproj``. Generate a
new frontend build when a fresh backend run is needed.

.. _rfsoc-2025-step-5:

5. Review the build results
-----------------------------------

The output marker establishes file presence, not timing closure or
hardware correctness. Review ``repository-backend.log`` beside the generated
model and the final implementation reports.

The validated local build met its specified timing constraints:

* WNS: +2.003 ns.
* WHS: +0.027 ns.
* Zero setup, hold and pulse-width failing endpoints.

Final implementation reports confirmed asynchronous clock groups between
``clk_pl_0`` and ``pl_clk_mmcm`` in both directions. This does not establish
correct clock-domain-crossing circuitry.

AXI read-only parameter warnings and timing methodology warnings remain
recorded for review. The generated device-tree overlay was empty and
has not been validated as a functional overlay.

Hardware validation results
========================================

The generated ``.fpg`` was loaded successfully on the RFSoC 4x2 on
2026-11-12. The board reported a running design and the expected registers.

Validated hardware checks:

* Write and read back ``ain`` and ``bin``.
* Read ``sum_a_b`` and verify three cases:
  ``10 + 20 = 30``, ``0 + 0 = 0``, and ``12345 + 6789 = 19134``.
* Enable and stop the counter through ``counter_ctrl`` bit 0.
* Reset the counter through ``counter_ctrl`` bit 1, with enable asserted.
* Confirm repeated stop/reset behavior and zero hold.
* Leave the counter stopped at zero.

The first programming session reported a client disconnect error,
``KeyError: 9``, after programming had succeeded. The later arithmetic and
counter sessions disconnected successfully. The cleanup issue is recorded
and has not been established as fixed.

No separate ``.dtbo`` was supplied by the client during this programming
test. Functional device-tree overlay validation remains incomplete.

See the :download:`hardware validation report
<../../../upgrade-audit/rfsoc-2025/results/board-2026-11-12/README.md>`
for artifact identification, results and limitations.

Remaining work
------------------------

* Reproduce installation on a clean development host.
* Validate the manual design-creation sequence.
* Review timing methodology warnings and full CDC correctness.
* Test counter frequency accuracy and overflow boundaries.
* Validate ADC/DAC, RFDC runtime control and Ethernet data transfer.
* Validate board image installation and boot configuration separately.

For the original design concepts and block descriptions, see
:doc:`tut_platform`. Its complete manual sequence has not been revalidated
with the newer toolchain.
