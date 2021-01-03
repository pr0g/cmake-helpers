# Accepts a single argument, the path to the library in active development.
# This will configure, build and install the library.
# Notes:
# 1. `execute_process` runs at configure time so you must run the configure
#    step from the application folder to have these operations execute.
function(install_it)
    execute_process(
        COMMAND cmake -S . -B build -DCMAKE_INSTALL_PREFIX=./install
        WORKING_DIRECTORY ${ARGV0})
    execute_process(
        COMMAND cmake --build build --target install
        WORKING_DIRECTORY ${ARGV0})
endfunction()
