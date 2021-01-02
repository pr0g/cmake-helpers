include(GNUInstallDirs)

function(include_and_install_header_only)
    target_include_directories(
        ${ARGV0}
        INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
                  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)
    install(
        TARGETS ${ARGV0}
        EXPORT ${ARGV0}-config)
    install(
        EXPORT ${ARGV0}-config
        NAMESPACE ${ARGV0}::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${ARGV0})
    install(
        DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${ARGV0}/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${ARGV0})
endfunction()
