; @Mizaelgalvez

%include 'funciones_basicas.asm'

section .data
  msgPromedioNumeros   DB  'Promedio de Numeros:   ',0
  msgPromedioCuadrados  DB  'Promedio de Cuadrados:   ',0
  suma DD 0
  sumaCuadrados DD 0
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
  mov edi,arreglo_cuadrados ;guardando la direccion del sig arreglo

  ;CICLO DE EXTRACCION DE ARGUMENTOS
ciclo:
	pop eax				;sacamos direccion de argumento del stack
	call atoi			;lo convertimos a entero de 4 bytes
	mov [esi+edx*4],eax	;lo guardamos en array
  imul eax, eax  ; multiplicando por ellos mismo y guardando de una ves en el otro arreglo
  mov [edi+edx*4],eax
	inc edx					;incrementamos el indice del array
	dec ecx					;decrementamos numero de argumentos por procesar
	cmp ecx,0				;preguntamos si ya no tenemos argumentos
	jne ciclo 				;ciclar en caso de que si existan argumentos


  ;CICLO PARA LA SUMATORIA DE ENTEROS
ciclo_sumatoria:
  mov eax, [esi+ecx*4]  ;traemos de array numero a imprimir
  ;call iprintLF
  add [suma], eax

  mov eax, [edi+ecx*4]
  add [sumaCuadrados], eax

  inc ecx               ;incrementamos indice de array
  dec edx               ;decrementamos contador
  cmp edx,0             ;llegamos a 0?
  jne ciclo_sumatoria   ;ciclar en caso de no llegar a cero

  ;LA DIVICION
funcion_divicion:
  mov eax, msgPromedioNumeros
  call sprint
  mov edx, 0              ;limpiamos el registro EDX
  mov eax, [suma]         ; movemos a EAX el numero que queremos dividir
  mov ebx, [dividendo]    ;movemos EBX el dividendo, entre cuanto queremos dividir la sumatoria
  idiv ebx                ; realizazmos la divicion, el resultado lo entregara en EAX y el residuo en EDX
  call iprintLF
  mov eax, msgPromedioCuadrados
  call sprint
  mov edx, 0              ;limpiamos el registro EDX
  mov eax, [sumaCuadrados]         ; movemos a EAX el numero que queremos dividir
  mov ebx, [dividendo]    ;movemos EBX el dividendo, entre cuanto queremos dividir la sumatoria
  idiv ebx                ; realizazmos la divicion, el resultado lo entregara en EAX y el residuo en EDX
  call iprintLF

salir:
	jmp quit
