;**************************************************
;Este ejemplo SÍ funciona
;**************************************************

org 100h

section .bss

penddividendo:	resd 1
penddivisor:	resd 1
pendiente: 	resd 1
yresultante: 	resd 1
extra: 		resd 1

;section .rodata noexec nowrite align=4


section .text

global	start

start:
;======= Princial 

	call iniciarModoVideo
	finit
	call bandera
	call espera
	call fin
;======= Subrutinas

iniciarModoVideo:
	mov ah, 00h
	mov al, 12h
	int 10h
	ret

bandera:
	call canvas
	call cuadroAzul
	call cuadroRojo
	call estrellaVerde
	ret

canvas: 
	mov ecx, 100d
	mov edx, 100d
sigcanv:call pixelBlanco
	inc ecx
	cmp ecx, 500d
	jne sigcanv
	mov ecx, 100d
	inc edx
	cmp edx, 350d
	jne sigcanv
	ret		

cuadroAzul: 
	mov ecx, 100d
	mov edx, 225d
sigcazul:call pixelAzul
	inc ecx
	cmp ecx, 300d
	jne sigcazul
	mov ecx, 100d
	inc edx
	cmp edx, 350d
	jne sigcazul
	ret

cuadroRojo: 
	mov ecx, 300d
	mov edx, 100d
sigcrojo:call pixelRojo
	inc ecx
	cmp ecx, 500d
	jne sigcrojo
	mov ecx, 300d
	inc edx
	cmp edx, 225d
	jne sigcrojo
	ret

estrellaVerde:
;punto inical
;m y b
	mov ecx, [data.x1]
	mov edx, [data.y1]
	call encontrarbp
sigeazul:call encontrardx
	call pixelVerde
	inc ecx
	cmp ecx, [data.x2]
	jne sigeazul
	ret

encontrarbp: ;Encontramos la pendiente de dicha linea recta
	fld dword [data.y2] ;y_2
	fld dword [data.y1] ; y_1
	fsub ; y_2 - y_1 
	fstp dword [penddividendo]

	fld dword [data.x2]; x_2
	fld dword [data.x1]; x_1
	fsub
	fstp dword [penddivisor]

	fld dword [penddividendo]
	fld dword [penddivisor]
	fdiv
	fstp dword [pendiente]

	ret

encontrardx:
	mov [extra], ecx
	fld dword [extra] 
	fld dword [data.x1]
	fsub
	fld dword [pendiente]	
	fmul
	fld dword [data.y1]
	fadd
	fstp dword [yresultante]
	mov edx, [yresultante]
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

data:

.x1:	dd 	188
.y1:	dd	166
.x2:	dd  200 
.y2:	dd	132