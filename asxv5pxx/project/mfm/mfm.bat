del *.hex
del *.hlr
del *.lst
del *.map
del *.rel
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaoxff mfm
as89lp -lgaoxff sp0_x
as89lp -lgaoxff print
as89lp -lgaoxff macros
as89lp -lgaoxff mondeb51
as89lp -lgaoxff xhelp
as89lp -lgaoxff lbsfr
as89lp -lgaoxff fpga
as89lp -lgaoxff btcs
as89lp -lgaoxff timers
as89lp -lgaoxff mfmide
as89lp -lgaoxff spchr
as89lp -lgaoxff ideblk
as89lp -lgaoxff dskcfg
as89lp -lgaoxff aiconv
as89lp -lgaoxff debug
GOTO LINK
:NoGlobals
as89lp -loxff mfm
as89lp -loxff sp0_x
as89lp -loxff print
as89lp -loxff macros
as89lp -loxff mondeb51
as89lp -loxff xhelp
as89lp -loxff lbsfr
as89lp -loxff fpga
as89lp -loxff btcs
as89lp -loxff timers
as89lp -loxff mfmide
as89lp -loxff spchr
as89lp -loxff ideblk
as89lp -loxff dskcfg
as89lp -loxff aiconv
as89lp -loxff debug
GOTO LINK
:LINK
aslink -f mfm

