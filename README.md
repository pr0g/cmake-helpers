# CMake Helpers

## Overview

`cmake-helpers` is a collection of useful CMake utilities projects can use to avoid repeated boilerplate code.

## Instructions

To use `cmake-helpers`, CMake's FetchContent is required.

Add this to your `CMakeLists.txt` file:

```cmake
include(FetchContent)

FetchContent_Declare(
    cmake-helpers
    GIT_REPOSITORY https://github.com/pr0g/cmake-helpers.git
    GIT_TAG        origin/main) # or a specific commit, likely safer...
FetchContent_MakeAvailable(cmake-helpers) # [1]
list(APPEND CMAKE_MODULE_PATH ${cmake-helpers_SOURCE_DIR})

include(simple-install) # bring a helper/utility file into scope
include_and_install_header_only(${PROJECT_NAME}) # use one of the utilities

# [1]
# Note: This can be used instead of FetchContent_MakeAvailable but it is only
# specifically needed in certain circumstances - see this link for more info:
# https://discourse.cmake.org/t/fetchcontent-with-loose-cmake-files/2451/4
FetchContent_GetProperties(cmake-helpers)
if(NOT cmake-helpers_POPULATED)
    FetchContent_Populate(cmake-helpers)
endif()
```
