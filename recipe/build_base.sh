#!/bin/bash

set -ex

export AR=$GCC_AR

export MESON_ARGS="${MESON_ARGS} --buildtype=release"

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup builddir $MESON_ARGS
$PYTHON -m build \
        --wheel \
        --no-isolation \
        --skip-dependency-check \
        -Cbuilddir=builddir \
        -Csetup-args="-Dsystem-freetype=true" \
        -Csetup-args="-Dsystem-qhull=true" \

$PYTHON -m pip install dist/matplotlib*.whl
