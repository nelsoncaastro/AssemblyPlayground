org 100h

section .text

start: 
	call iniciarModoVideo
	call letras
	call teclado
	call fin

iniciarModoVideo: ;Modo video para que limpie la pantalla
        mov ah, 00h
        mov al, 12h
        int 10h
        ret

teclado:
        mov ah, 00h
        int 16h
        ret

fin:
        int 20h
        ret

letras:
        mov ah, 02h ; Función
        mov bh, 00h ; Número de página
        mov dh, 15d ; Fila del carácter
        mov dl, 30d ; Columna, posición dentro de la fila
        ; DH y DL son las coordenadas del cursor
        int 10h

	call teclado
	mov [0300h], al
        call caracter

	mov al, "+"
	call caracter

	call teclado
	mov [0301h], al
	call caracter

	mov al, "="
	call caracter

	call calcularRes
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

calcularRes:
	mov bp, 0000h
	mov al, [0300h]
	mov ah, [0301h]
	add al, ah
	;aaa
	ret