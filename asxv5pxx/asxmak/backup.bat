ECHO OFF
REM
REM CYGWIN
REM
cd cygwin\build
copy /Y /V /A *.bat .\_backup
copy /Y /V /A makefile .\_backup
cd ..\..\
cd cygwin\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM DJGPP
REM
cd djgpp\build
copy /Y /V /A *.bat .\_backup
copy /Y /V /A makefile .\_backup
cd ..\..\
cd djgpp\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM LINUX
REM
cd linux\build
copy /Y /V /A *.bat .\_backup
copy /Y /V /A makefile .\_backup
cd ..\..\
cd linux\misc
copy /Y /V /A *.* .\_backup
cd ..\..\
REM
REM SYMANTEC
REM
cd symantec\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd symantec\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM TURBOC30
REM
cd turboc30\build
copy /Y /V /A *.bat .\_backup
copy /Y /V /A makefile .\_backup
cd ..\..\
cd turboc30\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VC6
REM
cd vc6\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vc6\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS05
REM
cd vs05\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs05\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS10
REM
cd vs10\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs10\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS13
REM
cd vs13\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs13\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS15
REM
cd vs15\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs15\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS19
REM
cd vs19\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs19\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM VS22
REM
cd vs22\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd vs22\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
REM
REM WATCOM
REM
cd watcom\build
copy /Y /V /A *.bat .\_backup
cd ..\..\
cd watcom\misc
copy /Y /V /A *.bat .\_backup
cd ..\..\
