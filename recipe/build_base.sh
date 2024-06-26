#!/bin/bash

export AR=$GCC_AR

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup $MESON_ARGS builddir
