/*
 * Este programa debe copiar un archivo en otro. Los archivos deben
 * ser indicados en la linea de comandos. Si el archivo origen no 
 * existe, se debe notificarlo y terminar. Si el archivo destino ya
 * existe, se debe sobreescribir. Los permisos en caso de crear el 
 * archivo destino deben ser 0644.
 *
 * Utilizar unicamente las siguientes llamadas al sistema:
 * - read(): lee bytes desde un descriptor de archivo. 
 * - open(): abre el archivo indicado.
 * - write(): escribe bytes en el descriptor de archivo indicado.
 * - close(): cierra el descriptor de archivo indicado.
 */

#include <stdio.h>
#include <stdlib.h>     // exit()

int main(int argc, char* argv[])
{

    // Termina la ejecución del programa.
    exit(EXIT_SUCCESS);
}
