include(GNUInstallDirs)

# Set include paths for the installed library
function(thh_internal_install_include_dirs project_name)
    target_include_directories(
        ${project_name} INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
endfunction()

# Copy include files for the installed library
function(thh_internal_install_include_files project_name)
    install(
        DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${project_name}/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${project_name})
endfunction()

# Specify the target to install and set the export name
function(thh_internal_install_header_only_export project_name config_name)
    install(
        TARGETS ${project_name}
        EXPORT ${config_name}-config)
endfunction()

# Associate installed target files with the export, and then install the export
function(thh_internal_install_config_simple project_name config_name)
    install(
        EXPORT ${config_name}-config
        NAMESPACE ${project_name}::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${config_name})
endfunction()

# Specify the target to install and set the export name
# Also specify where the .lib file should be installed
function(thh_internal_install_static_export project_name config_name)
    install(
        TARGETS ${project_name}
        EXPORT ${config_name}-config
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
endfunction()

# Associate installed target files with the export, and then install the export
# Also install the <config>-targets.cmake file that includes library dependencies
function(thh_internal_install_config_advanced project_name config_name)
    install(
        EXPORT ${config_name}-config
        NAMESPACE ${project_name}::
        FILE ${config_name}-targets.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${config_name})
endfunction()

# Install the user-defined config file
function(thh_internal_install_config_file config_name)
    configure_file(
        ${config_name}-config.cmake.in ${config_name}-config.cmake @ONLY)
    install(
        FILES "${CMAKE_CURRENT_BINARY_DIR}/${config_name}-config.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${config_name})
endfunction()

# Install for header-only libraries with no dependencies
# <name>-config.cmake file will be generated
function(thh_install_header_only_no_dependencies project_name)
    thh_internal_install_include_dirs(${project_name})
    thh_internal_install_include_files(${project_name})
    thh_internal_install_header_only_export(${project_name} ${project_name})
    thh_internal_install_config_simple(${project_name} ${project_name})
endfunction()

# Install for static libraries with no dependencies
# <name>-config.cmake file will be generated
function(thh_install_static_no_dependencies project_name)
    thh_internal_install_include_dirs(${project_name})
    thh_internal_install_include_files(${project_name})
    thh_internal_install_static_export(${project_name} ${project_name})
    thh_internal_install_config_simple(${project_name} ${project_name})
endfunction()

# Install for header-only libraries with dependencies
# <name>-config.cmake must be provided and include dependencies (use
# include(CMakeFindDependencyMacro) and find_dependency)
function(thh_install_header_only_with_dependencies project_name config_name)
    thh_internal_install_include_dirs(${project_name})
    thh_internal_install_include_files(${project_name})
    thh_internal_install_header_only_export(${project_name} ${config_name})
    thh_internal_install_config_advanced(${project_name} ${config_name})
    thh_internal_install_config_file(${config_name})
endfunction()

# Install for static libraries with dependencies
# <name>-config.cmake must be provided and include dependencies (use
# include(CMakeFindDependencyMacro) and find_dependency)
function(thh_install_static_with_dependencies project_name config_name)
    thh_internal_install_include_dirs(${project_name})
    thh_internal_install_include_files(${project_name})
    thh_internal_install_static_export(${project_name} ${config_name})
    thh_internal_install_config_advanced(${project_name} ${config_name})
    thh_internal_install_config_file(${config_name})
endfunction()
