#!/bin/bash

copy_result=false

if [ -f "bin/scopy" ]; then
    printf "Testing: bin/scopy\n"

    printf "\tProbando que verifique argumentos: "
    bin/scopy > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec1=true
    else
        printf "Error\n"
        exec1=false
    fi

    printf "\tProbando copia de un archivo: "
    bin/scopy scopy.c copia-de-scopy.c > /dev/null 2>&1
    diff="$(diff scopy.c copia-de-scopy.c 2>/dev/null)"
    if [ "$(echo $?)" = 0 ] && [ "$diff" = "" ] ; then
        printf "Ok\n"
        exec2=true
    else
        printf "Error\n"
        exec2=false
    fi

    printf "\tVerificando permisos del archivo nuevo: "
    perms=$(ls -l copia-de-scopy.c 2>/dev/null | awk '{print $1}')
    if [ "$(echo $?)" = 0 ] && [ "$perms" = "-rw-r--r--" ]; then
        printf "Ok\n"
        exec3=true
    else
        printf "Error\n"
        exec3=false
    fi
    rm -f copia-de-scopy.c > /dev/null 2>&1

    printf "\tVerificando que no sobreescribe archivo destino: "
    echo "abc" > prueba1.txt
    echo "xyz" > prueba2.txt
    bin/scopy prueba1.txt prueba2.txt > /dev/null 2>&1
    if [ "$(diff prueba1.txt prueba2.txt)" = "" ]; then
        printf "Error\n"
        exec4=false
    else
        printf "Ok\n"
        exec4=true
    fi
    rm -f prueba1.txt prueba2.txt > /dev/null 2>&1

    printf "\tProbando copiar un archivo que no existe: "
    bin/scopy no-existes.c copia-de-no-existes.c > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec5=true
    else
        printf "Fallo\n"
        exec5=false
    fi
    rm -f copia-de-no-existes.c > /dev/null 2>&1

    printf "\tProbando copiar un archivo a un directorio sin permisos: "
    bin/scopy scopy.c /scopy.c > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec6=true
    else
        printf "Fallo\n"
        exec6=false
    fi

    if $exec1 && $exec2 && $exec3 && $exec4 && $exec5 && $exec6; then
        copy_result=true
    fi
else
    printf "Error: scopy.c no esta compilado.\n"
fi

if $copy_result ; then
    exit 0
else
    exit 1
fi

