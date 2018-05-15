;Github @MizaelGalvez

%include 'funciones_basicas.asm'

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;DATOS a realizar
;buffer_archivo
    ;arreglo_datos_recibidos
    ;arreglo_operacion_linea
    ;arreglo_operacion_curva
    ;Numero_recibido_menu
    ;variable con el texto "Numero entero> "
    ;variable con el texto "Nombre de archivo a guardar?> "

segment .bss  ;50 casillas de 4 bytes c/u
  arreglo_datos_recibidos  resb 200
  len_arreglo_datos_recibidos equ $-arreglo_datos_recibidos
  arreglo_operacion_curva resb 200
  len_arreglo_operacion_curva equ $-arreglo_operacion_curva
  arreglo_operacion_linea resb 200
  len_arreglo_operacion_linea equ $-arreglo_operacion_linea
  buffer_archivo resb 1024
  len resb 1024
  Numero_Recibido_Menu resb 4
  len_Numero_Recibido_Menu resb 4
  filename resb 30
  len_filename equ $-filename

  archivo resb 30

section .data
  Numero dd 0
  Digito1 dd 0
  Digito2 dd 0
  Digito3 dd 0
  Condicion_Entrada db 0xA,"No cumple con las condiciones de ejecucion > ",0xA,"SALIENDO   >>>   Debe ingresar el nombre del archivo con los Numeros escribalo con todo y extencion",0xA,0x0
  Error_Archivo db 0xA,"Error en la Lectura del Archico: ",0xA,"Cancelando Ejecucion   >>> es posible ese Archivo no Exista, recuerde incluir la extencion",0xA,0x0
  Gracias db 0xA,"Gracias, Fue un Placer: ",0xA,"Saliendo :)   >>>",0xA,0x0
  Ingresa_Entero db "Numero entero> " , 0x0
  Ingresa_Nombre_Archivo db "Nombre de archivo a guardar?> ", 0x0
  Menu db  "*** MENU ***",0xA,"1. Agregar dato",0xA,"2. Generar línea",0xA,"3. Generar curva",0xA,"4. Mostrar datos (imprimir)",0xA,"5. Guardar archivo",0xA,"0. Salir",0xA,"************",0xA,0xA,0xA,0xA,0xA,0x0
  Espacio db 0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0xA,0x0
  Opcion db "Opción >_",0x0
  Formatos_titulos db "Arreglo de entrada         Arreglo de Linea         Arreglo de Curva",0xA,"==================         ================         ================",0xA,0x0
  Formato_espacio_corto db "      ",0x0
  Formato_espacio_largo db "                       ",0x0
  Formatos_final db "==================         ================         ================",0xA,0x0


;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////Bloque de Inicializacion y comparacion de Condiciones/////////////////////////////////////////

section .text
  GLOBAL _start

_start:
  pop ecx
  pop eax
  cmp ecx, 0x02
  jl _noCumpleCondiciones
  cmp ecx, 0x02
  jg _noCumpleCondiciones

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////bloque para recibir el nombre de archivo y leer el contenido del mismo ///////////////////////
;BLOQUE UNO
;BLOQUE DOS                                           ;realize el ploque dos aqui mismo

;ingresar con un argumento extra, que debe ser el archivo a Abrir
  pop eax   ; ACTUALMENTE SE ENCUENTRA EL NOMBRE DEL ARCHIVO A ABRIR (CONFIRMADO)

  mov ebx, eax ;movemos a ebx el nombre para poder abrir ese archivo

	mov eax,sys_open
	mov ecx,0
	int 80h
	cmp eax,0
	jle _error ;se ejecuta el error si es que no encuentra el archivo

	mov ebx,eax
	mov eax,sys_read
	mov ecx,buffer_archivo
	mov edx,len
	int 80h

	mov eax,sys_close
	int 80h

	mov eax,buffer_archivo ;ACTUALMENTE TENEMOS EL CONTENIDO DEL ARCHIVO EN EAX (CONFIRMADO)

