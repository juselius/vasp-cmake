cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

project(VASP)
enable_language(Fortran)

set (PROJECT_VERSION_MAJOR 5)
set (PROJECT_VERSION_MINOR 3)
set (PROJECT_VERSION_PATCH 2)

option(ENABLE_BLAS "Use BLAS backend for linear algebra" ON)
option(ENABLE_LAPACK "Use LAPACK backend for linear algebra" ON)
option(ENABLE_MPI "Enable MPI parallelization" ON)
option(ENABLE_OPENMP "Enable OpenMP parallelization" OFF)
option(ENABLE_TESTS "Enable test suite" OFF)
#option(ENABLE_CODE_COVERAGE "Compile with code coverage turned on" OFF)

option(NGXhalf       "charge density   reduced in X direction" OFF)
option(wNGXhalf      "gamma point only reduced in X direction" OFF)
option(RPROMU_DGEMV  "use DGEMV instead of DGEMM in RPRO " OFF)
option(RACCMU_DGEMV  "use DGEMV instead of DGEMM in RACC " OFF)
option(tbdyn         "MD package of Tomas  Bucko" OFF)

include(ConfigProjectVersion)
include(ConfigSafeGuards)
include(UseGlobalBuildTree)
include(ConfigCompilerFlags)

#find_package(PythonInterp REQUIRED)

if (ENABLE_MPI)
    find_package(MPI)
    if (MPI_FOUND)
        set(HAVE_MPI TRUE)
        include_directories(${MPI_INCLUDE_PATH})
    endif()
endif ()

if (ENABLE_OPENMP)
    find_package(OpenMP)
    if (OPENMP_FOUND)
        set(HAVE_OPENMP TRUE)
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${OpenMP_C_FLAGS}")
    endif()
endif ()

if (ENABLE_BLAS)
    if (BLAS_TYPE)
        find_package(BLAS COMPONENTS ${BLAS_TYPE})
    else()
        find_package(BLAS)
    endif()
endif ()

if (ENABLE_LAPACK)
    if (LAPACK_TYPE)
        find_package(LAPACK COMPONENTS ${LAPACK_TYPE})
    else()
        find_package(LAPACK)
    endif()
endif ()

if (RPROMU_DGEMV)
    add_definitions(-DRPROMU_DGEMV)
endif()
if (RACCMU_DGEMV)
    add_definitions(-DRACCMU_DGEMV)
endif()

#add_subdirectory(lapack)
add_subdirectory(vasp)

if (ENABLE_TESTS)
    set (PROJECT_REPOSITORY "https://git.example.com/example")
    include(ConfigTesting)
    add_subdirectory(testing)
endif()

#include(ConfigGitRevision)

configure_file (
    ${PROJECT_SOURCE_DIR}/config.h.in
    ${PROJECT_BINARY_DIR}/config.h
    )

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY
    "VASP - The Vienna Ab initio Simulation Package")
set(CPACK_PACKAGE_VENDOR "Institut fuer Materialphysik, Uni Wien, Austria")
set(CPACK_PACKAGE_CONTACT "Georg Kresse <Georg.Kresse@univie.ac.at>")
set(CPACK_PACKAGE_EXECUTABLES "vasp.mpi" "Description")
set(CPACK_PACKAGE_URL "http://www.vasp.at")
set(CPACK_PACKAGE_DESCRIPTION_FILE ${CMAKE_CURRENT_SOURCE_DIR}/INFO.rst)
set(CPACK_RESOURCE_FILE_README ${CMAKE_CURRENT_SOURCE_DIR}/README.rst)
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/COPYING)
set(CPACK_GENERATOR TGZ DEB RPM)
include(ConfigPackaging)

# vim:ft=cmake
