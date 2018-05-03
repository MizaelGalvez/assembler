; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .text
  global _start

_start:
  pop ECX
  pop EAX
  mov EBX, ECX
  dec EBX
  dec ECX
  pop EAX

sigArg:
  cmp ECX, 0x00     ; comparamos si en eax es igual a xero, si es asi debajo saltamos a no mas Argumentos para salir
  jz _Comparar    ; saltamos a no mas argumentos
  mov EDX, EAX
  push EDX
  dec ECX
  pop EAX
  jmp sigArg


_Comparar:
  cmp EBX, 0x00
  jz quit
  mov EAX, EDX
  call atoi
  call iprintLF
  dec EBX
  pop EDX
  jmp _Comparar
