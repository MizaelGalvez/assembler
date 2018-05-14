; @Mizaelgalvez
; intruducir la cantidad de numeros deseados para pultiplicarlos

%include 'funciones_basicas.asm'

SECTION .text
	global _start

_start:
	pop ecx
  dec ecx
  pop eax
  mov ebx, 1

sigArg:
	cmp ecx, 0x00
	jz nomasArg
	pop eax
	call atoi
  imul eax, ebx
	mov ebx, eax
	dec ecx
	jmp sigArg

nomasArg:
  call iprintLF
	call quit
