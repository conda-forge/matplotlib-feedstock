#!/bin/bash

cat <<EOF > setup.cfg
[directories]
basedirlist = $PREFIX

[packages]
tests = False
toolkit_tests = False
sample_data = False

EOF

cat setup.cfg
sed -i.bak "s|/usr/local|${PREFIX}|" setupext.py

$PYTHON -m pip install . --no-deps -vv
