# Laboratorio 2 - Llamadas al Sistema

En este laboratorio vamos a ver las llamadas al sistema, especialmente las relacionadas con archivos. Además, se verá la implementación de las llamadas al sistema en _xv6_.

## Ejercicio 1

El programa `hola.c` imprime el mensaje `¡Hola Mundo!` en la _salida estándar_ utilizando la función de biblioteca [`puts()`](http://man7.org/linux/man-pages/man3/puts.3.html).

Compilar el programa (`make hola`) y ejecutarlo mediante el comando `strace`, como se indica a continuación, para obtener las llamadas al sistema que utiliza durante su ejecución:

```bash
$ make hola
$ strace bin/hola > /dev/null
```

**Nota**: `> /dev/null` redirije la _salida estándar_ de `bin/hola` al archivo especial del sistema `/dev/null`, que descarta todo lo que se escriba en el mismo. De esta manera evitamos que la salida del comando `hola` se mezcle con la de `strace`.

Responder lo siguiente (en un archivo con nombre `ej1.txt`):

1. Identificar cuales son las llamadas al sistema que invocan las funciones de biblioteca `puts()` y `exit()`.
2. Describir los parámetros que utiliza la llamada al sistema invocada por `puts()`.

## Ejercicio 2 - llamadas al sistema para archivos

Completar el programa `scopy.c` para que permita realizar una copia del archivo indicado:

```bash
$ scopy archivo-origen archivo-destino
```

Para implementarlo se deben utilizar *únicamente* las siguientes llamadas al sistema:

* [`open()`](http://man7.org/linux/man-pages/man2/open.2.html)
* [`read()`](http://man7.org/linux/man-pages/man2/read.2.html)
* [`write()`](http://man7.org/linux/man-pages/man2/write.2.html)
* [`close()`](http://man7.org/linux/man-pages/man2/close.2.html)

Tener en cuenta:

* Se debe indicar al entorno el resultado de la ejecución del programa, retornando `EXIT_SUCCESS` o `EXIT_FAILURE`.
* Si los parámetros `archivo-origen` y `archivo-destino` no son indicados, se deben notificar el error al usuario y finalizar la ejecución.
* Si `archivo-origen` no existe, el programa debe notificar el error al usuario y terminar la ejecución.
* Si `archivo-destino` existe, el programa debe notificar al usuario y terminar la ejecución (no se sobreescribe el archivo).
* `archivo-destino` debe ser creado con permisos `0644`.
* Pueden evaluar su implementación ejecutando el _script_ `test.sh`.

## Ejercicio 3 - Traza de llamadas al sistema

En este ejercicio se modificara el _kernel_ de _xv6_ para que imprima un mensaje cada vez que se invoca una llamada al sistema. Este mensaje indicará la llamada al sistema que se ejecuta y el valor que retorna.

Se debe modificar la función `syscall()` en el archivo `syscall.c`. Esta función es ejecutada por _xv6_ cuando se detecta que una _interrupción por software_ ha sido generada desde un proceso de usuario.

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

Agregar en el repositorio del laboratorio un archivo de texto con el resultado de ejecutar el comando `echo hola` y una explicación de por que se invocan las llamadas al sistema que aparecen.

## Ejercicio 4 - Implementar una nueva llamada al sistema

En este ejercicio vamos a modificar el _kernel_ de _xv6_ para agregar una **nueva llamada al sistema** que retorne al usuario el número **42** (el sentido de la vida, el universo y todo lo demás).

Para realizar la implementación, utilizar como base el código fuente de alguna otra llamada al sistema ya existente, como por ejemplo `sys_uptime()` o `sys_getpid()`.

Para probar la nueva llamada al sistema, usar el archivo `answer.c`, que invoca la llamada al sistema e imprime el resultado.  Copiar el archivo en el directorio de *xv6*. Luego, agregar `answer.c` a la lista `UPROGS` del `Makefile` para que sea compilado como un programa de usuario.

### Entrega

Agregar en el directorio del Laboratorio un archivo de texto donde se explique brevemente las modificaciones realizadas en cada uno de los archivos de _xv6_ que hayan modificado. Recordar utilizar `git add` para agregar el archivo al _commit_.

---

¡Fin del Laboratorio 2!
