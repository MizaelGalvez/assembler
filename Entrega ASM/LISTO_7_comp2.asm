; @Mizaelgalvez
; recibe 2 argumentos y compara
; imprimiendo el menor

%include 'funciones_basicas.asm'

section .text
  global _start

_start:
  pop ECX ; la cantidad de argumentos que recibe nuestra ejecucion


  sigArg:
    cmp ECX, 0x03     ; comparamos si numero de argumentos con 3 , si es mayor salimos
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
  jle _menor
  call iprintLF
  call quit


_menor:
  mov EAX, EDX
  call iprintLF
  call quit

Nocumple:
call quit
