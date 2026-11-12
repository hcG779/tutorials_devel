Tested RFSoC 4x2 Environment
========================================

This page lists the environment validated for the RFSoC 4x2 basic platform
workflow. It does not establish compatibility for other boards or every
RFSoC tutorial.

Software versions
------------------------

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Component
     - Tested version
   * - Operating system
     - ``Ubuntu 24.04.5 LTS``
   * - MATLAB / Simulink
     - ``R2025a Update 1``
   * - Vivado
     - ``2025.1``
   * - Model Composer
     - ``2025.1``
   * - Python
     - ``3.12.3``
   * - CASPER toolflow
     - ``mlib_devel`` based on ``m2025a``, with required fixes
   * - Board control library
     - ``casperfpga`` branch ``py312-dev``, commit ``4f64f93``

Required configuration
----------------------------

* Use the ``mlib_devel`` fixes recorded at commit
  ``57de773c9d2b073e6d9a447481bb484f6522e8cb``.
* Configure ``startsg.local`` for the installed tools and build environment.
* Keep the CASPER build and ``casperfpga`` Python environments separate.
* Clear the conflicting ``PYTHONHOME`` before selecting Python in MATLAB.
* Use the scoped system-linker override provided by the simulation runner.

The version list alone is insufficient to reproduce the tested setup.
The repository runners apply additional configuration described in
:doc:`tutorials/rfsoc/upgrade_2025`.

What has been validated
----------------------------

* MATLAB, Model Composer and CASPER initialization.
* Migration and diagram update of the basic platform model.
* Three arithmetic simulation cases.
* Model Composer IP generation.
* Vivado synthesis, implementation and bitstream generation.
* Final specified timing constraints met.
* ``casperfpga`` import, offline file parsing and board connection.
* Loading the generated ``.fpg`` on the RFSoC 4x2.
* Input register write/readback and three hardware addition cases.
* Counter enable, stop, reset and zero hold.

Remaining validation
----------------------------

Basic programming, register access, addition and counter control passed
on 2026-11-12. Counter frequency accuracy and overflow boundaries remain
untested. ADC/DAC operation and Ethernet data transfer remain unverified.

An initial disconnect raised ``KeyError: 9`` in the client cleanup path.
Later test sessions disconnected normally; the cause remains unresolved.
Timing methodology warnings and full clock-domain-crossing correctness
still require review. The generated device-tree overlay is empty.

A fresh installation on another host has not yet been reproduced.
This workflow currently documents the tested workstation configuration.

Continue with :doc:`tutorials/rfsoc/upgrade_2025`.

Update information
----------------------------

Version comparisons and upgrade history are in
:doc:`environment-update-notes`, separate from the operating instructions.

.. toctree::
   :hidden:

   environment-update-notes
