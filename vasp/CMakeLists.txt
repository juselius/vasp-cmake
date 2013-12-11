include(AddPrefix)

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
    ${../src}
    )
set (FFT3D fft3dfurth.F fft3dlib.F)

#add_subdirectory(vasplib)

set(VASP_SRC
    base.inc      fock.inc    lattice.inc
    mpimy.inc  pm.inc      symbol.inc
    broyden.inc   gadget.inc  mgrid.inc
    nonl.inc   pseudo.inc  wave.inc
    constant.inc  hills.inc   mkpoints.inc
    nonlr.inc  setexm.inc
    acfdt.F		     fock_multipole.F	    pseudo.F
    aedens.F	     force.F		    pwlhf.F
    asa.F		     ftflop.F		    radial.F
    base.F		     gadget.F		    random.F
    brent.F		     gridq.F		    ratpol.F
    broyden.F	     gw_model.F		    reader.F
    bse.F		     hamil.F		    relativistic.F
    bse_te.F	     hamil_high.F	    rhfatm.F
    chain.F		     hamil_lr.F		    rmm-diis.F
    charge.F	     hamil_lrf.F	    rmm-diis_lr.F
    chgloc.F	     hamil_rot.F	    rmm-diis_mlr.F
    chi_base.F	     hessian.F		    rot.F
    chi.F		     hyperfine.F	    scala.F
    choleski2.F	     ilinear_response.F     screened_2e.F
    cl_shift.F	     ini.F		    setex.F
    constant.F	     internals.F	    setlocalpp.F
    constr_cell_relax.F  jacobi.F		    shm.F
    constrmag.F	     k-proj.F		    smart_allocate.F
    core_rel.F	     lattice.F		    sphpro.F
    david_inner.F	     lattlib.F		    spinsym.F
    davidson.F	     LDApU.F		    steep.F
    dfast.F		     Lebedev-Laikov.F	    step.F
    dgemmtest.F	     linear_optics.F	    stepprecor.F
    dimer_heyden.F	     linear_response.F	    stepver.F
    dipol.F		     linear_response_NMR.F  stm.F
    dmft.F		     local_field.F	    stockholder.F
    dos.F		     lr_helper.F	    stufak.F
    dvvtrajectory.F      main.F		    subrot_cluster.F
    dyna.F		     main_mpi.F		    subrot.F
    dynbr.F		     makeparam.F	    subrot_lr.F
    dynconstr.F	     metagga.F		    subrot_scf.F
    ebs.F		     mgrid.F		    sydmat.F
    edtest.F	     mix.F		    sym_grad.F
    egrad.F		     mkpoints_change.F	    symlib.F
    electron_all.F	     mkpoints.F		    symmetry.F
    electron.F	     mkpoints_full.F	    tet.F
    electron_lhf.F	     mlwf.F		    tetweight.F
    electron_OEP.F	     mp2.F		    tutor.F
    elf.F		     mpi.F		    twoelectron4o.F
    elinear_response.F   music.F		    ump2.F
    elpol.F		     mymath.F		    ump2kpar.F
    fast_aug.F	     nmr.F		    ump2no.F
    fcidump.F	     nonl.F		    us.F
    fft3dcray.F	     nonl_high.F	    vdwforcefield.F
    fft3dessl.F	     nonlr.F		    vdw_nl.F
    fft3dessl+furth.F    npt_dynamics.F	    wannier.F
    fft3dfujitsu.F	     opergrid.F		    wannier_interpol.F
    fft3dfurth.F	     optengines.F	    wave_cacher.F
    fft3dfurth_f77.F     optics.F		    wave.F
    fft3dlib.F	     optreal.F		    wave_high.F
    fft3dlib_f77.F	     paircorrection.F	    wave_mpi.F
    fft3dnec.F	     pardens.F		    wavpre.F
    fft3dsimple.F	     paw_base.F		    wavpre_noio.F
    fftmpi.F	     paw.F		    wpot.F
    fftmpi_map.F	     pawfock.F		    writer.F
    fftmpiw.F	     pawlhf.F		    xcgrad.F
    ffttest.F	     pawsym.F		    xclib.F
    fftw3d.F	     pead.F		    xclib_grad.F
    fftw3d+furth.F	     poscar.F		    xcspin.F
    fileio.F	     potex1.F		    xml.F
    finite_diff.F	     potex2.F		    xml_writer.F
    fock.F		     pot.F		    zgemmtest.F
    ${FFT3D}
    )

set (srcdir ../src)
add_prefix(VASP_SRC ${srcdir} "${VASP_SRC}")

add_library(vasp5 STATIC ${VASP_SRC})

add_executable(${VASP_BIN} ${srcdir}/main.F)
target_link_libraries(${VASP_BIN}
    vasp5
#    dmy
    ${LAPACK_LIBRARIES}
    ${BLAS_LIBRARIES}
    )

install(TARGETS ${VASP_BIN}
    RUNTIME DESTINATION bin
    )

