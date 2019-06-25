org 100h

;ejemplo_06 borramos la bandera
    ;modo video
    mov ah, 00
    mov al, 12h
    int 10h
;=======PRINCIPAL==============
    call bandera
    call letras
            
    ;inicializando el raton
    mov ax, 0000h
    int 33h
    
    ;puntero
    mov ax, 0001h
    int 33h
    call botonBorrar
    call botonDibujar
    call verifica ;eventos de pos y click
    call verifica1
    call espera
    call fin            


;=======SUBRUTINAS==============

bandera:    ;dibuja la bandera
    call cuadro_mayor
    call cuadro_menor
    ret
            
cuadro_mayor:
    ;coordenadas iniciales
    mov cx, 140d ;columna
    mov dx, 128d ;fila
                        
sigo:       call pixelMayor
    inc cx
    cmp cx, 500d
    jne sigo
    mov cx, 140d ;voy a iniciar otra linea
    inc dx
    cmp dx, 352d
    jne sigo
    ret
            
pixelMayor: ;dibuja un pixelito
    mov ah, 0Ch
    mov al, 1001b
    mov bh, 00
    ;mov cx, 100d
    ;mov dx, 100d
    int 10h
    ret            
            
cuadro_menor:
    ;coordenadas iniciales
    mov cx, 140d ;columna
    mov dx, 203d ;fila
sigo2:call pixelMenor
    inc cx
    cmp cx, 500d
    jne sigo2
    mov cx, 140d ;voy a iniciar otra linea
    inc dx
    cmp dx, 277d
    jne sigo2
    ret
            
pixelMenor: ;dibuja un pixelito
    mov ah, 0Ch
    mov al, 1111b
    mov bh, 00
    ;mov cx, 100d
    ;mov dx, 100d
    int 10h
    ret            
            
espera:
    mov ah, 00
    int 16h
    ret
            
fin:
    int 21h
    ret
            
letras:     
            
            ;posicion inicial del cursor
    mov ah, 02
    mov dh, 15d
    mov dl, 30d
    mov bh, 00
    int 10h
            
    ;"DIOS UNION LIBERTAD"
    mov al, "D"
    call caracter
            
    mov al, "I"
    call caracter
            
    mov al, "O"
    call caracter
            
    mov al, "S"
    call caracter
            
    mov al, " "
    call caracter
            
    mov al, "U"
    call caracter
            
    mov al, "N"
    call caracter
            
    mov al, "I"
    call caracter
            
    mov al, "O"
    call caracter
            
    mov al, "N"
    call caracter
            
    mov al, " "
    call caracter
            
    mov al, "L"
    call caracter
            
    mov al, "I"
    call caracter
            
    mov al, "B"
    call caracter
            
    mov al, "E"
    call caracter
            
    mov al, "R"
    call caracter
            
    mov al, "T"
    call caracter
            
    mov al, "A"
    call caracter
            
    mov al, "D"
    call caracter
            
    ret
            
caracter:
    mov ah, 09h
    mov bh, 00
    mov bl, 10011001b
    mov cx, 01
    int 10h

    mov ah, 0Eh
    mov bh, 00
    mov bl, 11111111b
    int 10h 
    ret

botonBorrar:

    ;coordenadas iniciales
    mov cx, 100d ;columna
    mov dx, 50d ;fila
sigo3:call pixelMayor2
    inc cx
    cmp cx, 200d
    jne sigo3
    mov cx, 100d ;voy a iniciar otra linea
    inc dx
    cmp dx, 100d
    jne sigo3
    ret

botonDibujar:

    ;coordenadas iniciales
    mov cx, 250d ;columna
    mov dx, 50d ;fila
sigo5:call pixelMayor
    inc cx
    cmp cx, 350d
    jne sigo5
    mov cx, 250d ;voy a iniciar otra linea
    inc dx
    cmp dx, 100d
    jne sigo5
    ret

pixelMayor2:;dibuja un pixelito
    mov ah, 0Ch
    mov al, 1010b
    mov bh, 00
    ;mov cx, 100d
    ;mov dx, 100d
    int 10h
    ret
    
verifica:
    ;verificando el click izq
peraClick:mov ax, 0005h
    mov bx, 0000h ;btn izq
    int 33h
    cmp bx, 0001h ;si lo ha presionado
    je comparar
    jne peraClick
comparar:            
    ;cuadro arriba
    cmp dx, 50d ;
    ja c_Arriba
    jb peraClick
    ;cuadro abajo
c_Arriba:cmp dx, 100d
    jb c_Abajo
    ja peraClick
    ;cuadro izq
c_Abajo:cmp cx, 100d
    ja c_Der
    jb peraClick
            
    ;cuadro der
c_Der:cmp cx, 200d
    jb borrar
    ja peraClick
borrar:call manta
    ret                              

verifica1:
    ;verificando el click izq
peraClick1:mov ax, 0005h
    mov bx, 0000h ;btn izq
    int 33h
    cmp bx, 0001h ;si lo ha presionado
    je compararDibujo
    jne peraClick1
compararDibujo:            
    ;cuadro arriba
    cmp dx, 50d ;
    ja c_Arriba1
    jb peraClick1
    ;cuadro abajo
c_Arriba1:cmp dx, 100d
    jb c_Abajo1
    ja peraClick1
    ;cuadro izq
c_Abajo1:cmp cx, 250d
    ja c_Der1
    jb peraClick1
    ;cuadro der
c_Der1:cmp cx, 350d
    jb rehacer
    ja peraClick1
rehacer:call bandera
    call letras
    ret                              


manta:
    ;coordenadas iniciales
    mov cx, 140d ;columna
    mov dx, 128d ;fila
sigo4:      call pixelMayor3
    inc cx
    cmp cx, 500d
    jne sigo4
    mov cx, 140d ;voy a iniciar otra linea
    inc dx
    cmp dx, 352d
    jne sigo4
    ret

pixelMayor3:;dibuja un pixelito
    mov ah, 0Ch
    mov al, 0000b
    mov bh, 00
    ;mov cx, 100d
    ;mov dx, 100d
    int 10h
    ret

ret