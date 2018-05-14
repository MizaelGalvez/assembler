;@Mizaelgalvez
;primer esamblador para interactuar en consola

%include 'funciones_basicas.asm'

section .data
  pregunta_nombre db "como te llamas ? ", 0x0
  pregunta_edad db "cual es tu edad ? ", 0x0

segment .bss
  Buffer_nombre resb 20
  Buffer_nombre_len equ $-Buffer_nombre

  Bufer_edad resb 4
  Bufer_edad_len equ $-Bufer_edad

  nombre resb 20
  edad resb 4

section .text
  global _start

_start:
  mov eax, pregunta_nombre
  call sprint
  mov ecx, Buffer_nombre
  mov edx, Buffer_nombre_len
  call LeerTexto

  mov eax, pregunta_edad
  call sprint
  mov ecx, Bufer_edad
  mov edx, Bufer_edad_len
  call LeerTexto

  mov eax, Bufer_edad
  call atoi
  mov [edad], eax

  mov eax, Buffer_nombre
  call sprintLF
  mov eax, [edad]
  call iprintLF

  call quit

LeerTexto:
  mov ebx, stdin
  mov eax, sys_read
  int 0x80
  ret
