 
;
; Just check out MPLAB

		.include "p24Hxxxx.inc"

       .global __reset          ;The label for the first line of code. 

         .bss            ;unitialized data section
;;These start at location 0x0800 because 0-0x07FF reserved for SFRs
i:       .space 2
j:       .space 2
k:       .space 2
l:       .space 2        ;Allocating space (in bytes) to variable.
m:       .space 2        ;Allocating space (in bytes) to variable.
xx:      .space 2
yy:      .space 2

;..............................................................................
;Code Section in Program Memory
;..............................................................................

         .text           ;Start of Code section
__reset:                 ; first instruction located at __reset label
        mov #__SP_init, w15       ;Initalize the Stack Pointer
        mov #__SPLIM_init,W0   
        mov W0, SPLIM             ;Initialize the stack limit register
;__SP_init set by linker to be after allocated data      

;i
    mov #11,w0
    mov wreg, i
;j
    mov #54,w0
    mov wreg, j
;k
    mov #95,w0
    mov wreg, k
;l=i+k
    mov i, wreg
    add k, wreg
    mov wreg, l
;m=j-l
    mov j, w0
    ;sub w0, l, wreg
    mov wreg, m
;xx=xx-yy-m
    mov #0xdead,w0
    mov wreg, xx
    mov #0xbeef,w0
    mov wreg, yy
    mov xx,w0
    mov yy,w1
    mov m, w2
    sub w0, w1,w0
    sub w0, w2, w0
    mov wreg, xx

done:
    goto     done    ;Place holder for last line of executed code

.end       ;End of program code in this file
