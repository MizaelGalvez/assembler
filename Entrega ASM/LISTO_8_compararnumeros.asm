; @Mizaelgalvez
; recibe N numeros de argumentos numericos y encuentra el numero mayor

%include 'funciones_basicas.asm'

section .text
  global _start

  _start:
  	pop ecx
    dec ecx
    pop eax
    mov ebx, 0

    sigArg:
      cmp ecx, 0x00     ; comparamos si numero de argumentos con 3 , si es mayor salimos
      jz nomasArg   ; saltamos a no mas argumentos
      pop eax      ; regresamos el stack anterior
      call atoi
      call _comparar
      dec ecx
      jmp sigArg

  _comparar:
    cmp eax, ebx
    jge _mayor
    ret

  _mayor:
    mov ebx, eax
    ret


    nomasArg:
    mov eax, ebx
    call iprintLF
    call quit
