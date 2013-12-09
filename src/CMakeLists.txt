set (VASP_BIN vasp)
if (NGXhalf)
    set (VASP_BIN "${VASP_BIN}_NGXhalf")
    add_definitions(-DNGXhalf)
endif()
if (wNGXhalf)
    set (VASP_BIN "${VASP_BIN}_wNGXhalf")
    add_definitions(-DwNGXhalf)
endif()
if (tbdyn)
    set (VASP_BIN "${VASP_BIN}_tbdyn")
    add_definitions(-Dtbdyn)
endif()

if (ENABLE_MPI)
    set (VASP_BIN "${VASP_BIN}.mpi")
else()
    set (VASP_BIN "${VASP_BIN}.bin")
endif()

include_directories(
    ${LAPACK_INCLUDE_DIRS}
    ${BLAS_INCLUDE_DIRS}
    )
set (FFT3D fft3dfurth.F90 fft3dlib.F90)

add_library(vasp5 STATIC 
    symmetry.F90 symlib.F90 lattlib.F90 random.F90 base.F90 mpi.F90
    smart_allocate.F90 xml.F90 constant.F90 jacobi.F90 main_mpi.F90 scala.F90
    asa.F90 lattice.F90 poscar.F90 ini.F90 mgrid.F90 xclib.F90 vdw_nl.F90
    xclib_grad.F90 radial.F90 pseudo.F90 gridq.F90 ebs.F90 mkpoints.F90
    wave.F90 wave_mpi.F90 wave_high.F90 nonl.F90 nonlr.F90 nonl_high.F90
    dfast.F90 choleski2.F90 mix.F90 hamil.F90 xcgrad.F90 xcspin.F90 potex1.F90
    potex2.F90 constrmag.F90 cl_shift.F90 relativistic.F90 LDApU.F90
    paw_base.F90 metagga.F90 egrad.F90 pawsym.F90 pawfock.F90 pawlhf.F90
    rhfatm.F90 paw.F90 mkpoints_full.F90 charge.F90 Lebedev-Laikov.F90
    stockholder.F90 dipol.F90 pot.F90 dos.F90 elf.F90 tet.F90 tetweight.F90
    hamil_rot.F90 steep.F90 chain.F90 dyna.F90 sphpro.F90 us.F90 core_rel.F90
    aedens.F90 wavpre.F90 wavpre_noio.F90 broyden.F90 dynbr.F90 rmm-diis.F90
    reader.F90 writer.F90 tutor.F90 xml_writer.F90 brent.F90 stufak.F90
    fileio.F90 opergrid.F90 stepver.F90 chgloc.F90 fast_aug.F90 fock.F90
    mkpoints_change.F90 sym_grad.F90 mymath.F90 internals.F90 dynconstr.F90
    dimer_heyden.F90 dvvtrajectory.F90 vdwforcefield.F90 hamil_high.F90
    nmr.F90 pead.F90 mlwf.F90 subrot.F90 subrot_scf.F90 force.F90 pwlhf.F90
    gw_model.F90 optreal.F90 davidson.F90 david_inner.F90 electron.F90 rot.F90
    electron_all.F90 shm.F90 pardens.F90 paircorrection.F90 optics.F90
    constr_cell_relax.F90 stm.F90 finite_diff.F90 elpol.F90 hamil_lr.F90
    rmm-diis_lr.F90 subrot_cluster.F90 subrot_lr.F90 lr_helper.F90
    hamil_lrf.F90 elinear_response.F90 ilinear_response.F90 linear_optics.F90
    linear_response.F90 setlocalpp.F90 wannier.F90 electron_OEP.F90
    electron_lhf.F90 twoelectron4o.F90 ratpol.F90 screened_2e.F90
    wave_cacher.F90 chi_base.F90 wpot.F90 local_field.F90 ump2.F90 bse_te.F90
    bse.F90 acfdt.F90 chi.F90 sydmat.F90 dmft.F90 rmm-diis_mlr.F90
    linear_response_NMR.F90 spinsym.F90 mgrid.F90 fock_multipole.F90
    hyperfine.F90 wannier_interpol.F90 k-proj.F90 ${FFT3D}
    )

add_executable(${VASP_BIN} main.F90)
target_link_libraries(${VASP_BIN}
    vasp5 
    dmy
    ${LAPACK_LIBRARIES}
    ${BLAS_LIBRARIES}
    )

install(TARGETS ${VASP_BIN}
    RUNTIME DESTINATION bin
#    CONFIGURATIONS Release
    )

