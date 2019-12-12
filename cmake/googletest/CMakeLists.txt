# Assuming this your tests/CMakeLists.txt (and your libs are setup in a root config)
# Just make sure to include(CTest) in your *root* cmake config.

# 3.9 adds support for "GoogleTest" which enumerates the tests inside
# of the code and adds them to ctest.
cmake_minimum_required(VERSION 3.9)
project(myTests)

set (CMAKE_CXX_STANDARD 11)

# Configure google-test as a downloadable library.
include(External_GTest.cmake)

add_executable(myTests
    src/main.cpp)

# This will automatically handle all of the lib linkage and include dirs
target_link_libraries(myTests
    ${GTEST_LIBRARY}
)

add_dependencies(myTests ${GTEST_LIBRARY})

# Tell ctest about my tests
include(GoogleTest)
gtest_add_tests(
    TARGET      myTests
    TEST_LIST   myTests_targets
)

# set each target to timeout if not finished within 10 sec
set_tests_properties(${myTests_targets} PROPERTIES TIMEOUT 10)
