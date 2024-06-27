#!/bin/bash

set -ex

export AR=$GCC_AR

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup builddir $MESON_ARGS --buildtype=release
$PYTHON -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
$PYTHON -m pip install dist/matplotlib*.whl
