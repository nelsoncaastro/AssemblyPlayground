%include "io.inc"

section .text
global CMAIN
CMAIN:
    org 100h


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
	;call cuadroAzul
	;call cuadroRojo
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
	mov cx, ds:[0200h]
	mov dx, ds:[0202h]
	mov bp,2d
sigeazul:	call encontrardx
	call pixelAzul
	inc cx
	cmp cx,200d
	jne sigeazul
	ret      
	  
encontrarbp:
       
    ret

encontrardx:
	mov dx,0d
	mov ax, cx
	sub ax,200d
	imul bp
	sub ax,100d
	sub dx, ax
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
    mov ds:[0200h], 00h
    mov ds:[0201h], 00h
    
    mov ds:[0200h], 88d ; x del primer punto
    
    mov ds:[0202h], 00h
    mov ds:[0203h], 00h
    
    mov ds:[0202h], 66d ; y del primer punto
    
    ;coordenadas finales
    mov ds:[0204h], 00h
    mov ds:[0205h], 00h 
    
    mov ds:[0204h], 200d
    
    mov ds:[0206h], 00h
    mov ds:[0207h], 00h
    
    mov ds:[0206h], 132d
    
    ret   
    xor eax, eax
    ret