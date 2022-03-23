/*
 * Imprime la fecha del sistema.
 *
 * Nota: copiar este programa en el directorio de xv6.
 */

#include "types.h"
#include "user.h"
#include "date.h"

int main(int argc, char *argv[])
{
  struct rtcdate r;

  // se invoca la llamada al sistema date()
  if (date(&r)) {
    printf(2, "date failed\n");
    exit();
  }

  // completar: imprimir la fecha

  exit();
}
