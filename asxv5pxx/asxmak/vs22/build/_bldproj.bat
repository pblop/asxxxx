cd %1
@echo on
%VC$BUILD% /p:Configuration=Release %1.vcxproj 
@echo off
cd ..
