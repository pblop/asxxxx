@echo off
REM _clean.bat
REM   Prepare all directories for distribution.
REM   (Executables Removed)
REM
REM   1)  ASXMAK Directories
REM   2)  Assembler, Test, Project Directories, and Monitors
REM
REM
REM   1)  ASXMAK Directories
cd asxmak\cygwin\build
call _clean.bat
cd ..\..\..\
cd asxmak\djgpp\build
call _clean.bat
cd ..\..\..\
cd asxmak\linux\build
call _clean.bat
cd ..\..\..\
cd asxmak\symantec\build
call _clean.bat
cd ..\..\..\
cd asxmak\turboc30\build
call _clean.bat
cd ..\..\..\
cd asxmak\vc6\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs05\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs10\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs13\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs15\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs19\build
call _clean.bat
cd ..\..\..\
cd asxmak\vs22\build
call _clean.bat
cd ..\..\..\
cd asxmak\watcom\build
call _clean.bat
cd ..\..\..\
REM
REM   2)  Assembler, Test, Project Directories, and Monitors
call _xasmbl.bat

