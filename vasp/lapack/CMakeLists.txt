set(LAPACK_SRC
    timing_.c derrf_.c dclock_.c 
    diolib.F90 dlexlib.F90 drdatab.F90 
    preclib.F90 linpack_double.f lapack_atlas.f
)

set (srcdir ${CMAKE_SOURCE_DIR}/src/lapack)
add_prefix(LAPACK_SRC ${srcdir} ${LAPACK_SRC})

add_library(dmy SHARED ${LAPACK_SRC})

install(TARGETS dmy
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    #    CONFIGURATIONS Release
    )
