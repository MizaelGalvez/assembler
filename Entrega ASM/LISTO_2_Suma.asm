; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .data
  numero1 DD 5
  numero2 DD 8

section .text
  GLOBAL _start

_start:
  mov EAX, [numero1]              ;suma EAX y EBX y guardamos en EAX
  mov EBX, [numero2]              ;cargamos numero2 a EBX
  add EAX, EBX                    ; sumanos EAX y EBX y gguardamos en EAX
  call iprintLF                   ;imprimimos el resultado
  jmp quit                        ;saltamos a salir del Programa
