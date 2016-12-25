#-------------------------------------------------
#
# Project created by QtCreator 2016-12-26T01:33:14
#
#-------------------------------------------------

QT       += testlib qml qmltest

TARGET = tst_qtbug57545test
CONFIG   += console
CONFIG   -= app_bundle
CONFIG += warn_on qmltestcase

TEMPLATE = app

IMPORTPATH = $$PWD

SOURCES += \
    main.cpp
DEFINES += SRCDIR=\\\"$$PWD/\\\"

DISTFILES += \
    tst_Array.qml
