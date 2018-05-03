;DATOS
;buffer_archivo
;arreglo_datos_recibidos
;arreglo_operacion_linea
;arreglo_operacion_curva
;Numero_recibido_menu
;variable con el texto "Numero entero> "
;variable con el texto "Nombre de archivo a guardar?> "



;BLOQUE UNO
;ingresar con un argumento extra, que debe ser el archivo a Abrir


;BLOQUE DOS
;solo leer y guardar en buffer el contenido

;BLOQUE TRES
; copiar cada linea a al arreglo_datos_recibidos (como dato ay que comparar con el salto de linea)

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
