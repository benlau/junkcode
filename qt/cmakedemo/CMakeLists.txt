cmake_minimum_required(VERSION 2.8.12)

project(cmakedemo LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

add_subdirectory(vendor/com/github/benlau/quickflux)

add_subdirectory(vendor/com/github/benlau/quickpromise)
get_directory_property(quickpromise_INCLUDE DIRECTORY vendor/com/github/benlau/quickpromise DEFINITION INCLUDE)
get_directory_property(quickpromise_SOURCES DIRECTORY vendor/com/github/benlau/quickpromise DEFINITION SOURCES)
get_directory_property(quickpromise_QRC DIRECTORY vendor/com/github/benlau/quickpromise DEFINITION QRC)

include_directories(${quickpromise_INCLUDE})

add_executable(${PROJECT_NAME} "main.cpp" "qml.qrc"
               ${quickpromise_SOURCES} ${quickpromise_QRC})

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick quickflux)
