#!/bin/bash

set -ex

export AR=$GCC_AR

export MESON_ARGS="${MESON_ARGS} --buildtype=release --prefix=${PREFIX} -Dlibdir=lib --pkg-config-path=${PREFIX}/lib/pkgconfig -Dsystem-freetype=true -Dsystem-qhull=true"

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup builddir $MESON_ARGS \
        || (cat builddir/meson-logs/meson-log.txt && exit 1)
$PYTHON -m build --wheel \
        --no-isolation --skip-dependency-check -Cbuilddir=builddir
$PYTHON -m pip install --find-links dist matplotlib
