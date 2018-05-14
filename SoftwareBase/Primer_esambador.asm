; @Mizaelgalvez

section .data

  mensaje DB "Hola Mundo",0xA,0x0
  longitud EQU $ - mensaje

section .text
  GLOBAL _start

_start:
  mov ECX, mensaje
  mov EDX, longitud
  mov EBX, 1
  mov EAX, 4
  int 0X80
  mov EAX, 1
  int 0x80
