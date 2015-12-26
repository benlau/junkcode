#-------------------------------------------------
#
# Project created by QtCreator 2015-12-27T03:07:29
#
#-------------------------------------------------

QT       += testlib gui quick

TARGET = tst_benchmarktests
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app
include(vendor/vendor.pri)

SOURCES += tst_benchmarktests.cpp
DEFINES += SRCDIR=\\\"$$PWD/\\\"

DISTFILES += \
    pageLoading/main.qml \
    pageLoading/Page1.qml
