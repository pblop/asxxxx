cd %1
del /q *.db
rmdir /s /q .\debug
rmdir /s /q .\release
rmdir /s /q .\.vs\%1\FileContentIndex
del /q .\.vs\%1\v14\Browse.*
cd ..
