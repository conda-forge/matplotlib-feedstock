#!/bin/bash

cat <<EOF > conda_mpl_config.cfg
[directories]
basedirlist = $PREFIX

[packages]
tests = False
toolkit_tests = False
sample_data = False

EOF

cat conda_mpl_config.cfg

export MPLSETUPCFG=conda_mpl_config.cfg
export AR=$GCC_AR

mkdir builddir
$PYTHON -m mesonbuild.mesonmain setup $MESON_ARGS builddir
