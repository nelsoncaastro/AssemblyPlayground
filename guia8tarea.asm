org 100h

;======= Princial
;modo video
    mov ah, 00
    mov al, 12h
    int 10h
call bandera
call espera
call fin
;======= Subrutinas

bandera:
    call canvas
    ;call cuadroAzul
    ;call cuadroRojo
    call estrellaAzul
    ret

canvas:
    mov cx, 100d
    mov dx, 100d
sigcanv:    call pixelBlanco
    inc cx
    cmp cx, 500d
    jne sigcanv
    mov cx, 100d
    inc dx
    cmp dx, 350d
    jne sigcanv
    ret        

cuadroAzul:
            mov cx, 100d
            mov dx, 225d
sigcazul:   call pixelAzul
            inc cx
            cmp cx, 300d
            jne sigcazul
            mov cx, 100d
            inc dx
            cmp dx, 350d
            jne sigcazul
            ret

cuadroRojo:
    mov cx, 300d
    mov dx, 100d
sigcrojo:    call pixelRojo
    inc cx
    cmp cx, 500d
    jne sigcrojo
    mov cx, 300d
    inc dx
    cmp dx, 225d
    jne sigcrojo
    ret

estrellaAzul:
;punto inical
    mov cx, 225d
;m y b
    mov bp, 11111101b
    mov si, 865d
sigeazul:    call encontrardx
    call pixelAzul
    dec cx
    cmp cx, 210d
    jne sigeazul
    ret

encontrardx:
    mov ax, bp
    imul cx
    add ax, si
    mov dx, ax
    ret

pixelRojo:
    mov ah, 0Ch
    mov al, 0100b ;rojo
    mov bh, 00h
    int 10h
    ret

pixelAzul:
    mov ah, 0Ch
    mov al, 0001b ;azul
    mov bh, 00h
    int 10h
    ret

pixelBlanco:
    mov ah, 0Ch
    mov al, 1111b ;blanco
    mov bh, 00h
    int 10h
    ret

espera:
    mov ah, 00
    int 16h
    ret
fin:
    int 21h
    ret


ret




