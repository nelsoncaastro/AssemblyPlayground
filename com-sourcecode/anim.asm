
Org 0100H
; ------------------------------------------------------------------------------------------------
;Configurando modo grafico
MOV AH,00H
MOV AL,12H
INT 10H

;Posicion inicial cuadro 1 (0,0)
MOV CX,0d
MOV DX,0d
MOV [0504H],CX; x de cuadro 1 se almacena en 0504H
MOV [0506H],DX; y de cuadro 1 se almacena en 0506H

;Posicion inicial cuadro 2 (540,0)
MOV CX,540d
MOV DX,0d
MOV [0508H],CX; x de cuadro 2 se almacena en 0508H
MOV [050AH],DX; y de cuadro 2 se almacena en 050AH

;Loop de animacion
next_frame: 
CALL clear_screen; Limiar la pantalla
CALL calc_pos; Actualizar posiciones de los cuadros

;Dibujar cuadro 1
MOV AL,1110b; Color amarillo
MOV CX, [0504H]; Saco las posiciones de memoria
MOV DX, [0506H]
MOV [0500H],CX; Guardo las posiciones para usarse dentro de la subrutina
MOV [0502H],DX
CALL rect

;Dibujar cuadro 2
MOV AL,1001b; Color azul claro
MOV CX,[0508H]; Saco las posiciones de memoria
MOV DX,[050AH]
MOV [0500H],CX; Guardo las posiciones para usarse dentro de la subrutina
MOV [0502H],DX
CALL rect

CALL delay; Espero un intervalo de tiempo
MOV CX,[504H]; Obtengo x1
CMP CX,540d; Comparar si x1 ya esta en su posicion final
JNE next_frame; Siguiente etapa de la animacion

MOV AH,00H
INT 16H
INT 20H

;Limpia la pantalla
clear_screen:
MOV AH,06H; Funcion scroll up
MOV AL,00H; Clear
MOV BH,00H; Atributo
MOV CL,00H; Columna inicial
MOV CH,00H; Fila inicial
MOV DL,4FH; Columna final
MOV DH,1DH; Fila final
INT 10H
RET

;Dibuja un cuadrado
rect:
MOV DX,[0502H]; Obtengo la posicion y
next_line: CALL line
INC DX
MOV SI,[502H]
ADD SI,100d
CMP DX,SI
JNE next_line
RET

;Dibuja una linea
line:
MOV CX,[500H]; Obtengo la posicion x
next_pixel: CALL pixel
INC CX
MOV SI,[500H]
ADD SI,100d
CMP CX,SI
JNE next_pixel
RET

;Dibuja un pixelito
pixel:
MOV AH,0CH
MOV BH,00H
INT 10H
RET

;Actualiza las posiciones de los cuadros
calc_pos:
;Calculando siguiente posicion cuadro 1
MOV CX,[0504H]; Obtengo posiciones actuales
MOV DX,[0506H]
ADD CX,5d; Muevo x  5 pixeles

;Formula de trayectoria 1
MOV AX,CX
MOV BX,19d
MUL BX
MOV BX,27d
DIV BX

ADD DX,AX; Sumo el desplazamiento en y
MOV [0504H],CX; Guardo nuevas posiciones
MOV [0506H],DX

;Calculando siguiente posicion cuadro 2
MOV CX,[0508H]
MOV DX,[050AH]
SUB CX,5d; Muevo x 5 pixeles

;Formula de trayectoria 2
MOV AX,CX
SUB AX,540d
MOV BX,19d
IMUL BX
MOV BX,27d
IDIV BX

SUB DX,AX; Sumo el desplazamiento en y
MOV [0508H],CX; Guardo nuevas posiciones
MOV [050AH],DX
RET

;Espero un intervalo de tiempo
delay:
MOV AH, 00H ;Obtengo contador de reloj en CX:DX
INT 1AH
MOV SI,DX; Guardo el tiempo inicial
timer:
MOV AH, 00H; Obtengo tiempo actual
INT 1AH
SUB DX,SI; Tiempo actual - tiempo inicial
CMP DX,0001H; Intervalo de tiempo que debo esperar
JB timer
RET








