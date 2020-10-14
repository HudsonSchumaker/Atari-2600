; Hudson Schumaker
; Assembler should use basic 6502 instructions
	processor 6502
	
; Include files for Atari 2600 constants and handy macro routines
	include "vcs.h"
	include "macro.h"
	
; 4K Atari 2600 ROMs usually start at address $F000
  seg code
	org  $f000
START:
	  CLEAN_START    ; Call macro to safely clear the memory
BKG:
    lsr SWCHB	     ; test Console Reset switch
    bcc START	     ; reset?
    
    lda #$1C       ; Load color code into A register
    sta COLUBK     ; Store A to memory address $09 (TIA COLUBK)
    jmp BKG        ; Repeat from START
    
; Here we skip to address $FFFC and define a word with the
; address of where the CPU should start fetching instructions.
; This also fills out the ROM size to $1000 (4k) bytes
    org $FFFC      ; Defines origin to $FFFC
    .word START    ; Reset vector at $FFFC (where program starts)
    .word START    ; Interrupt vector at $FFFE (unused by the VCS)
