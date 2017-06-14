
Step to reproduce
=================

1. Build

```
qmake
make
macdeployqt qtbug-40645.app -qmldir=`pwd`
codesign --deep -s - -f --entitlements entitlement.plist qtbug-40645.app
```

2. Run

```
./qtbug-40645.app/Contents/MacOS/qtbug-40645
```

