;ejemplo_01 "visualizando el puntero (en el centro)"

        
        ;inicializando video
        mov ah, 00h
        mov al, 12h
        int 10h
        
        ;inicializando el raton
        mov ax, 0000h
        int 33h
        
        ;puntero
        mov ax, 0001h
        int 33h
        
        ;es pera
        mov ah, 00h
        int 16h
        
        int 21h
        