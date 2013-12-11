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

set (FFT3D fft3dfurth.F fft3dlib.F)

set (VASP_INC
    base.inc      fock.inc    lattice.inc
    mpimy.inc  pm.inc      symbol.inc
    broyden.inc   gadget.inc  mgrid.inc
    nonl.inc   pseudo.inc  wave.inc
    constant.inc  hills.inc   mkpoints.inc
    nonlr.inc  setexm.inc
    )

set(VASP_SRC
    symmetry.F symlib.F   lattlib.F  random.F   
    base.F     mpi.F      smart_allocate.F      xml.F  
    constant.F jacobi.F   main_mpi.F  scala.F   
    asa.F      lattice.F  poscar.F   ini.F  mgrid.F  
    xclib.F  vdw_nl.F  xclib_grad.F 
    radial.F   pseudo.F   gridq.F     ebs.F  
    mkpoints.F wave.F     wave_mpi.F  wave_high.F  spinsym.F 
    nonl.F     nonlr.F    nonl_high.F dfast.F    choleski2.F 
    mix.F      hamil.F    xcgrad.F   xcspin.F    potex1.F   potex2.F  
    constrmag.F cl_shift.F relativistic.F LDApU.F 
    paw_base.F metagga.F  egrad.F    pawsym.F   pawfock.F  pawlhf.F   
    rhfatm.F  hyperfine.F paw.F   
    mkpoints_full.F       charge.F   Lebedev-Laikov.F  
    stockholder.F dipol.F    pot.F 
    dos.F      elf.F      tet.F      tetweight.F hamil_rot.F 
    chain.F    dyna.F     k-proj.F    sphpro.F    us.F  core_rel.F 
    aedens.F   wavpre.F   wavpre_noio.F broyden.F 
    dynbr.F    hamil_high.F  rmm-diis.F reader.F   
    writer.F   tutor.F xml_writer.F 
    brent.F    stufak.F   fileio.F   opergrid.F stepver.F  
    chgloc.F   fast_aug.F fock_multipole.F  fock.F  
    mkpoints_change.F sym_grad.F 
    mymath.F   internals.F npt_dynamics.F   dynconstr.F 
    dimer_heyden.F dvvtrajectory.F vdwforcefield.F 
    nmr.F      pead.F     subrot.F   subrot_scf.F 
    force.F    pwlhf.F    gw_model.F optreal.F  steep.F    
    davidson.F  david_inner.F 
    electron.F rot.F  electron_all.F shm.F    
    pardens.F  paircorrection.F 
    optics.F   constr_cell_relax.F   stm.F    finite_diff.F elpol.F    
    hamil_lr.F rmm-diis_lr.F  subrot_cluster.F subrot_lr.F 
    lr_helper.F hamil_lrf.F   elinear_response.F ilinear_response.F 
    linear_optics.F 
    setlocalpp.F  wannier.F electron_OEP.F electron_lhf.F twoelectron4o.F 
    mlwf.F     ratpol.F screened_2e.F wave_cacher.F chi_base.F wpot.F 
    local_field.F ump2.F ump2kpar.F fcidump.F ump2no.F 
    bse_te.F bse.F acfdt.F chi.F sydmat.F dmft.F 
    rmm-diis_mlr.F  linear_response_NMR.F wannier_interpol.F linear_response.F
    ${VASP_INC}
    ${FFT3D}
    )

set (srcdir ${srcdir}/vasp.5.3/)
add_prefix(VASP_SRC ${srcdir} "${VASP_SRC}")
add_prefix(VASP_INC ${srcdir} "${VASP_INC}")
add_prefix(FFT3D ${srcdir} "${FFT3D}")

add_library(vasp5 STATIC ${VASP_SRC})

add_executable(${VASP_BIN} ${srcdir}/main.F)
target_link_libraries(${VASP_BIN}
    vasp5
    dmy
    ${LAPACK_LIBRARIES}
    ${BLAS_LIBRARIES}
    )

install(TARGETS ${VASP_BIN}
    RUNTIME DESTINATION bin
    )

