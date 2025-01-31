del *.hex
del *.hlr
del *.lst
del *.map
del *.obj
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaxff -o+.obj mfm
as89lp -lgaxff -o+.obj sp0_x
as89lp -lgaxff -o+.obj print
as89lp -lgaxff -o+.obj macros
as89lp -lgaxff -o+.obj mondeb51
as89lp -lgaxff -o+.obj xhelp
as89lp -lgaxff -o+.obj lbsfr
as89lp -lgaxff -o+.obj fpga
as89lp -lgaxff -o+.obj btcs
as89lp -lgaxff -o+.obj timers
as89lp -lgaxff -o+.obj mfmide
as89lp -lgaxff -o+.obj spchr
as89lp -lgaxff -o+.obj ideblk
as89lp -lgaxff -o+.obj dskcfg
as89lp -lgaxff -o+.obj aiconv
as89lp -lgaxff -o+.obj debug
GOTO LINK
:NoGlobals
as89lp -lxff -o+.obj mfm
as89lp -lxff -o+.obj sp0_x
as89lp -lxff -o+.obj print
as89lp -lxff -o+.obj macros
as89lp -lxff -o+.obj mondeb51
as89lp -lxff -o+.obj xhelp
as89lp -lxff -o+.obj lbsfr
as89lp -lxff -o+.obj fpga
as89lp -lxff -o+.obj btcs
as89lp -lxff -o+.obj timers
as89lp -lxff -o+.obj mfmide
as89lp -lxff -o+.obj spchr
as89lp -lxff -o+.obj ideblk
as89lp -lxff -o+.obj dskcfg
as89lp -lxff -o+.obj aiconv
as89lp -lxff -o+.obj debug
GOTO LINK
:LINK
aslink -f mfmobj

