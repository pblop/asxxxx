del *.hex
del *.hlr
del *.lst
del *.map
del *.rel
del *.rst
echo %1
if %1.==. goto NoGlobals
as89lp -lgaoxfftt mfm
as89lp -lgaoxfftt sp0_x
as89lp -lgaoxfftt print
as89lp -lgaoxfftt macros
as89lp -lgaoxfftt mondeb51
as89lp -lgaoxfftt xhelp
as89lp -lgaoxfftt lbsfr
as89lp -lgaoxfftt fpga
as89lp -lgaoxfftt btcs
as89lp -lgaoxfftt timers
as89lp -lgaoxfftt mfmide
as89lp -lgaoxfftt spchr
as89lp -lgaoxfftt ideblk
as89lp -lgaoxfftt dskcfg
as89lp -lgaoxfftt aiconv
as89lp -lgaoxfftt debug
GOTO LINK
:NoGlobals
as89lp -loxfftt mfm
as89lp -loxfftt sp0_x
as89lp -loxfftt print
as89lp -loxfftt macros
as89lp -loxfftt mondeb51
as89lp -loxfftt xhelp
as89lp -loxfftt lbsfr
as89lp -loxfftt fpga
as89lp -loxfftt btcs
as89lp -loxfftt timers
as89lp -loxfftt mfmide
as89lp -loxfftt spchr
as89lp -loxfftt ideblk
as89lp -loxfftt dskcfg
as89lp -loxfftt aiconv
as89lp -loxfftt debug
GOTO LINK
:LINK
aslink -f mfm

