@echo off
REM Note:
REM   This is NOT a real 'make' file, just an alias.
REM
REM This BATCH file assumes PATH includes smake.exe
REM

if %1.==/?. goto ERROR
if %1.==. goto ALL
if %1.==all. goto ALL
if %1.==clean. goto CLEAN
goto ASXXXX

:ALL
@echo on
smake /f as1802.mak
smake /f as2650.mak
smake /f as4040.mak
smake /f as430.mak
smake /f as6100.mak
smake /f as61860.mak
smake /f as6500.mak
smake /f as6800.mak
smake /f as6801.mak
smake /f as6804.mak
smake /f as6805.mak
smake /f as6808.mak
smake /f as6809.mak
smake /f as6811.mak
smake /f as6812.mak
smake /f as6816.mak
smake /f as68cf.mak
smake /f as68k.mak
smake /f as740.mak
smake /f as78k0.mak
smake /f as78k0s.mak
smake /f as8008.mak
smake /f as8008s.mak
smake /f as8048.mak
smake /f as8051.mak
smake /f as8085.mak
smake /f as8x300.mak
smake /f as8xcxxx.mak
smake /f as89lp.mak
smake /f asavr.mak
smake /f ascheck.mak
smake /f ascop4.mak
smake /f ascop8.mak
smake /f asez8.mak
smake /f asez80.mak
smake /f asf2mc8.mak
smake /f asf8.mak
smake /f asgb.mak
smake /f ash8.mak
smake /f asm8c.mak
smake /f aspdp11.mak
smake /f aspic.mak
smake /f asrab.mak
smake /f asrs08.mak
smake /f asscmp.mak
smake /f asst6.mak
smake /f asst7.mak
smake /f asst8.mak
smake /f assx.mak
smake /f asz8.mak
smake /f asz80.mak
smake /f asz280.mak
smake /f aslink.mak
smake /f asxcnv.mak
smake /f asxscn.mak
smake /f s19os9.mak
@echo off
goto EXIT

:ASXXXX
@echo on
smake /f %1.mak
@echo off
goto EXIT

:CLEAN
del ..\exe\*.exe
del *.obj
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

