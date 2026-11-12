CASPER Tutorials
================

Build FPGA signal-processing designs, explore supported platforms,
and work through practical tutorials.

Choose your platform
--------------------

.. container:: casper-card-grid

   .. container:: casper-platform-card

      **RFSoC**

      Learn the architecture, platform blocks, and RF data-converter workflow.

      :doc:`Explore RFSoC <tutorials/rfsoc/readme>`

   .. container:: casper-platform-card

      **SNAP**

      Start with Simulink, then explore Ethernet and signal processing.

      :doc:`Explore SNAP <tutorials/snap/tut_intro>`

   .. container:: casper-platform-card

      **SKARAB**

      Explore FPGA design, board interfaces, and spectrometer tutorials.

      :doc:`Explore SKARAB <tutorials/skarab/tut_intro>`

   .. container:: casper-platform-card

      **Red Pitaya**

      Start with the introductory design and continue to ADC/DAC tutorials.

      :doc:`Explore Red Pitaya <tutorials/redpitaya/tut_intro>`

:doc:`RFSoC 4x2: 2025 toolchain workflow <tutorials/rfsoc/upgrade_2025>`

Follow the five-step migration, simulation and build workflow. Basic board programming, register, adder and counter tests passed.

Before you start
----------------

:doc:`Check environment requirements and compatibility <environment>`
before following a tutorial. Software requirements and validation coverage
depend on the platform and toolchain.

.. toctree::
   :hidden:
   :caption: Setup

   environment

Tutorial Instructions
----------------------

If you are new to astronomy signal processing, here is `Tutorial 0: some basic introduction into astronomy signal processing. <https://github.com/SparkePei/tut0>`__ If you already have a lot of experience on it, you can go directly to the introduction tutorials below for CASPER FPGA design and implementation.

If you are a beginner, we recommend the Step-by-Step tutorials, however if you should get stuck, prefer a less tedious method of learning, or already have decent feel for these tools, links to Completed tutorials are available with commented models.

Vivado
^^^^^^^^^

**SNAP**

1. Introduction Tutorial: :doc:`Step-by-Step <tutorials/snap/tut_intro>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/vivado/snap/tut_intro>`_
2. 10GbE Tutorial: :doc:`Step-by-Step <tutorials/snap/tut_ten_gbe>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/vivado/snap/tut_tge>`__
3. Spectrometer Tutorial :doc:`Step-by-Step <tutorials/snap/tut_spec>` or  `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/vivado/snap/tut_spec>`__
4. Correlator Tutorial :doc:`Step-by-Step <tutorials/snap/tut_corr>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/vivado/snap/tut_corr>`__
5. Yellow Block Tutorial: :doc:`Bidirectional GPIO <tutorials/snap/tut_gpio_bidir>` 

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: SNAP Tutorials

   tutorials/snap/tut_intro
   tutorials/snap/tut_ten_gbe
   tutorials/snap/tut_spec
   tutorials/snap/tut_corr
   tutorials/snap/tut_gpio_bidir

**SKARAB**

1. Introduction Tutorial :doc:`Step-by-Step <tutorials/skarab/tut_intro>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/skarab/tut_intro>`__
2. 40GbE Tutorial :doc:`Step-by-Step <tutorials/skarab/tut_40gbe>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/skarab/tut_40gbe>`__
3. HMC Tutorial :doc:`Step-by-Step <tutorials/skarab/tut_hmc>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/skarab/tut_hmc>`__
4. Spectrometer Tutorials :doc:`Step-by-Step <tutorials/skarab/tut_spec/tut_spec_index>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/skarab/tut_spec>`__
5. :doc:`ADC Synchronous Data Acquisition Tutorials <tutorials/skarab/tut_adc/tut_adc_index>`

.. toctree::
   :maxdepth: 2
   :hidden:
   :caption: SKARAB Tutorials

   tutorials/skarab/tut_intro
   tutorials/skarab/tut_40gbe
   tutorials/skarab/tut_hmc
   tutorials/skarab/tut_spec/tut_spec_index  
   tutorials/skarab/tut_adc/tut_adc_index
   
**Red Pitaya**

