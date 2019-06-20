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
	;call canvas
	;call cuadroAzul
	;call cuadroRojo
	;call puntosIniciales
	call estrellaVerde
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

puntosIniciales:

    ;coordenadas iniciales
    ;mov byte [0500h], 00h
    ;mov byte [0201h], 00h
    
	mov si, 188d
    mov [0500h], si ; x del primer punto
    
    ;mov byte [0502h], 00h
    ;mov byte [0203h], 00h
    
	mov si, 166d
    mov [0502h], si ; y del primer punto
    
    ;coordenadas finales
    ;mov byte [0504h], 00h
    ;mov byte [0205h], 00h 
    
	mov si, 200d
    mov [0504h], si ; x del segundo punto
    
    ;mov byte [0506h], 00h
    ;mov byte [0207h], 00h
    
	mov si, 132d
    mov [0506h], si ; y del segundo punto
    
    ret 

estrellaVerde:
;punto inical
;m y b
	mov si, [0500h]
	mov cx, si	
	mov si, [0502h]
	mov dx, si
	call encontrarbp
sigeazul:	call encontrardx
	call pixelVerde
	inc cx
	mov si, [0504h]
	cmp cx, si
	jne sigeazul
	ret      

encontrarbp: ;Encontramos la pendiente de dicha linea recta
	mov bp , [0506h]
    mov bx, bp ; y_2
	mov bp, [0502h]
    mov si, bp ; y_1
    
    sub bx, si ; y_2 - y_1 
    mov [0508h], bx
    
	mov bp, [0504h]
    mov bx, bp ; x_2
	mov bp, [0500h]
    mov si, bp ; x_1
    
    sub bx, si ; x_2 - x_1 
    mov [050Ah], bx 
    
	mov bp, [0508h]
    mov ax, bp ;dividendo 
	mov bp, [050Ah]
    mov bx, bp;divisor
    
    idiv bx ; y_2 - y_1 / x_2 - x_1 
    
    mov bp, ax       
    ret

encontrardx:
	;mov dx,0d
	mov ax, cx
	mov si, [0500h] ; posición de cx inicial
	sub ax, si 
	imul bp
	mov si, [0502h] ; posición de dx inicial
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

pixelVerde:
	mov ah, 0Ch
	mov al, 0010b ;blanco
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