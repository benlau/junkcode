Generate a batch file to build Qt applicaiton by command line
========

Open this project by Qt Creator (Windows), then press `Build` -> `Run qmake`.

It will generate a file called `qt.bat`.

Example of qt.bat:

```
set QT_DIR_BIN=C:\Qt\5.7\msvc2015\bin
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\
set PATH=%QT_DIR_BIN%;%VCINSTALLDIR%;%PATH%
```

It will set the PATH environment variable according to your Qt Creator's configuration. And now you could edit this file and add your own commands.
