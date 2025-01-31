del *.hex
del *.hlr
del *.lst
del *.map
del *.rel
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaoxfft mfm
as89lp -lgaoxfft sp0_x
as89lp -lgaoxfft print
as89lp -lgaoxfft macros
as89lp -lgaoxfft mondeb51
as89lp -lgaoxfft xhelp
as89lp -lgaoxfft lbsfr
as89lp -lgaoxfft fpga
as89lp -lgaoxfft btcs
as89lp -lgaoxfft timers
as89lp -lgaoxfft mfmide
as89lp -lgaoxfft spchr
as89lp -lgaoxfft ideblk
as89lp -lgaoxfft dskcfg
as89lp -lgaoxfft aiconv
as89lp -lgaoxfft debug
GOTO LINK
:NoGlobals
as89lp -loxfft mfm
as89lp -loxfft sp0_x
as89lp -loxfft print
as89lp -loxfft macros
as89lp -loxfft mondeb51
as89lp -loxfft xhelp
as89lp -loxfft lbsfr
as89lp -loxfft fpga
as89lp -loxfft btcs
as89lp -loxfft timers
as89lp -loxfft mfmide
as89lp -loxfft spchr
as89lp -loxfft ideblk
as89lp -loxfft dskcfg
as89lp -loxfft aiconv
as89lp -loxfft debug
GOTO LINK
:LINK
aslink -f mfm

