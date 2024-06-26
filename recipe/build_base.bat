set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

ECHO [directories] > mplsetup.cfg
ECHO basedirlist = %LIBRARY_PREFIX% >> mplsetup.cfg
ECHO [packages] >> mplsetup.cfg
ECHO tests = False >> mplsetup.cfg
ECHO sample_data = False >> mplsetup.cfg
ECHO toolkits_tests = False >> mplsetup.cfg

set MPLSETUPCFG=mplsetup.cfg

mkdir builddir
%PYTHON% -m mesonbuild.mesonmain setup %MESON_ARGS% builddir
if errorlevel 1 exit 1
