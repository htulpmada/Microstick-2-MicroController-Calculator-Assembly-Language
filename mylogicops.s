 
;
; Just check out MPLAB

		.include "p24Hxxxx.inc"

       .global __reset          ;The label for the first line of code. 

         .bss            ;unitialized data section
;;These start at location 0x0800 because 0-0x07FF reserved for SFRs
u16_x:       .space 2
u8_a:       .space 1
u8_b:       .space 1
u8_c:       .space 1        ;Allocating space (in bytes) to variable.
u8_d:       .space 1        ;Allocating space (in bytes) to variable.
u8_e:       .space 1
u8_f:       .space 1

;..............................................................................
;Code Section in Program Memory
;..............................................................................

         .text           ;Start of Code section
__reset:                 ; first instruction located at __reset label
        mov #__SP_init, w15       ;Initalize the Stack Pointer
        mov #__SPLIM_init,W0   
        mov W0, SPLIM             ;Initialize the stack limit register
;__SP_init set by linker to be after allocated data      

;ux
  mov #0x0001,w0
  mov wreg,u16_x
;ua
  mov #0xaf,w0
  mov.b wreg,u8_a
;ub
  mov.b #0x50,w0
  mov.b wreg,u8_b
;uc=a&b
  mov.b u8_a,wreg
  and.b u8_b,wreg
  mov.b wreg,u8_c  
;ud=a|b
  mov.b u8_a,wreg
  ior.b u8_b,wreg
  mov.b wreg,u8_d  
;ue=a^b
  mov.b u8_a,wreg
  xor.b u8_b,wreg
  mov.b wreg,u8_e  
;uf=~a 
  mov.b u8_a,wreg
  com.b u8_a,wreg
  mov.b wreg,u8_f  
;ux=~ud | (ux & uc)
  mov u16_x,w0
  and u8_c,wreg
  com.b u8_d
  ior.b u8_d,wreg
  mov.b wreg, u16_x
  com.b u8_d;at end to restore value of d

done:
    goto     done    ;Place holder for last line of executed code

.end       ;End of program code in this file