;solo leer y guardar en buffer el contenido           ;fue mas simple de lo que imagine

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////Guardar el buffer en el arreglo_datos_recibidos///////////////////////////////////////
;BLOQUE TRES

; copiar cada linea a al arreglo_datos_recibidos (como dato ay que comparar con el salto de linea)
  mov esi,arreglo_datos_recibidos
  ;mov ecx,3
  ;mov edx,0

_ciclo:
  ;mov bl,byte[eax]
  ;cmp bl,0xA
  ;jz _sigNumero
  ;mov byte[esi+edx*4],bl
  ;inc edx
  ;inc eax
  ;dec ecx

  ;_sigNumero:
  ;  inc eax
  ;  jmp _ciclo
  mov bl,byte[eax]
  mov [Digito1], bl
  inc edx
  inc eax
  inc eax
  dec ecx
  mov bl,byte[eax]
  mov [Digito2], bl
  inc edx
  inc eax
  inc eax
  dec ecx
  mov bl,byte[eax]
  mov [Digito3], bl
  inc edx
  inc eax
  inc eax
  dec ecx

  cmp ecx, 0
  jz _Guardando  ; ya tenemos en arreglo_datos_recibidos los caracteres del archivo, aun falta convertorlos en entero
;//////////guardando registros///////////
_Guardando:
  mov eax, Digito1
  call atoi
  mov [esi+0*4],eax
  mov eax, Digito2
  call atoi
  mov [esi+1*4],eax
  mov eax, Digito3
  call atoi
  mov [esi+2*4],eax

  mov edi, 0
  mov esi, arreglo_datos_recibidos
  mov eax, 0
  mov ebx, 0
  mov ecx, 0
  mov edx, 0
  mov [Digito1], eax
  mov [Digito2], eax
  mov [Digito3], eax

  jmp _Menu

; 1 punto ------------- recibir numeros de un archivo recibido el nombre por argumentos
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////Mandar a imprimir el menu y realizar las Comparaciones////////////////////////////////////////////////////////////////
;BLOQUE CUATRO

  ; mostrar el siguiente menu en pantalla
  ;   *** MENU ***
  ; 1. Agregar dato
  ; 2. Generar línea
  ; 3. Generar curva
  ; 4. Mostrar datos (imprimir)
  ; 5. Guardar archivo
  ; 0. Salir
  ;   ************
  ; Opción >_
  ; el numero lo recibe en Numero_recibido_menu

_Menu:
  mov eax, Menu
  call sprintLF
  mov  eax, Opcion
  call sprint
  mov ecx, Numero_Recibido_Menu
  mov edx, len_Numero_Recibido_Menu
  call LeerTexto
  ;mov eax, Espacio
  ;call sprintLF
  call _Comparaciones

_Comparaciones:
  mov eax, ecx     ; hay que tener en cuenta que si se ingresa una letra truena el programa......  (T.T)
  call atoi          ; ya esta el numero recibido en Entero para poder hacer las comparaciones

  cmp eax, 0
  je _salir

  cmp eax, 1
  je _Nuevo_Numero

  cmp eax, 2
  je _Funcion_Lineal

  cmp eax, 3
  je _Funcion_Curva

  cmp eax, 4
  je _Imprimir_Tablas

  cmp eax, 5
  je _Guardar_Archivo

  jmp _Menu

;1 punto --------Menu hecho
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////Bloques de ejecucion////////////////////////////////////////////////////////////////

