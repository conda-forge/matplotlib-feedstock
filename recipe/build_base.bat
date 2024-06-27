@echo on

set "MESON_ARGS=%MESON_ARGS% --buildtype=release --prefix=%LIBRARY_PREFIX% --pkg-config-path=%LIBRARY_LIB%\pkgconfig -Dlibdir=bin -Dsystem-freetype=true -Dsystem-qhull=true"

mkdir builddir
if errorlevel 1 exit 1
%PYTHON% -m mesonbuild.mesonmain setup builddir %MESON_ARGS%
if errorlevel 1 exit 1
%PYTHON% -m build --wheel --no-isolation --skip-dependency-check -Cbuilddir=builddir
if errorlevel 1 exit 1
%PYTHON% -m pip install --find-links dist matplotlib
if errorlevel 1 exit 1
