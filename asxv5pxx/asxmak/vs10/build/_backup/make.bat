@echo off
REM Note:
REM   This is NOT a real 'make' file, just an alias.
REM
if %VC$BUILD%.==MSBUILD. goto BUILD
REM
REM This BATCH file assumes Environment Variables need to be initialized.
REM
REM Running On A 32-Bit System
call "c:\Program Files\Microsoft Visual Studio 10.0\VC\bin\vcvars32.bat"
REM Running On A 64-Bit System
REM call "c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\vcvars32.bat"
REM
REM This definition is valid for Visual Studio 2010
REM installed in the default location.
REM
SET VC$BUILD=MSBUILD
REM

:BUILD
if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
if %1.==clean. goto EXIT
goto ASXXXX

:ALL
call _bldproj as1802
call _bldproj as2650
call _bldproj as4040
call _bldproj as430
call _bldproj as6100
call _bldproj as61860
call _bldproj as6500
call _bldproj as6800
call _bldproj as6801
call _bldproj as6804
call _bldproj as6805
call _bldproj as6808
call _bldproj as6809
call _bldproj as6811
call _bldproj as6812
call _bldproj as6816
call _bldproj as68cf
call _bldproj as68k
call _bldproj as740
call _bldproj as78k0
call _bldproj as78k0s
call _bldproj as8008
call _bldproj as8008s
call _bldproj as8048
call _bldproj as8051
call _bldproj as8085
call _bldproj as89lp
call _bldproj as8x300
call _bldproj as8xcxxx
call _bldproj asavr
call _bldproj ascheck
call _bldproj ascop4
call _bldproj ascop8
call _bldproj asez8
call _bldproj asez80
call _bldproj asf2mc8
call _bldproj asf8
call _bldproj asgb
call _bldproj ash8
call _bldproj asm8c
call _bldproj aspdp11
call _bldproj aspic
call _bldproj asrab
call _bldproj asrs08
call _bldproj asscmp
call _bldproj asst6
call _bldproj asst7
call _bldproj asst8
call _bldproj assx
call _bldproj asz8
call _bldproj asz80
call _bldproj asz280
call _bldproj aslink
call _bldproj asxcnv
call _bldproj asxscn
call _bldproj s19os9
goto EXIT

:ASXXXX
if not exist %1 goto ERROR
call _bldproj %1
goto EXIT

:ERROR
echo.
echo make - Compiles the ASxxxx Assemblers, Linker, and Utilities.
echo.
echo Valid arguments are:
echo --------  --------  --------  --------  --------  --------
echo all       ==        'blank'
echo --------  --------  --------  --------  --------  --------
echo as1802    as2650    as4040    as430     as6100    as61860
echo as6500    as6800    as6801    as6804    as6805    as6808
echo as6809    as6811    as6812    as6816    as68k     as68cf
echo as740     as78k0    as78k0s   as8008    as8008s   as8048
echo as8051    as8085    as89lp    as8x300   as8xcxxx  asavr
echo ascheck   ascop4    ascop8    asez8     asez80    asf2mc8
echo asf8      asgb      ash8      asm8c     aspdp11   aspic
echo asrab     asrs08    asscmp    asst6     asst7     asst8
echo assx      asz8      asz80     asz280
echo --------  --------  --------  --------  --------  --------
echo aslink    asxcnv    asxscn    s19os9
echo --------  --------  --------  --------  --------  --------
echo.
goto EXIT

:EXIT

