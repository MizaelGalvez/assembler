;leer archivo
; por @MizaelGalvez

%include 'funciones_basicas.asm'


section .data

section .bss
  buffer resb 1024
  len equ 1024
  file resb 20
  filelen resb 4

section .text
  global _start

_start:
  ;vemos los Argumentos
  pop ecx
  pop eax
  dec ecx
  cmp ecx, 0x02
  jz quit

  ;abre archivo
  pop ebx
  mov eax, sys_open ;operacion de abrir archivo
  mov ecx, 0 ; 0_RDONLY (solo lectura)
  int 0x80
  cmp eax, 0 ; si file handlre es >0 bien (sino mal :P)
  jle error

  ;leer arcghivo
  mov ebx, eax
  mov eax, sys_read
  mov ecx, buffer
  mov edx, len
  int 0x80
  ;cerrar arcghivo
  mov eax, sys_close
  int 0x80


  ;imprimir Buffer
  mov eax, buffer
  call sprintLF

  ;salir
  call quit

error:
  mov ebx, eax
  mov eax, sys_exit
  int 0x80


strincopy:
  ;direccion en eax
  ;longitud en EBX
  ;esi, direccion del arreglo de cadenas

  ;tenemos en bufer numeros, copiamos a un arreglo de carecteres y despues copiamos a un arhchivo de enterps
  ;esto nos servira para que nuestro programa en esamblador consuma datos desde archivos.

  ;datos includio en el archivos      buffer              arreglo uno         arreglo dos
  ; 155                             155                       "155"              155
  ; 122                             122                       "122"              122
  ; 270                             270                       "270"              270
