; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .data
  msgPromedioArea   DB  'Promedio de areas:',0
  msgPromedioPerim  DB  'Promedio de Perimetros:',0
  suma DD 0
  dividendo DD 0

segment .bss
	arreglo_enteros  resb 200         ;50 casillas de 4 bytes c/u
  arreglo_cuadrados resb 200

section .text
	global _start:

_start:
  ;BLOQUE INICIAL: Revisamos si hay suficientes argumentos
	pop ecx			;obtenemos el numero de argumentos
	cmp ecx,2		;comparamos si es menor a 2
	jl salir 		;salimos si es menor a 2

  ;BLOQUE de INICIALIZACION
	pop eax			;obtenemos nombre de programa
	dec ecx			;restamos 1 al numero de argumentos
  mov [dividendo], ecx
	mov edx, 0		;ponemos en 0 EDX
	mov esi,arreglo_enteros   ;la direccion de 'array' a ESI

  ;CICLO DE EXTRACCION DE ARGUMENTOS
ciclo:
	pop eax				;sacamos direccion de argumento del stack
	call atoi			;lo convertimos a entero de 4 bytes
	mov [esi+edx*4],eax	;lo guardamos en array
	inc edx					;incrementamos el indice del array
	dec ecx					;decrementamos numero de argumentos por procesar
	cmp ecx,0				;preguntamos si ya no tenemos argumentos
	jne ciclo 				;ciclar en caso de que si existan argumentos


  ;CICLO PARA LA SUMATORIA DE ENTEROS
ciclo_sumatoria:
  mov eax, [esi+ecx*4]  ;traemos de array numero a imprimir
  ;call iprintLF
  add [suma], eax
  inc ecx               ;incrementamos indice de array
  dec edx               ;decrementamos contador
  cmp edx,0             ;llegamos a 0?
  jne ciclo_sumatoria   ;ciclar en caso de no llegar a cero

  ;CICLO PARA LA SUMATORIA DE ENTEROS
funcion_divicion:
  mov edx, 0              ;limpiamos el registro EDX
  mov eax, [suma]         ; movemos a EAX el numero que queremos dividir
  mov ebx, [dividendo]    ;movemos EBX el dividendo, entre cuanto queremos dividir la sumatoria
  idiv ebx                ; realizazmos la divicion, el resultado lo entregara en EAX y el residuo en EDX


impresion:
  call iprintLF         ;imprimimos el resultado sabemos que entrega en EAX, asi que silo lo imprimimos

salir:
	jmp quit
