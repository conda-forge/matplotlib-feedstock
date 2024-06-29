@echo on

set "MESON_ARGS=%MESON_ARGS% --buildtype=release --prefix=%LIBRARY_PREFIX% --pkg-config-path=%LIBRARY_LIB%\pkgconfig -Dlibdir=lib -Dsystem-freetype=true -Dsystem-qhull=true"

if "%CI%" == "azure" (
    :: Hack to try removing problematic Python from Azure CI image
    :: Replace with conda-smithy solution when available
    :: xref: https://github.com/conda-forge/conda-smithy/pull/1966
    mkdir C:\empty
    robocopy /purge /r:0 /w:0 /mt /ns /nc /np /nfl /ndl /njh /njs C:\empty C:\hostedtoolcache\windows\Python > nul 2>&1
    rmdir /q C:\hostedtoolcache\windows\Python
    rmdir /q C:\empty
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
