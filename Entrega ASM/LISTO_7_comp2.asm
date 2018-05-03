; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .text
  global _start

_start:
  pop ECX ; la cantidad de argumentos que recibe nuestra ejecucion


  sigArg:
    cmp ECX, 0x03     ; comparamos si en eax es igual a xero, si es asi debajo saltamos a no mas Argumentos para salir
    jl Nocumple    ; saltamos a no mas argumentos
    pop EAX
    pop EAX      ; regresamos el stack anterior
    call atoi
    mov EDX, EAX
    pop EAX
    call atoi
    call _comparar

_comparar:
  cmp EDX, EAX
  jl _menor
  cmp EDX, EAX
  jg _menor
  call quit


_menor:
  mov EAX, EDX
  call iprintLF
  call quit

Nocumple:
call quit
