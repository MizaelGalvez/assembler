; @Mizaelgalvez
; introducir argumentos y los guarda en un arreglo

%include 'funciones_basicas.asm'

section .bss
  array RESB 200

section .text
  global _start


_start:
  pop ecx  ;traemos la cantidad de argumentos
  pop eax ;regresamos el estack el primer argumento, nombre de archivo
  mov esi,array
  mov ebx,0

sigArg:
  dec ecx
  pop eax
  cmp ecx, 0x00     ; comparamos si en eax es igual a xero, si es asi debajo saltamos a no mas Argumentos para salir
  jz imprimir    ; saltamos a no mas argumentos
  jmp ciclo

ciclo:
  inc ebx
  cmp byte[eax],0 ;comparar cada caracter con 0 buscando el espacio que indica el fin
  jz sigArg;si se acaba la palabra brinca a la salida
  mov bl,byte[eax] ;mueves a bl el caracter que tenga eax
  mov byte[esi+edx],bl ;mueves al primer espacio del arreglo el valor de bl
  inc edx;incrementas edx para recorrer el arreglo
  inc eax;incrementas eax para referirte al siguiente caracter
  jmp ciclo;se llama asi mismo para buclearse


  imprimir:
  	mov eax,esi
  	call sprintLF
  	call quit
