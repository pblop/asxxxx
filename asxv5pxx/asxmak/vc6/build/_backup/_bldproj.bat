cd %1
@echo on
%MS$DEV% %1.dsw /MAKE "%1 - Win32 Release" /REBUILD /OUT %1.log
@echo off
type %1.log
cd ..

