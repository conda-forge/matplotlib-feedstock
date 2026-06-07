@echo on

mkdir builddir
if errorlevel 1 exit 1
%PYTHON% -m mesonbuild.mesonmain setup builddir %MESON_ARGS% ^
    -Dsystem-freetype=true -Dsystem-libraqm=true -Dsystem-qhull=true
%PYTHON% -m build --wheel ^
         --no-isolation --skip-dependency-check -Cbuilddir=builddir -Ccompile-args=-v
if errorlevel 1 exit 1
%PYTHON% -m pip install --find-links dist matplotlib
if errorlevel 1 exit 1
