#-------------------------------------------------
#
# Project created by QtCreator 2016-02-25T18:56:34
#
#-------------------------------------------------

QT       += testlib qml

TARGET = PROJECT
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

SOURCES += \
    main.cpp \
    tests.cpp

DEFINES += SRCDIR=\\\"$$PWD/\\\" QUICK_TEST_SOURCE_DIR=\\\"$$PWD/qmltests\\\"

include(vendor/vendor.pri)

DISTFILES += \
    qpm.json \
    qmltests/tst_QmlTests.qml

HEADERS += \
    tests.h

