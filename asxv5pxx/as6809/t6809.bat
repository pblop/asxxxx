REM Explicit Direct Page
as6809 -loxff t6809_e
aslink -mxu t6809_e
asxscn t6809_e.lst
asxscn -i t6809_e.rst
REM Implicit Direct Page
as6809 -loxff t6809_i
aslink -mxu t6809_i
asxscn t6809_i.lst
asxscn -i t6809_i.rst