;BLOQUE CINCO
;comparar Numero_recibido_menu con 0,1,2,3,4,5 .... si no es eso, imprimir menu nuevamente
; si se elige:
; '1' mostrar el dialogo "Numero entero> ", se debera guardar en el arreglo_datos_recibidos
; '2' se parasa cada dato de arreglo_datos_recibidos por la funcion (x=numero recuperado del arreglo) 4x+3 y guardarlo en arreglo_operacion_linea cada resultado
; '3' se parasa cada dato de arreglo_datos_recibidos por la funcion (x=numero recuperado del arreglo) x^3-4x^2+6x-24 y guardarlo en arreglo_operacion_curva
; '4' recorrer cada arreglo y mostrar resultados ejemplo:
;        Arreglo de entrada     Arreglo de resultados
;        ==================     =====================
;               1                              7
;               2                              2
;               3                              3
; '5' mostrar el dialogo "Nombre de archivo a guardar?" NOTA, no es posible guardar enteros, ay que convertir a texto con la funcion ITOA
;      guardar dos archivos, guardando Linea y CUrva ejemplo:
;        Archivo de Linea       Archivo de Curva
;        ==================     =====================
;         1,7                        1,7
;         2,11                       2,11
;         3,15                       3,15
;
; '0' slir del programa sin mensajes de error

;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;BLOQUE 4.1
_Nuevo_Numero:
  mov edi, [Digito3]
  cmp edi, 3                 ;comparacion para que ya no guarde mas numeros en el arreglo
  je _Menu
  mov eax, Ingresa_Entero
  call sprint
  mov ecx, Numero_Recibido_Menu
  mov edx, len_Numero_Recibido_Menu
  call LeerTexto
  mov eax, ecx

  call atoi
  mov [esi+edi*4],eax

  inc edi
  mov [Digito3], edi


  call _Menu  ;regresa aun sin hacer nada

; 5 puntos, agregar datos nuevos al arreglo, iniciando con la primer casilla
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;BLOQUE 4.2
_Funcion_Lineal:
  mov esi, arreglo_datos_recibidos
  mov edi, arreglo_operacion_linea
  mov ecx, 0
  mov edx, 3

  ciclo_linea:
    mov eax,[esi+ecx*4]  ;Traemos a EAX el numero del arreglo recibido
    ;////////////////////4x+3 ///////////////////////////////////////////////////
    imul eax, 4
    add eax, 3
    ;////////////////////////////////////////////////////////////////////////////
    mov [edi+ecx*4],eax
    inc ecx               ;incrementamos indice de array
    dec edx               ;decrementamos contador
    cmp edx,0             ;llegamos a 0?
    jne ciclo_linea   ;ciclar en caso de no llegar a cero

    mov eax, Espacio
    call sprintLF
    call _Menu

; 5 puntos, generar resultados de una operacion lineal y guardarlos en otro arreglo
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;BLOQUE 4.3
_Funcion_Curva:
  mov esi, arreglo_datos_recibidos
  mov edi, arreglo_operacion_curva
  mov ecx, 0
  mov edx, 3

  ciclo_curva:
    mov eax,[esi+ecx*4]  ;Traemos a EAX el numero del arreglo recibido
    mov ebx, eax
    imul eax, eax
    imul eax, ebx
    ;call iprintLF
    mov [Digito1], eax
    mov eax, ebx
    ; x^3

    imul eax, eax
    imul eax, 4
    ;call iprintLF
    mov [Digito2], eax
    ;4x^2


    mov eax, ebx
    imul eax, 6
    sub eax, 24
    ;call iprintLF
    mov [Digito3], eax
    ;6x-24

    mov eax, [Digito1]
    mov ebx, [Digito3]
    add eax,ebx
    ; sumamos   x^3 + 6x-24

    mov ebx, [Digito2]
    sub eax, ebx
    ; restamos la operacion de 4x^2


    ;////////////////////////////////////////////////////////////////////////////
    mov [edi+ecx*4],eax
    inc ecx               ;incrementamos indice de array
    dec edx               ;decrementamos contador
    cmp edx,0             ;llegamos a 0?
    jne ciclo_curva   ;ciclar en caso de no llegar a cero

    mov eax, Espacio
    call sprintLF
    call _Menu

