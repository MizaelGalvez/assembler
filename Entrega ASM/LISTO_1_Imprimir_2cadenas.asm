; @Mizaelgalvez

section .data

  nombre DB "Mizael", 0x20,0x0
  longitudNombre EQU $ - nombre
  apellido DB "Galvez", 0xA,0x0
  longitudApellido EQU $ - apellido

section .text
  GLOBAL _start

_start:
  mov ECX, nombre
  mov EDX, longitudNombre
  mov EBX, 1
  mov EAX, 4
  int 0X80,
  mov EAX, 1
  mov ECX, apellido
  mov EDX, longitudApellido
  mov EBX, 1
  mov EAX, 4
  int 0X80,
  mov EAX, 1
  int 0x80
