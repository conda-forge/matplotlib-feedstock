set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%
rem Resolves MSB4175: The task factory "CodeTaskFactory" could not be loaded from the assembly
set VisualStudioVersion=

ECHO [directories] > setup.cfg
ECHO basedirlist = %LIBRARY_PREFIX% >> setup.cfg
ECHO [packages] >> setup.cfg
ECHO tests = False >> setup.cfg
ECHO sample_data = False >> setup.cfg
ECHO toolkits_tests = False >> setup.cfg
ECHO [test] >> setup.cfg
ECHO local_freetype = True >> setup.cfg

rem matplotlib will link to png, zlib statically if it exists. Replace the static library with shared
del %LIBRARY_LIB%\libpng16_static.lib
copy %LIBRARY_LIB%\libpng16.lib %LIBRARY_LIB%\libpng16_static.lib
del %LIBRARY_LIB%\zlibstatic.lib
copy %LIBRARY_LIB%\z.lib %LIBRARY_LIB%\zlibstatic.lib

%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
