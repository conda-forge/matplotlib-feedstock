@echo on

set

set "MESON_ARGS=%MESON_ARGS% --buildtype=release --prefix=%LIBRARY_PREFIX% --pkg-config-path=%LIBRARY_LIB%\pkgconfig -Dlibdir=lib -Dsystem-freetype=true -Dsystem-qhull=true"

if "%CI%" == "azure" (
    :: Hack to try removing problematic Python from Azure CI image
    mkdir C:\empty
    robocopy /mir /ns /nc /nfl /ndl /np C:\empty C:\hostedtoolcache\windows\Python
    rmdir /q C:\empty
    rmdir /q C:\hostedtoolcache\windows\Python
)

mkdir builddir
if errorlevel 1 exit 1
%PYTHON% -m mesonbuild.mesonmain setup builddir %MESON_ARGS%
type builddir\meson-logs\meson-log.txt
%PYTHON% -m build --wheel ^
         --no-isolation --skip-dependency-check -Cbuilddir=builddir -Ccompile-args=-v
if errorlevel 1 exit 1
%PYTHON% -m pip install --find-links dist matplotlib
if errorlevel 1 exit 1
