  processor 6502 

    ORG $c000
CHROUT = $FFD2
mscr = $FB
mcolor = $FD


; color constants
LT_GREEN = 13
DK_GREEN = 5

; screen dimensions
WIDTH = 40
HEIGHT = 10

START:
; turn screen black
    lda #0
    sta $d020
    sta $d021
    lda #147
    jsr CHROUT
; main loop
LOOP
    ldy #WIDTH-1
LOOP1:
    lda raindrops,y ;get raindrop position
    sta $0400,y
    cmp #HEIGHT-1
    bcs LOOP2
    jsr MUL40
    ; todo get random byte
    tya
    sta (mscr),y
    lda #DK_GREEN
    sta (mcolor),y
    
LOOP2
    dey
    bpl LOOP1
ENDUT:
    rts
    ;jmp LOOP

COLORS:
    byte 1,13,6,6,0
ENDCOLORS

numcolors = ENDCOLORS-COLORS


row:
     byte 0

MUL40:
    ; multiply by five
    sta mscr
    ldx #0
    stx mscr+1
    asl
    rol mscr+1
    asl
    rol mscr+1
    adc mscr
    bcc MUL40B
    inc mscr+1
MUL40B:
    ; multiply by eight
    rol 
    rol mscr+1
    rol
    rol mscr+1
    rol
    rol mscr+1
    ; write low byte
    sta mscr
    sta mcolor
    ; add 4 for screen location
    lda mscr+1
    clc
    adc #4
    sta mscr+1
    ; add more for color location
    adc #54272/256
    sta mcolor+1
    rts

; todo: randomize
; one raindrop for each column on the screen
raindrops: 
    byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
    byte 3,9,13,7,10,8,4,6
    byte 2,9,3,1,12,10,9,4
    byte 3,9,12,5,13,1,4,6
    byte 2,9,3,1,12,10,9,4
    byte 3,9,14,8,10,1,4,6

