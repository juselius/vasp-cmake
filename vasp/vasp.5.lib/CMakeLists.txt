set(VASPLIB_SRC
    timing_.c derrf_.c dclock_.c
    diolib.F dlexlib.F drdatab.F
    preclib.F linpack_double.f
)

set (srcdir ${srcdir}/vasp.5.lib)
add_prefix(VASPLIB_SRC ${srcdir} "${VASPLIB_SRC}")

set_source_files_properties(${srcdir}/linpack_double.f
    PROPERTIES Fortran_FORMAT FIXED
    )

add_library(dmy STATIC ${VASPLIB_SRC})

install(TARGETS dmy
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    )
