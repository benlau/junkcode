QT       += core
QT       += testlib gui quick qml qmltest

TARGET = example
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

SOURCES += main.cpp

DEFINES += SRCDIR=\\\"$$PWD/\\\" BASEDIR=\\\"$$PWD/..\\\"
DEFINES += QUICK_TEST_SOURCE_DIR=\\\"$$PWD\\\"
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000


CONFIG += conan_basic_setup
include($$OUT_PWD/conanbuildinfo.pri)

