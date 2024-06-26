#!/bin/bash

set -ex

export AR=$GCC_AR

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup $MESON_ARGS builddir
$PYTHON -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
$PYTHON -m pip install dist/matplotlib*.whl
