 
;
; Just check out MPLAB

		.include "p24Hxxxx.inc"

       .global __reset          ;The label for the first line of code. 

         .bss            ;unitialized data section
;;These start at location 0x0800 because 0-0x07FF reserved for SFRs
lsp:       .space 2        ;Allocating space (in bytes) to variable.
msp:       .space 2        ;Allocating space (in bytes) to variable.
sum:       .space 2        ;Allocating space (in bytes) to variable.
aa:      .space 2
bb:      .space 2

;..............................................................................
;Code Section in Program Memory
;..............................................................................

         .text           ;Start of Code section
__reset:                 ; first instruction located at __reset label
        mov #__SP_init, w15       ;Initalize the Stack Pointer
        mov #__SPLIM_init,W0   
        mov W0, SPLIM             ;Initialize the stack limit register
;__SP_init set by linker to be after allocated data      

;lsp
    mov #0x5411, w0;w0=5411
    mov wreg, lsp;lsp=5411
;msp
    mov #0x6495, w0;w0=6495
    mov wreg, msp;msp=6495
;sum
    mov #0, w0
    mov wreg, sum
;aa
    mov #100, w0
    mov wreg, aa

;bb
    mov #22, w0
    mov wreg, bb
;sum=lsp + msp
    mov lsp,wreg
    add msp,wreg
    mov wreg,sum

;sum=sum+aa+bb
    mov sum,wreg
    add aa,wreg
    add bb,wreg
    mov wreg,sum
    
done:
    goto     done    ;Place holder for last line of executed code

.end       ;End of program code in this file
