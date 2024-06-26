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

$PYTHON -m pip install --no-deps --no-build-isolation -vv . --config-settings=setup-args="-Dsystem-freetype=true"
