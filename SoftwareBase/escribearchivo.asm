%include 'funciones_basicas.asm'

segment .bss
  buffer_alumno resb 30
  len_alumno equ $-buffer_alumno

  filename resb 30
  len_filename equ $-filename

  archivo resb 30

  section .data
    p_nombre db "nombre del alumno " , 0x0
    p_archivo db "nombre del archivo ", 0x0

  section .text
    GLOBAL _start

  _start:

    mov eax, p_nombre
    call sprint

    mov ecx, buffer_alumno
    mov edx, len_alumno
    call LeerTexto

    mov eax, p_archivo
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
    jle error      ; si es 0 o menos, existe error al abrir


  ;abrir archivo para escribir
    mov eax, sys_open  ; abrimos archivo
    mov ebx, archivo  ; nombre de archivo desde archivo
    mov ecx, O_RDWR    ; abrin en modo lectura y escritura
    int 0x80   ; ejecutar
    cmp eax, 0
    jle error




  ;escribir en archivo
    mov ebx, eax  ;file Handle a EBX
    mov eax, sys_write
    mov ecx, buffer_alumno
    mov edx, len_alumno
    int 0x80
    mov eax, sys_sync ; sincronizamods discos, forzamos escrituras
    int 0x80       ; ejecutamos sys_sync


  ;cerrar archivo
    mov eax, sys_close
    int 0x80

  salida:
    jmp quit

  error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80
