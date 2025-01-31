del /Q *.lst
del /Q *.rel
del /Q *.sym
del /Q *.o
del /Q T11R.*
del /Q T11L.*
aspdp11 -lcqff -o+ t11L -i ".define .lst" t11
asxscn -q t11L.lst
aspdp11 -lcqff -o+ t11R -i ".define .rst" t11
aslink -nqu -g XA=0 t11R
asxscn -qi t11R.rst

