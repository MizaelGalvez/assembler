; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .data
  numero1 DD 543
  cadena1 DB "789",0x0
  numero2 DD 888

section .bss
  sum resb 4    ;reservamos 4 bytes

section .text
  GLOBAL _start

_start:
  mov EAX, cadena1                ;cadena a conversion
  call atoi                       ;convertimos cadena a enteros
  mov [sum], EAX                  ;guardamos en suma el numero combertido
  mov EBX, [numero1]              ;cargamos el numero a EBX
  add EAX, EBX                    ;suma EAX y EBX y guardamos en EAX
  mov EBX, [numero2]              ;cargamos numero2 a EBX
  add EAX, EBX                    ; sumanos EAX y EBX y gguardamos en EAX
  call iprintLF                   ;imprimimos el resultado
  jmp quit                        ;saltamos a salir del Programa
