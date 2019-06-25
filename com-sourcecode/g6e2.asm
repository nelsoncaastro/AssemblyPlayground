org 100h

section .text

start:
	call password
	mov si, 00h
	mov cx, 05h
ingresar:call teclado
	mov [0300h+si], al
	inc si
	loop ingresar
	mov cx, 05h
	mov si, 00h
	call comparar
	call fin

password:
	mov al, "r"
	mov [0200h], al

	mov al, "o"
	mov [0201h], al

	mov al, "o"
	mov [0202h], al

	mov al, "o"
	mov [0203h], al

	mov al, "t"
	mov [0204h], al
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

teclado:mov ah, 00h
	int 16h
	ret

comparar:mov bl, [0200h+si]
	mov bh, [0300h+si]
	cmp bl, bh
	jne incorrecto 
        inc si
	loop comparar
	mov al, "Y"
	call respuesta
	jmp salir
incorrecto:mov al, "N"
	call respuesta
salir:	ret

respuesta:
        mov ah, 02h ; Función
        mov bh, 00h ; Número de página
        mov dh, 20d ; Fila del carácter
        mov dl, 54d ; Columna, posición dentro de la fila
        ; DH y DL son las coordenadas del cursor
        int 10h
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