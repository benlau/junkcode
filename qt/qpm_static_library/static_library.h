#pragma once

#define USE_LIBRARY(name) \
    do { extern void __3rdparty_qt_static_library_entry_ ## name(); \
         __3rdparty_qt_static_library_entry_ ## name(); } while (0)

#define DECLARE_LIBRARY(name) void __3rdparty_qt_static_library_entry_ ## name() {}

