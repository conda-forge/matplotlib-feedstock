#!/bin/bash

set -ex

export AR=$GCC_AR

# binary is called `pkg-config`, but package metadata is under `lib/pkgconfig`
export MESON_ARGS="${MESON_ARGS} --pkg-config-path=${PREFIX}/lib/pkgconfig"
export MESON_ARGS="${MESON_ARGS} -Dsystem-freetype=true -Dsystem-qhull=true"

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup builddir $MESON_ARGS
cat builddir/meson-logs/meson-log.txt
$PYTHON -m build --wheel \
        --no-isolation --skip-dependency-check -Cbuilddir=builddir
$PYTHON -m pip install --find-links dist matplotlib
