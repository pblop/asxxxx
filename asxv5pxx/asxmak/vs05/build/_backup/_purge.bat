cd %1
del /q *.ncb
del /q *.user
rmdir /s /q .\debug
rmdir /s /q .\release
cd ..
