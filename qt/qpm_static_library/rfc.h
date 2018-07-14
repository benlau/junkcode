/**
RFC: A Mechanism to prevent the function in Q_COREAPP_STARTUP_FUNCTION to be discarded when building as a static link library

Using a QML library from qpm package system could be painful if it is built as a static link library. Because the Q_COREAPP_STARTUP_FUNCTION will not be working due to the optimization from the compiler.

It is an RFC to propose a mechanism to resolve the problem.

#define USE_LIBRARY(name) \
    do { extern void __3rdparty_qt_static_library_entry_ ## name(); \
         __3rdparty_qt_static_library_entry_ ## name(); } while (0)

In the library side:

static void init() {
    qmlRegisterSingletonType<xxx>(...);
    qmlRegisterType<xxx>(...);
}

DECLARE_LIBRARY(YourLibrary, init)
Q_COREAPP_STARTUP_FUNCTION(init)

In somewhere out of the static library (may be main.cpp):

#define DECLARE_LIBRARY(name, init) void __3rdparty_qt_static_library_entry_ ## name() {init();}

#define USE_LIBRARY(name) \
    do { extern void __qt_library_entry_## name();       \
         __qt_library_entry_## name(); } while (0)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    USE_LIBRARY(YourLibrary);
}

 */


#pragma once

#define USE_LIBRARY(name) \
    do { extern void __3rdparty_qt_static_library_entry_ ## name(); \
         __3rdparty_qt_static_library_entry_ ## name(); } while (0)

#define DECLARE_LIBRARY(name, init) void __3rdparty_qt_static_library_entry_ ## name() {init();}

