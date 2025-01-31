@echo off
REM _prep.bat
REM   Prepare all directories for distribution.
REM   (Executables Preserved)
REM
REM   1)  ASXMAK Directories
REM   2)  Assembler, Test, and Project Directories
REM
REM
REM   1)  ASXMAK Directories
cd asxmak\cygwin\build
call _prep.bat
cd ..\..\..\
cd asxmak\djgpp\build
call _prep.bat
cd ..\..\..\
cd asxmak\linux\build
call _prep.bat
cd ..\..\..\
cd asxmak\symantec\build
call _prep.bat
cd ..\..\..\
cd asxmak\turboc30\build
call _prep.bat
cd ..\..\..\
cd asxmak\vc6\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs05\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs10\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs13\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs15\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs19\build
call _prep.bat
cd ..\..\..\
cd asxmak\vs22\build
call _prep.bat
cd ..\..\..\
cd asxmak\watcom\build
call _prep.bat
cd ..\..\..\
REM
REM   2)  Assembler, Test, and Project Directories
call _xasmbl.bat

