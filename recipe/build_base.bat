@echo on

mkdir builddir
if errorlevel 1 exit 1
%PYTHON% -m mesonbuild.mesonmain setup builddir %MESON_ARGS% --buildtype=release
if errorlevel 1 exit 1
%PYTHON% -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
if errorlevel 1 exit 1
for %x in (dir *.whl) do (%PYTHON% -m pip install %x)
if errorlevel 1 exit 1
