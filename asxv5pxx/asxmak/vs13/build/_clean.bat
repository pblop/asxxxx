@echo off
REM _clean.bat
REM   Remove all build files.
REM   Remove all executable files.
REM

if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
goto ASXXXX

:ALL
call _prep
del /q ..\exe\*.exe
goto EXIT

:ASXXXX
if not exist %1 then goto ERROR
call _prep %1
del /q ..\exe\%1.exe
goto EXIT

:ERROR
echo.
echo _clean - Cleans the ASxxxx Assemblers, Linker, and Utilities.
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

