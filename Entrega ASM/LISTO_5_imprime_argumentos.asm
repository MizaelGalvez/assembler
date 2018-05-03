; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .text
  global _start

_start:
  pop ECx ; la cantidad de argumentos que recibe nuestra ejecucion
sigArg:
  cmp ECX, 0h     ; comparamos si en eax es igual a xero, si es asi debajo saltamos a no mas Argumentos para salir
  jz nomasArgs    ; saltamos a no mas argumentos
  pop EAX         ; regresamos el stack anterior
  call sprintLF
  dec ECx
  jmp sigArg

nomasArgs:
  call quit
