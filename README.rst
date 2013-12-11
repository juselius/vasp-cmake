CMake for VASP
=================

This project provides CMake build support for VASP.

The project works with the unmodified VASP source distribution,
unpacked into the src/ directory. Please make sure to use the branch
corresponding to the actual version of VASP.

Quick install
---------------
To configure, build and install the package in the simplest manner::

    $ git checkout v5.3.3
    $ cd src
    $ tar vfxz /path/to/vasp.5.3.3.tzg
    $ tar vfxz /path/to/vasp.5.libs.tzg
    $ cd ..
    $ ./setup
    $ cd build
    $ make install

For detailed installation instructions see INSTALL.rst.
