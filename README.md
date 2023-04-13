# OBSOLETO

Ver [Laboratorios](https://github.com/so1unp/laboratorios/).

# Laboratorio 2 - Llamadas al Sistema

En este laboratorio vamos a ver las llamadas al sistema, especialmente las relacionadas con archivos. Además, se verá la implementación de las llamadas al sistema en _xv6_.

## Ejercicio 1

El programa `hola.c` imprime el mensaje `¡Hola Mundo!` en la _salida estándar_ utilizando la función de biblioteca [`puts()`](http://man7.org/linux/man-pages/man3/puts.3.html).

Compilar el programa (`make hola`) y ejecutarlo mediante el comando `strace`, como se indica a continuación, para obtener las llamadas al sistema que utiliza durante su ejecución:

```console
$ make hola
$ strace bin/hola > /dev/null
```

**Nota**: `> /dev/null` redirije la _salida estándar_ de `bin/hola` al archivo especial del sistema `/dev/null`, que descarta todo lo que se escriba en el mismo. De esta manera evitamos que la salida del comando `hola` se mezcle con la de `strace`.

Responder lo siguiente:

1. ¿Cuantas llamadas al sistema invoca el programa?
2. Identificar cuales son las llamadas al sistema que invocan las funciones de biblioteca `puts()` y `exit()`.
3. Describir los parámetros que utiliza la llamada al sistema invocada por `puts()`.

## Ejercicio 2 - llamadas al sistema para archivos

Completar el programa `scopy.c` para que permita realizar una copia del archivo indicado:

```console
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

## Ejercicio 4: Interprete de comandos

El programa `sh.c` es un interprete de comandos (un _shell_) que no tiene implementada la funcionalidad de ejecución de programas o de redirección de entrada/salida. Al hjecutarlo, imprime un símbolo de sistema (`$`) y espera ordenes. Para terminar su ejecución teclear `^C`.

### 4.1: Ejecución de comandos

Implementar la ejecución de comandos. El genera una estructura `execcmd` que contiene el comando a ejecutar y sus parámetros (si los hubiera). Para implementar la ejecución de comandos, deben completar el caso `' '` en la función `runcmd()`, utilizando la llamada a sistema [`exec()`](http://man7.org/linux/man-pages/man3/exec.3.html). Se debe imprimir un mensaje de error si `exec()` falla, utilizando la función [`perror()`](http://man7.org/linux/man-pages/man3/perror.3.html).

### 4.2: Redirección de E/S

Implementar redirección de E/S mediante los operadores `<` y `>`, de manera que el shell permita ejecutar comandos como:

```
$ echo "sistemas operativos" > so.txt
$ cat < so.txt
sistemas operativos
$
```

El parser implementado en el shell ya reconoce estos operadores y genera una estructura `redircmd` con los datos necesarios para implementar la redirección. Deben completar el código necesario en la función `runcmd()`. Consultar las llamadas al sistema [`open()`](http://man7.org/linux/man-pages/man2/open.2.html) y [`close()`](http://man7.org/linux/man-pages/man2/close.2.html). Imprimir un mensaje de error si alguna de las llamadas al sistema, utilizando [`perror()`](http://man7.org/linux/man-pages/man3/perror.3.html). Verificar los permisos con los que se crea el archivo.

## Ejercicio 3 - Traza de llamadas al sistema

En este ejercicio se modificara el _kernel_ de _xv6_ para que imprima un mensaje cada vez que se invoca una llamada al sistema. Este mensaje indicará la llamada al sistema que se ejecuta y el valor que retorna.

Se debe modificar la función `syscall()` en el archivo `syscall.c`. Esta función es ejecutada por _xv6_ cuando se detecta que una _interrupción por software_ ha sido generada desde un proceso de usuario.

Una vez hecha la modificación, al compilar y ejecutar _xv6_ en QEMU se tendría que ver algo similar a esto:

```console
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

Se deben modificar los siguientes archivos del sistema operativo:

- `usys.S`: implementa el mecanismo de invocación de una llamada al sistema desde el nivel de usuario.
- `user.h`: prototipos de las funciones de biblioteca para el usuario.
- `syscall.h`: identificadores de cada una de las llamadas al sistema.
- `syscall.c`: código que invoca la llamadas al sistema dentro del _kernel_.
- `sysproc.c`: aquí implementaremos la llamada al sistema, aunque podría estar en cualquier otro archivo `.c`.

El programa `answer.c` invoca la llamada al sistema e imprime el resultado. El código esta comentado, dado que no existe la llamada. Una vez que la hayan implementado, descomentar el código en el programa, recompilar y ejecutar nuevamente _xv6_ para verificar que se invoque correctamente la nueva llamada.

### Entrega

Agregar en el directorio del Laboratorio un archivo de texto donde se explique brevemente las modificaciones realizadas en cada uno de los archivos de _xv6_ que hayan modificado. Recordar utilizar `git add` para agregar el archivo al _commit_.

---

¡Fin del Laboratorio 2!
