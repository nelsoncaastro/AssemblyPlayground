org 100h

section .text

start:
        call iniciarModoVideo
        call iniciarCursor
        call canvas
        call letras
        call espera
        call fin

iniciarRaton:
        mov ax, 00h
        int 33h
        ret

iniciarPuntero:
        mov ax, 01h
        int 33h
        ret

iniciarCursor:
        mov ah, 01h
        mov ch, 00h
        mov cl, 0eh
        int 10h
        ret

iniciarModoVideo:
        mov ah, 00h
        mov al, 12h
        int 10h
        ret

espera:
        mov ah, 00h
        int 16h
        ret

fin:
        int 20h
        ret

canvas:
        mov cx, 100d
        mov dx, 100d
sigo:   call pixelRojo
        inc cx
        cmp cx, 540d
        jne sigo
        mov cx, 100d
        inc dx
        cmp dx, 352d
        jne sigo
        ret

pixelAzul:
        mov ah, 0Ch
        mov al, 1001b ; Color Azul
        mov bh, 00h
        int 10h
        ret

pixelRojo:
        mov ah, 0Ch
        mov al, 0100b ; Color Rojo
        mov bh, 00h
        int 10h
        ret

letras:
        mov ah, 02h ; Función
        mov bh, 00h ; Número de página
        mov dh, 17d ; Fila del carácter
        mov dl, 54d ; Columna, posición dentro de la fila
        ; DH y DL son las coordenadas del cursor
        int 10h
        mov al, "L"
        call caracter

        mov al, "E"
        call caracter

        mov al, "O"
        call caracter

        mov al, "N"
        call caracter

        ret

caracter:
        mov ah, 09h ; Función 09 para mostrar caracter
        mov bh, 00h ; Número de página
        mov bl, 11111100b ; Atributo. Los primeros 4 bits corresponden al color de frente y los siguientes 4 bits al color de fondo.
        mov cx, 0001h ; solo se quiere mostrar el caracter una vez
        int 10h

        mov ah, 0Eh
        mov bh, 00h
        mov bl, 11111111b
        int 10h

        ret