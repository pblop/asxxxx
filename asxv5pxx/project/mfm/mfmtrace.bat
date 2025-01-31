del *.hex
del *.hlr
del *.lst
del *.map
del *.rel
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaoxff -i ".trace" mfm
as89lp -lgaoxff -i ".trace" sp0_x
as89lp -lgaoxff -i ".trace" print
as89lp -lgaoxff -i ".trace" macros
as89lp -lgaoxff -i ".trace" mondeb51
as89lp -lgaoxff -i ".trace" xhelp
as89lp -lgaoxff -i ".trace" lbsfr
as89lp -lgaoxff -i ".trace" fpga
as89lp -lgaoxff -i ".trace" btcs
as89lp -lgaoxff -i ".trace" timers
as89lp -lgaoxff -i ".trace" mfmide
as89lp -lgaoxff -i ".trace" spchr
as89lp -lgaoxff -i ".trace" ideblk
as89lp -lgaoxff -i ".trace" dskcfg
as89lp -lgaoxff -i ".trace" aiconv
as89lp -lgaoxff -i ".trace" debug
GOTO LINK
:NoGlobals
as89lp -loxff -i ".trace" mfm
as89lp -loxff -i ".trace" sp0_x
as89lp -loxff -i ".trace" print
as89lp -loxff -i ".trace" macros
as89lp -loxff -i ".trace" mondeb51
as89lp -loxff -i ".trace" xhelp
as89lp -loxff -i ".trace" lbsfr
as89lp -loxff -i ".trace" fpga
as89lp -loxff -i ".trace" btcs
as89lp -loxff -i ".trace" timers
as89lp -loxff -i ".trace" mfmide
as89lp -loxff -i ".trace" spchr
as89lp -loxff -i ".trace" ideblk
as89lp -loxff -i ".trace" dskcfg
as89lp -loxff -i ".trace" aiconv
as89lp -loxff -i ".trace" debug
GOTO LINK
:LINK
aslink -f mfm

