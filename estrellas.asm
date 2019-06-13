org 100h

section .text

start:
;======= Princial 
;modo video
	mov ah, 00h
	mov al, 12h
	int 10h

call bandera
call espera
call fin
;======= Subrutinas

bandera:
	call canvas
	call cuadroAzul
	call cuadroRojo
	call puntosIniciales
	call estrellaAzul
	ret

canvas: 
	mov cx, 100d
	mov dx, 100d
sigcanv:	call pixelBlanco
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
sigcazul:	call pixelAzul
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
sigcrojo:	call pixelRojo
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
;m y b
	mov cx, word [0200h]
	mov dx, word [0202h]
	call encontrarbp
sigeazul:	call encontrardx
	call pixelAzul
	inc cx
	cmp cx,200d
	jne sigeazul
	ret      

encontrarbp:
    mov bx, word [0206h] ; y_2
    mov si, word [0202h] ; y_1
    
    sub bx, si ; y_2 - y_1 
    mov word [0208h], bx
    
    mov bx, word [0204h] ; x_2
    mov si, word [0200h] ; x_1
    
    sub bx, si ; x_2 - x_1 
    mov word [020Ah], bx 
    
    mov ax, word [0208h] ;dividendo 
    mov bx, word [020Ah] ;divisor
    
    idiv bx ; y_2 - y_1 / x_2 - x_1 
    
    mov bp, bx       
    ret

encontrardx:
	mov dx,0d
	mov ax, cx
	sub ax, word [0200h]
	imul bp
	add ax, word [0202h]
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

puntosIniciales:

    ;coordenadas iniciales
    ;mov byte [0200h], 00h
    ;mov byte [0201h], 00h
    
    mov word [0200h], 188d ; x del primer punto
    
    ;mov byte [0202h], 00h
    ;mov byte [0203h], 00h
    
    mov word [0202h], 166d ; y del primer punto
    
    ;coordenadas finales
    ;mov byte [0204h], 00h
    ;mov byte [0205h], 00h 
    
    mov word [0204h], 200d ; x del segundo punto
    
    ;mov byte [0206h], 00h
    ;mov byte [0207h], 00h
    
    mov word [0206h], 132d ; y del segundo punto
    
    ret       