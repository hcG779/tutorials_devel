Historical tutorial environment
===============================

.. note::

   The table below preserves the original tutorial environment information.
   It does not describe the results of the newer RFSoC 4x2 evaluation.
   Consult the validation report for the tested scope and remaining work.

   `RFSoC 4x2 upgrade validation report <https://github.com/hcG779/tutorials_devel/blob/docs/rfsoc-2025-upgrade/upgrade-audit/rfsoc-2025/README.md>`__

The recommended OS is Ubuntu (currently 20.04) as it is what the majority of the collaboration are using. This makes it easier for us to support you. If you are so inclined, you could also use Red Hat, but we definitely do not support Windows. You are welcome to try but you will be on your own. You could always run Linux in a VM although this will increase your compile times.

The current compatibility matrix of software needed to run these tutorials is below:

(Note that official support for ROACH plaforms is no longer provided, however `this version <https://github.com/casper-astro/mlib_devel/tree/d77999047d2f0dc53e1c1e6e516e6ef3cdd45632/docs>`__ of `mlib_devel` contains all ROACH related documentation and ROACH tutorials can be found `here <https://casper-tutorials.readthedocs.io/en/latest/tutorials/roach/tut_intro.html>`__)

+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|  Hardware      |   Operating System  |    Matlab Version  |    Xilinx Version  |    mlib_devel branch / commit   |   Python Version  |
+================+=====================+====================+====================+=================================+===================+
|ROACH1/2        | Ubuntu 14.04        |  2013b             |  ISE 14.7          |  branch: `roach`                |   Python 2.7      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|SKARAB          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|SNAP            | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|Red Pitaya      | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU216          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU208          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU111          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|PYNQ RFSoC 4x2  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|HTG ZRF16-29DR  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|HTG ZRF16-49DR  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+

Instructions on setting up an environment in which to run these tutorials can be found `here <https://github.com/casper-astro/tutorials_devel/blob/workshop2019/README.md>`__. Instructions on setting up the toolflow-proper can be found `here <https://casper-toolflow.readthedocs.io/en/latest/index.html>`__.

Modifications to be run after installs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**ROACH1/2**

Xilinx removed support for several hardware pcores we use for ROACH1/2 from ISE 14. So the current solution is to add the following pcores from the Xilinx 11 install to your `XPS_ROACH_BASE/pcores` folder or to your 14 install directory at `Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcore`.

`OPB pcores <https://www.dropbox.com/s/eq57n5td37yrwma/pcores_for_ise13.zip?dl=1>`__

* bram_if_cntlr_v1_00_a
* bram_if_cntlr_v1_00_b
* ipif_common_v1_00_c
* opb_arbiter_v1_02_e
* opb_bram_if_cntlr_v1_00_a
* opb_ipif_v3_00_a
* opb_opb_lite_v1_00_a
* opb_v20_v1_10_c
* proc_common_v1_00_a
