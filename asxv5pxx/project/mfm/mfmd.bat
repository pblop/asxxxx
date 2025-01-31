del *.hex
del *.hlr
del *.lst
del *.map
del *.rel
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaoxff -i ".trace (mcr)" mfm
as89lp -lgaoxff -i ".trace (mcr)" sp0_x
as89lp -lgaoxff -i ".trace (mcr)" print
as89lp -lgaoxff -i ".trace (mcr)" macros
as89lp -lgaoxff -i ".trace (mcr)" mondeb51
as89lp -lgaoxff -i ".trace (mcr)" xhelp
as89lp -lgaoxff -i ".trace (mcr)" lbsfr
as89lp -lgaoxff -i ".trace (mcr)" fpga
as89lp -lgaoxff -i ".trace (mcr)" btcs
as89lp -lgaoxff -i ".trace (mcr)" timers
as89lp -lgaoxff -i ".trace (mcr)" mfmide
as89lp -lgaoxff -i ".trace (mcr)" spchr
as89lp -lgaoxff -i ".trace (mcr)" ideblk
as89lp -lgaoxff -i ".trace (mcr)" dskcfg
as89lp -lgaoxff -i ".trace (mcr)" aiconv
as89lp -lgaoxff -i ".trace (mcr)" debug
GOTO LINK
:NoGlobals
as89lp -loxff -i ".trace (mcr)" mfm
as89lp -loxff -i ".trace (mcr)" sp0_x
as89lp -loxff -i ".trace (mcr)" print
as89lp -loxff -i ".trace (mcr)" macros
as89lp -loxff -i ".trace (mcr)" mondeb51
as89lp -loxff -i ".trace (mcr)" xhelp
as89lp -loxff -i ".trace (mcr)" lbsfr
as89lp -loxff -i ".trace (mcr)" fpga
as89lp -loxff -i ".trace (mcr)" btcs
as89lp -loxff -i ".trace (mcr)" timers
as89lp -loxff -i ".trace (mcr)" mfmide
as89lp -loxff -i ".trace (mcr)" spchr
as89lp -loxff -i ".trace (mcr)" ideblk
as89lp -loxff -i ".trace (mcr)" dskcfg
as89lp -loxff -i ".trace (mcr)" aiconv
as89lp -loxff -i ".trace (mcr)" debug
GOTO LINK
:LINK
aslink -f mfm

