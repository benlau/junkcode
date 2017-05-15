TEMPLATE = app

QT += qml quick
CONFIG += c++11

QT += quick qml multimedia

include(MYTARGET.pri)

SOURCES += main.cpp

ROOTDIR = $$PWD/../..

# Default rules for deployment.
include(deployment.pri)
include(vendor/vendor.pri)

DISTFILES +=     qpm.json

