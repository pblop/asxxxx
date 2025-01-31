as740 -loxff t740sym
REM Explicit Direct Page Addressing
as740 -loxff t740s_e
aslink -mxu t740s_e  t740s_e t740sym
asxscn t740s_e.lst
asxscn -i t740s_e.rst
REM Implicit Direct Page Addressing
as740 -loxff t740s_i
aslink -mxu t740s_i t740s_i t740sym
asxscn t740s_i.lst
asxscn -i t740s_e.rst


