set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

mkdir builddir
%PYTHON% -m mesonbuild.mesonmain setup %MESON_ARGS% builddir
if errorlevel 1 exit 1
