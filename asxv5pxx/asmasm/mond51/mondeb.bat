REM
REM mondeb.bat
REM
if %1.==. goto NoGlobals
REM Startup And Startup Support Functions
as89lp -lgaoxff startup
as89lp -lgaoxff sp0_x
as89lp -lgaoxff print
REM Macro Support Functions
as89lp -lgaoxff macros
REM Basic mondeb51 Monitor
as89lp -lgaoxff mondeb51
REM Optional Extended Help For mondeb51
as89lp -lgaoxff xhelp
REM Optional SFR Functions For mondeb51
as89lp -lgaoxff lbsfr
GOTO LINK
:NoGlobals
REM Startup And Startup Support Functions
as89lp -loxff startup
as89lp -loxff sp0_x
as89lp -loxff print
REM Macro Support Functions
as89lp -loxff macros
REM Basic mondeb51 Monitor
as89lp -loxff mondeb51
REM Optional Extended Help For mondeb51
as89lp -loxff xhelp
REM Optional SFR Functions For mondeb51
as89lp -loxff lbsfr
GOTO LINK
:LINK
aslink -f mondeb
copy mondeb.ihx mondeb.hex

