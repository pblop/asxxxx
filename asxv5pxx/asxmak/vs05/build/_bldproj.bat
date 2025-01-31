cd %1
@echo on
%VC$BUILD% /rebuild %1.vcproj "Release|Win32"
@echo off
cd ..
