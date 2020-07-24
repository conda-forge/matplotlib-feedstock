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
ECHO [libs] >> setup.cfg
ECHO system_freetype = False >> setup.cfg

rem Unpack cached copy of freetype 2.6.1 source
%PYTHON% -c "import os,tarfile;os.makedirs('build', exist_ok=True);tgz = tarfile.open(os.environ['RECIPE_DIR'] + '/freetype-2.6.1.tar.bz2', mode='r:bz2');tgz.extractall('build')"

%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
