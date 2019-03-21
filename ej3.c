//
// Laboratorio 2 -- Ejercicio 3
// El programa debe crear el número procesos hijos, indicado mediante un
// parámetro en la línea de comandos, utilizando la llamada al sistema 
// fork(). Cada proceso hijo debe imprimir por la salida estándar su 
// identificador de proceso (PID) y finalizar, mediante la llamada al 
// sistema exit(). Para obtener el PID emplear la llamada al sistema 
// getpid(). El proceso padre debe esperar a que todos sus procesos hijos 
// finalicen, y luego imprimir un mensaje. Utilizar la llamada al sistema 
// waitpid() para esperar a que los procesos hijos terminen.
//

#include <stdio.h>
#include <stdlib.h>

int var = 0;

int main(int argc, char* argv[])
{
    exit(EXIT_SUCCESS);
}
