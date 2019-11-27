#!/bin/bash

if [ $(uname) == Linux ]; then
    pushd ${PREFIX}/lib
    ln -s libtcl8.6.so libtcl.so
    ln -s libtk8.6.so libtk.so
    popd
fi

cat <<EOF > setup.cfg
[directories]
basedirlist = $PREFIX

[packages]
tests = False
toolkit_tests = False
sample_data = False

[libs]
system_freetype = True

EOF

cat setup.cfg

$PYTHON -m pip install . --no-deps -vv
