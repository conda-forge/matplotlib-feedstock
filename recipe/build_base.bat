set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

REM Fix linking to incompatible static library
del %LIRBARY_LIB%\libpng16_static.lib

ECHO [directories] > setup.cfg
ECHO basedirlist = %LIBRARY_PREFIX% >> setup.cfg
ECHO [packages] >> setup.cfg
ECHO tests = False >> setup.cfg
ECHO sample_data = False >> setup.cfg
ECHO toolkits_tests = False >> setup.cfg
ECHO staticbuild = False >> setup.cfg

%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
