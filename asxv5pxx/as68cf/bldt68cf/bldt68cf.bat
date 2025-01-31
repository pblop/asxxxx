as68cf -loxfft bldt68cf
aslink -nux -g xb=0 -g xw=0 -g xl=0 bldt68cf
asxcnv -4x bldt68cf.rst
copy /Y a.out t68cf.asm
del a.out
as68cf -loxt t68cf
aslink -nux -g xb=0 -g xw=0 -g xl=0 t68cf
asxscn -4x t68cf.rst
asxcnv -4x t68cf.rst

