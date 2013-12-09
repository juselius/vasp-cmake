#!/bin/bash

src() {
    d=../../vasp

    for i in $d/*.F; do
        j=`basename $i .F`.F90
        [ -e $j ] || ln -sf $i $j 
    done

    [ -e fft3dsimple.F90 ] && mv fft3dsimple.F90 fft3dsimple.F
}

include() {
    d=../../vasp

    for i in $d/*.inc; do
        j=`basename $i`
        [ -e $j ] || ln -sf $i $j 
    done
}

lapack() {
    d=../../lapack

    for i in $d/*.f $d/*.c $d/*.h; do
        j=`basename $i`
        [ -e $j ] || ln -sf $i .
    done

    for i in $d/*.F; do
        j=`basename $i .F`.F90
        [ -e $j ] || ln -sf $i $j 
    done
}

for i in src include lapack; do
    cd $i
    $i
    cd ..
done

