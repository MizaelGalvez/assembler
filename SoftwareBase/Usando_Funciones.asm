; @Mizaelgalvez

section .data

  A_paterno DB "Galvez", 0xA,0x0
  A_materno DB "Alcaraz", 0xA,0x0
  Nombres DB "Alejandro Mizael", 0xA,0x0



section .text
    GLOBAL _start

_start:
  mov EAX, A_paterno    ; colocamos de en EAX la variable A_paterno
  call _Sprint          ; mandamos a llamar la funcion de imprimir esa variable
  mov EAX, A_materno
  call _Sprint
  mov EAX, Nombres
  call _Sprint
  mov EAX, 1
  int 0X80


_Sprint:
  push EDX      ; salvamos los valores en EDX
  push ECX      ;   **      **   **    *  ECX
  push EBX      ;   **      **   **    *  EBX
  push EAX      ; salvamos los valores en EAX
  mov ECX,EAX         ; movemos de EAX a ECX
  call _StringLON     ;llamamos la funcion para contar los caracteres de
  mov EDX,EAX
  pop EAX
  mov ECX,EAX
  mov EAX, 4
  mov EBX, 1
  int 0X80
  pop EDX
  pop ECX
  pop EDX
  ret

_StringLON:
  push EBX      ; guardamos lo que este en EBX
  mov EBX,EAX   ;metemos en EBX lo que tenemos en EAX ... EAX contiene el String que le movimos en un inicio
  sigCar:
    cmp byte[EAX],0         ; compararemos cada cada byte de EAX (que contiene nuestra variable ) osea, compararemos cada caracter con un "0", recordar que en un inicio esta al final de nuestra variable el 0 e aqui el ejemplo = "Galvez", 0xA,0x0
    jz Finalizar            ; saltamos a la seccion Finalizar si es igual a 0,  jz = jump if zero
    inc EAX
    jmp sigCar
  Finalizar:
    sub EAX,EBX
    pop EBX
    ret
