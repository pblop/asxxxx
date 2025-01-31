as68k -loxffct bldt68k
aslink -nux -g xb=0 -g xw=0 -g xl=0 bldt68k
asxcnv -4xn4 bldt68k.rst
copy /Y a.out t68k.asm
del a.out
as68k -loxffct t68k
aslink -nux -g xb=0 -g xw=0 -g xl=0 t68k
asxscn -4x t68k.rst
asxcnv -4xn4 t68k.rst

