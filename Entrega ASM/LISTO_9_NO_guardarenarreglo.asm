; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .bss
  array RESB 200

section .text
  global _start


_start:
  pop ecx  ;traemos la cantidad de argumentos
  pop eax ;regresamos el estack el primer argumento, nombre de archivo
  dec ecx ;decrementamos el contador (simulamos que el nombre de archivo no cuenta)
  mov esi,array

sigArg:
  mov edx,0
  cmp ecx, 0h     ; comparamos si en eax es igual a xero, si es asi debajo saltamos a no mas Argumentos para salir
  jz imprimir    ; saltamos a no mas argumentos
  pop eax   ; traemos el siguente argumento
  mov ebx, eax ; guardamos la direccion de ese argumento en ESI
  dec ecx
  jmp ciclo

ciclo:
  mov [esi+edx*1],ebx
  inc edx
  inc ebx
  cmp ebx,0h
  jmp imprimir
  ;mov EBX,[ebx+edx*1]
  jmp ciclo


imprimir:
  mov EAX,ESI
  call iprintLF
