// Copiar este archivo en el directorio donde tengan xv6

#include "types.h"
#include "user.h"
#include "date.h"

int main(int argc, char *argv[])
{
  struct rtcdate r;

  if (date(&r)) {
    printf(2, "date failed\n");
    exit();
  }

  // completar: imprimir la fecha

  exit();
}
