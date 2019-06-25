org 100h


	mov al, "N"
	mov [0200h], al

	mov al, "e"
	mov [0201h], al

	mov al, "l"
	mov [0202h], al

	mov al, "s"
	mov [0203h], al

	mov al, "o"
	mov [0204h], al

	mov al, "n"
	mov [0205h], al

	mov si, 00h

	mov cx, 06h

ingresar:call teclado

	mov [0300h+si], al
	inc si
	loop ingresar

	mov cx, 06h
	mov si, 00h
	call comparar
	int 20h

teclado:mov ah, 00h
	int 16h
	ret

comparar:mov bl, [0200h+si]
	mov bh, [0300h+si]
	cmp bl, bh
	jne incorrecto 
	loop comparar
	mov al, "y"
	mov [0400h], al
	jmp salir
incorrecto:mov al, "N"
	mov [0400h], al
salir:	ret