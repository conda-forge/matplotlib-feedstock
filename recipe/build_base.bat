@echo on

mkdir builddir

%PYTHON% -m mesonbuild.mesonmain setup builddir %MESON_ARGS% ^
    -Dsystem-freetype=true -Dsystem-libraqm=true -Dsystem-qhull=true
if %ERRORLEVEL% NEQ 0 (type builddir\meson-logs\meson-log.txt && exit 1)

%PYTHON% -m build --wheel ^
         --no-isolation --skip-dependency-check -Cbuilddir=builddir -Ccompile-args=-v
if %ERRORLEVEL% NEQ 0 exit 1

%PYTHON% -m pip install --find-links dist matplotlib
if %ERRORLEVEL% NEQ 0 exit 1
