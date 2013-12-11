set(VASPLIB_SRC
    timing_.c derrf_.c dclock_.c
    diolib.F dlexlib.F drdatab.F
    preclib.F linpack_double.f lapack_atlas.f
)

set (srcdir ${CMAKE_SOURCE_DIR}/src/vasplib)
add_prefix(VASPLIB_SRC ${srcdir} "${VASPLIB_SRC}")

add_library(dmy STATIC ${VASPLIB_SRC})

install(TARGETS dmy
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    )
