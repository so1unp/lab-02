# Laboratorio 2 - Llamadas al Sistema

En este laboratorio vamos a ver las llamadas al sistema relacionadas con archivos. Además, se verá la implementación de las llamadas al sistema en _xv6_.

_Nota_: las respuestas a las preguntas en los ejercicios pueden incluirlas en un archivo de texto con el nombre `respuestas.txt`.

:calendar: Fecha de entrega: 09/04

## Ejercicio 1

El programa `hola.c` imprime el mensaje `¡Hola Mundo!` en la _salida estándar_, utilizando la función de biblioteca [`printf()`](http://man7.org/linux/man-pages/man3/printf.3.html).

Compilar el programa (`make hola`) y ejecutarlo utilizando el comando `strace`, como se indica a continuación, para ver cuales son llamadas al sistema que utiliza:

```bash
$ make hola
$ strace bin/hola > /dev/null
```

**Nota**: `> /dev/null` redirije la _salida estándar_ de `bin/hola` al archivo especial del sistema `/dev/null`, que descarta todo lo que se escriba en el mismo. Así se evita que la salida del comando `hola` se mezcle con la de `strace`.

Responder:

1. Identificar que llamadas al sistema utilizan las funciones de biblioteca `printf()` y `exit()`.
2. Describir los parámetros que se utilizan en la invocación de la llamada al sistema que se encarga de imprimir el mensaje en la _salida estándar_.

## Ejercicio 2 - Uso de las llamadas al sistema para archivos

Completar el programa `copy.c` para que permita realizar una copia de un archivo:

```bash
$ copy archivo-origen archivo-destino
```

Para implementarlo se deben utilizar **únicamente** las siguientes llamadas al sistema:

* [`open()`](http://man7.org/linux/man-pages/man2/open.2.html)
* [`read()`](http://man7.org/linux/man-pages/man2/read.2.html)
* [`write()`](http://man7.org/linux/man-pages/man2/write.2.html)
* [`close()`](http://man7.org/linux/man-pages/man2/close.2.html)

Se deben tener en cuenta las siguientes consideraciones:

* Si `archivo-origen` no existe, el programa debe notificar el error al usuario y terminar la ejecución. Se debe indicar al entorno que el programa falló, retornando `EXIT_FAILURE`.
* Si `archivo-destino` ya existe, se trunca.
* Los permisos de `archivo-destino` deben ser `0644`.

## Ejercicio 3 - Traza de llamadas al sistema

En este ejercicio, se modificara el _kernel_ de _xv6_ para que imprima un mensaje cada vez que se invoca una llamada al sistema. Este mensaje indicará el nombre de la llamada al sistema ejecutada y el valor que retorna.

Para esto, se debe modificar la función `syscall()` en el archivo `syscall.c`. Esta función es ejecutada por el _xv6_ cuando se detecta que una _interrupción por software_ ha sido generada desde un proceso de usuario.

Una vez hecha la modificación, al compilar y ejecutar _xv6_ en QEMU se tendría que ver algo similar a esto:

```bash
xv6...
cpu0: starting
sys_fstat -> 0
sys_write -> -1
...
sys_write -> 1
sys_fork -> 2
sys_exec -> 0
sys_open -> 3
sys_close -> 0
$sys_write -> 1
 sys_write -> 1
```

Las últimas lineas muestran como el proceso `init` crea y ejecuta el programa `sh` (el interprete de comandos) y luego `sh` escribiendo el símbolo `$` (el _prompt_ o símbolo de sistema).

### Entrega

Agregar en el repositorio del Laboratorio un archivo de texto con el resultado de ejecutar el comando `echo hola` y una explicación de por que se invocan las llamadas al sistema que aparecen.

## Ejercicio 4 - Implementar una nueva llamada al sistema

Este ejercicio vamos a modificar nuevamente el _kernel_ de a _xv6_, para agregar una **nueva llamada al sistema**.

La nueva llamada al sistema deberá retornar al usuario el sentido de la vida, el universo y todo lo demás: el número **42**.

Para realizar la implementación, utilizar como base el código fuente de alguna otra llamada al sistema ya existente, como por ejemplo `sys_uptime()` o `sys_getpid()`.

Para probar la nueva llamada al sistema, usar el archivo `answer.c`, que invoca la llamada al sistema e imprime el resultado.  Copiar el archivo en el directorio de *xv6*. Luego, agregar `answer.c` a la lista `UPROGS` del `Makefile` para que sea compilado como un programa de usuario.

### Entrega

Agregar en el directorio del Laboratorio un archivo de texto donde se explique brevemente las modificaciones realizadas en cada uno de los archivos de _xv6_ que hayan modificado. Recordar utilizar `git add` para agregar el archivo al _commit_.

### Adicional

Implementar otra llamada al sistema que retorne al usuario la fecha UTC actual del sistema.

Para leer el reloj del sistema y obtener la fecha UTC, hay que usar la función auxiliar `cmostime()`, implementada en el archivo `lapic.c`. Esta función requiere como parámetro un puntero a una estructura `struct rtcdate`, definida en el archivo `date.h`.

Para probar la nueva llamada al sistema, usar el archivo `date.c` como base para un programa que invoca la llamada al sistema e imprime por la salida estándar la fecha UTC.


---

¡Fin del Laboratorio 2!