1. :doc:`Guide to Setting Up Your New Red Pitaya <tutorials/redpitaya/red_pitaya_setup>` 
2. Introduction Tutorial :doc:`Step-by-Step <tutorials/redpitaya/tut_intro>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/red_pitaya/tut_intro>`__
3. ADC and DAC Interface Tutorial :doc:`Step-by-Step <tutorials/redpitaya/tut_adc_dac>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/red_pitaya/tut_adc_dac>`__
4. Spectrometer Tutorial :doc:`Step-by-Step <tutorials/redpitaya/tut_spec>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/red_pitaya/tut_spec>`__


.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Red Pitaya Tutorials

   tutorials/redpitaya/red_pitaya_setup 
   tutorials/redpitaya/tut_intro
   tutorials/redpitaya/tut_adc_dac
   tutorials/redpitaya/tut_spec

**RFSoC**

1. :doc:`CASPER RFSoC README <tutorials/rfsoc/readme>`
2. :doc:`Getting Started With RFSoC <tutorials/rfsoc/tut_getting_started>`
3. RFSoC Platform Yellow Block and Simulink Overview :doc:`Step-by-Step <tutorials/rfsoc/tut_platform>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/rfsoc/tut_platform>`__
4. Using the RFDC's ADC :doc:`Step-by-Step <tutorials/rfsoc/tut_rfdc>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/rfsoc/tut_rfdc>`__ 
5. Using the RFDC's DAC :doc:`Step-by-Step <tutorials/rfsoc/tut_dac>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/rfsoc/tut_dac>`__
6. Spectrometer Tutorial :doc:`Step-by-Step <tutorials/rfsoc/tut_spec>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/rfsoc/tut_spec>`__
7. 100 Gigabit Ethernet :doc:`Step-by-Step <tutorials/rfsoc/tut_100g>` or `Completed <https://github.com/casper-astro/tutorials_devel/tree/main/rfsoc/tut_onehundred_gbe>`__

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: RFSoC Tutorials

   tutorials/rfsoc/readme 
   tutorials/rfsoc/tut_getting_started
   tutorials/rfsoc/tut_platform
   tutorials/rfsoc/tut_rfdc
   tutorials/rfsoc/tut_dac
   tutorials/rfsoc/tut_spec
   tutorials/rfsoc/tut_100g

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Documentation

    CASPER Documentation <https://casper-toolflow.readthedocs.io/en/latest/index.html>
    AXI Documentation <https://casper-toolflow.readthedocs.io/en/latest/axi4lite_documentation.html>
    Block Documentation <https://casper-toolflow.readthedocs.io/en/latest/blockdocumentation.html>
    The CASPER Toolflow <https://casper-toolflow.readthedocs.io/en/latest/jasper_documentation.html>
    Toolflow Sourcecode <https://casper-toolflow.readthedocs.io/en/latest/src/jasper_library_modules/modules.html>
    casperfpga Sourcecode <https://casper-toolflow.readthedocs.io/projects/casperfpga/en/latest/>

ISE
^^^^^

**ROACH1/2**

1. :doc:`Introduction Tutorial <tutorials/roach/tut_intro>`
2. :doc:`10GbE Tutorial <tutorials/roach/tut_ten_gbe>`
3. :doc:`Spectrometer Tutorial <tutorials/roach/tut_spec>`
4. :doc:`Correlator Tutorial <tutorials/roach/tut_corr>`

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: ROACH Tutorials

   tutorials/roach/tut_intro
   tutorials/roach/tut_ten_gbe
   tutorials/roach/tut_spec
   tutorials/roach/tut_corr

**Board Info**

1. :doc:`RFSoC2x2 Board Info <tutorials/rfsoc/platforms/rfsoc2x2>`
2. :doc:`RFSoC4x2 Board Info <tutorials/rfsoc/platforms/rfsoc4x2>`
3. :doc:`ZCU111 Board Info <tutorials/rfsoc/platforms/zcu111>`
4. :doc:`ZCU208 Board Info <tutorials/rfsoc/platforms/zcu208>`
5. :doc:`ZCU216 Board Info <tutorials/rfsoc/platforms/zcu216>`
6. :doc:`ZRF16 Board Info <tutorials/rfsoc/platforms/zrf16>`

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Board Info

   tutorials/rfsoc/platforms/rfsoc2x2
   tutorials/rfsoc/platforms/rfsoc4x2
   tutorials/rfsoc/platforms/zcu111
   tutorials/rfsoc/platforms/zcu208
   tutorials/rfsoc/platforms/zcu216
   tutorials/rfsoc/platforms/zrf16
