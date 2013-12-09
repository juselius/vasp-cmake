add_library(dmy SHARED
    timing_.c derrf_.c dclock_.c 
    diolib.F90 dlexlib.F90 drdatab.F90 
    preclib.F90 linpack_double.f lapack_atlas.f
)

install(TARGETS dmy
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    #    CONFIGURATIONS Release
    )