; 5 puntos, generar resultados pasando por una operacion cubica y guardarlos en un arreglo
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;BLOQUE 4.4
_Imprimir_Tablas:
  mov esi, arreglo_datos_recibidos
  mov edi, arreglo_operacion_linea
  mov ebx, arreglo_operacion_curva
  mov ecx, 0
  mov edx, 3
  mov eax, Formatos_titulos
  call sprint


  ciclo_imprimir_tablas:
    ;*****************************************************************************************
    mov eax, Formato_espacio_corto
    call sprint
    mov eax,[esi+ecx*4]
    call iprint
    mov eax, Formato_espacio_largo
    call sprint
    mov eax,[edi+ecx*4]
    call iprint
    mov eax, Formato_espacio_largo
    call sprint
    mov eax,[ebx+ecx*4]
    call iprintLF

    ;*****************************************************************************************
    inc ecx
    dec edx
    cmp edx,0
    jne ciclo_imprimir_tablas   ;clico para recorrer el arreglo


  mov eax, Formatos_final
  call sprint
  call _Menu

; 1 punto imprimir los arreglos juntos pero separados jajajaja
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;BLOQUE 4.5
_Guardar_Archivo:
  call _Funcion_Acomodar_salida
  mov eax, Ingresa_Nombre_Archivo
  call sprint
  mov ecx,filename
  mov edx,len_filename
  call LeerTexto

  mov esi,archivo                ;copiar asta archivo
  mov eax,filename                 ;dede file name
  call copystring                   ; pero sin el caracter 0xA

  ;create file

  mov eax, sys_creat            ;sys_creat EQU 8
  mov ebx, archivo                ;nombre de archivo
  mov ecx, 664o                ;511 = rwxr-xr-x
                                ; 5 = rwx
                                ; 1 = r-x
                                ; 7 = -wx
                                ; 6 = rwx
                                ; 4 = r-T
                                ; 3 = -wx
                                ; 2 = rwx
                                ;
                                ;

  int 0x80 ; ejecuta la llamada a la accion op

  cmp eax, 0
  jle _error      ; si es 0 o menos, existe error al abrir


  ;abrir archivo para escribir
  mov eax, sys_open  ; abrimos archivo
  mov ebx, archivo  ; nombre de archivo desde archivo
  mov ecx, O_RDWR    ; abrin en modo lectura y escritura
  int 0x80   ; ejecutar
  cmp eax, 0
  jle _error




  ;escribir en archivo
  mov ebx, eax  ;file Handle a EBX
  mov eax, sys_write
  mov ecx, arreglo_datos_recibidos
  mov edx, len_arreglo_datos_recibidos
  int 0x80
  mov eax, sys_sync ; sincronizamods discos, forzamos escrituras
  int 0x80       ; ejecutamos sys_sync


  ;cerrar archivo
  mov eax, sys_close
  int 0x80

  salida:
  jmp quit
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_Funcion_Acomodar_salida:
  mov esi, arreglo_datos_recibidos
  mov edi, arreglo_operacion_linea
  mov ebx, arreglo_operacion_curva
  mov ecx, 0
  mov edx, 1


  ciclo_convertir_enteros:
    ;*****************************************************************************************

    mov eax,[edi+ecx*4]
    call iprint
    call itoa

    ;
    ;
    ; no pude realizar una conversion y guardado....
    ; mi idea era guardarlo ya formateados la operacion de curva y la operacion de linea en el arreglo de datos
    ; recibidos para despues imprimir los dos resulktados en un mismo archivos
    ;
    ; pero no me salio.... (T.T)
    ;


    ;*****************************************************************************************
    inc ecx
    dec edx
    cmp ecx,3
    jne ciclo_convertir_enteros   ;clico para recorrer el arreglo


  mov eax, Formatos_final
  call sprint

ret

_salir:
  mov eax, Gracias
  call sprintLF
  call quit

_noCumpleCondiciones:
  mov eax, Condicion_Entrada
  call sprintLF
  call quit

_error:
  mov eax, Error_Archivo
  call sprintLF
  call quit
