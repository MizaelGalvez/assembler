; @Mizaelgalvez
; ejecutar con 2 argumentos numericos

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
    imul EAX, EDX
    call iprintLF
    call quit

Nocumple:
call quit
