#!/bin/bash

set -ex

export AR=$GCC_AR

export MESON_ARGS="${MESON_ARGS} --buildtype=release -Dsystem-freetype=true -Dsystem-qhull=true"

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup builddir $MESON_ARGS
$PYTHON -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
$PYTHON -m pip install dist/matplotlib*.whl
