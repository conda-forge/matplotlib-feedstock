#!/bin/bash
set -ex

export AR=$GCC_AR

# binary is called `pkg-config`, but package metadata is under `lib/pkgconfig`
export MESON_ARGS="${MESON_ARGS} --pkg-config-path=${PREFIX}/lib/pkgconfig"
export MESON_ARGS="${MESON_ARGS} -Dsystem-freetype=true -Dsystem-qhull=true"

# meson-python already sets up a -Dbuildtype=release argument to meson, so
# we need to strip --buildtype out of MESON_ARGS or fail due to redundancy
MESON_ARGS_REDUCED="$(echo $MESON_ARGS | sed 's/--buildtype release //g')"

# -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir \
    -Csetup-args=${MESON_ARGS_REDUCED// / -Csetup-args=} \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)

$PYTHON -m pip install --find-links dist matplotlib
