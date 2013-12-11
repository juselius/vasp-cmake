include(AddPrefix)

set(CMAKE_Fortran_FORMAT FREE)

set (srcdir ${CMAKE_SOURCE_DIR}/src/)

add_subdirectory(vasp.5.lib)
add_subdirectory(vasp.5.3)
