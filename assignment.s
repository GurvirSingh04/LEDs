;Written in Notepad (Windows)
.equ SREG,  0x3F    ; Status register

.equ DDRD,  0x0A    ; Register defining pins on port B to be input (0) or output (1)
.equ PORTD, 0x0B    ; Output port for PORTD

.equ DDRB,  0x04    ; Register defining pins on port B to be input (0) or output (1)
.equ PORTB, 0x05    ; Output port for PORTB

.org 0                  
          ; reset system status
main:     ldi r16, 0      ; Sets register 16 to zero
          out SREG,r16    ; copy register 16 to SREG, set SREG to zero

          ; set lower 4 bits of port B bits to output mode
          ldi r16, 0x0F   ; set r16 to 0x0F -> switch on bit 0 -> bit 0 is an output
          out DDRB,r16    ; copy the value to DDRB

	  ; set upper 4 bits of port D bits to output mode
          ldi r16, 0xF0   ; set r16 to 0xF0 -> switch on bit 0 -> bit 0 is an output
          out DDRD,r16    ; copy the value to DDRD


;Task 1 starts here - displaying my k-number(23010952)
 
mainloop: ldi r16, 0x02    ;sets register 16 to two
          call sec	   ;display for 1 second
          
          ldi r16, 0x03
          call sec
          
          ldi r16, 0x00
          call sec
          
          ldi r16, 0x01
          call sec
          
          ldi r16, 0x00
          call sec
          
          ldi r16, 0x09
          call sec
          
          ldi r16, 0x05
          call sec
          
          ldi r16, 0x02
          call sec
          
          ;Task 2 starts here - Displaying G.S

          ldi r16, 0x07   ;sets register 16 to 7 --> G
          call sec        ;display for 1 second
          
          ldi r16, 0x1B   ;sets register 16 to 27 --> .     
          call sec
          
          ldi r16, 0x13   ;sets register 16 to 19 --> S
          call sec
          
          
          ;Task 3 begins here - morse code

          ldi r20, 25   ;sets register 20 to 25, used to check if the morse code has been displayed 50 times
          ldi r21, 0   ;sets register 21 to 0, used to check if the iteration is divisible by 5

; This subroutine will run for 25 times because 25 * 2 = 50
; For each iteration of check, the morse code will be displayed in normal order and reverse order
; Since the first iteration each time check is called will be odd, the morse code is displayed in normal order
; After the morse code is displayed in order, the next iteration will be even, so the morse code is displayed in reverse order
 
check:	   dec r20        ;decrements the value stored in register 20
	   call morse     ;display the morse code in normal order (GUR)
	   call reverse   ;display the morse code in reverse order (RUG)
	   cpi r20, 0     ;compare the value stored in r20 with 0
	   brne check     ;run check for 25 times
	   
; Task 4 begins here - Ping-pong

          ldi r16, 0x01   ;Sets register 16 to 1 

left:     call sec        ;display the content of register 16
          lsl r16         ;shift r16 1 bit to the left    
          cpi r16, 0x80   ;check if the right-most bit lit up
          brne left       ;run left until the right-most bit lights up, after that go to right
	   
right:	  call sec         ;display the content of register 16
	  lsr r16          ;shift r16 1 bit to the left
	  cpi r16, 0x01    ;check if the left-most bit lit up
	  brne right       ;run right until the left-most bit lights up, after that go to left
	  rjmp left        ;jump back to left, runs this code infinitely

; Morse code in normal order G U R
; G --> dash dash dot
; U --> dot dot dash
; R --> dot dash dot
   
morse:	  inc r21          ;increment register 21

          ;G morse code begins here

	  ldi r16, 0x01    ;turn on the LED
          call dash        
          
          ldi r16, 0x00    ;turn off the LED
          call dot         ;delay by 200ms
          
          ldi r16, 0x01
          call dash
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot
          
          ;Inter-letter space

          ldi r16, 0x00
          call dash       ;delay by 600ms
          
          ;U morse code begins here

          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dash
          
          ;Inter-letter space

          ldi r16, 0x00
          call dash
          
          ;R morse code begins here

          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dash
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dash
          
          ;check if this is the fifth iteration

          cpi r21, 0x05
	  breq five       ;if true display 5
          
          ;Inter-word space

          ldi r16, 0x00
          call end        ;delay by 1400ms
          
          ret


; display five on fifth iteration
five:     ldi r16, 0x05
          ldi r21, 0x00   ; reset register 21
          call sec        ; display five for 1 second
	  
	  ;Inter-word space
	  ldi r16, 0x00
          call end

; Morse code in reverse order R U G
; R --> dot dash dot
; U --> dot dot dash
; G --> dash dash dot

reverse:  inc r21
          
          ;R morse code begins here

	  ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dash
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot

          ;Inter-letter space

          ldi r16, 0x00
          call dash
          
          ;U morse code begins here

          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dash
          
          ;Inter-letter space

          ldi r16, 0x00
          call dash
          
          ;G morse code begins here 

          ldi r16, 0x01
          call dash
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dash
          
          ldi r16, 0x00
          call dot
          
          ldi r16, 0x01
          call dot
          
          ;Inter-letter space

          ldi r16, 0x00
          call dash
          
          ;check if this is the fifth iteration
          ;repeated code due to the limitation of BREQ(can only be used between a maximum of 64 lines)

          cpi r21, 0x05
	  breq five2
	  
          ;Inter-word space

          ldi r16, 0x00
          call end
       
          ret

; display five on fifth iteration        
five2:    ldi r16, 0x05  
          ldi r21, 0x00
          call sec

	  ldi r16, 0x00
	  call end
          
; delay subroutine - sets the delay for 1 seconds
sec:      ldi r19, 100
	  ; 5*255*126*100 = 16065000 cycles
	  ; 16065000 / 16000000 = 1.0040625 seconds 
          rjmp display

; delay subroutine - sets the delay for 200 ms
dot:      ldi r19, 20
	  ; 5 * 255 * 126 * 20 = 3213000 cycles
	  ; 3213000 / 16000000 = 0.2008125 seconds 
	  rjmp display
	 
; delay subroutine - sets the delay for 600 ms
dash:     ldi r19, 60
	  ; 5 * 255 * 126 * 60 = 9639000 cycles
	  ; 9639000 / 16000000 = 0.6024375 seconds 
	  rjmp display          
          
; delay subroutine - sets the delay for 1400 ms
end:      ldi r19, 140
	  ; 5 * 255 * 126 * 140 = 22491000 cycles
	  ; 22491000 / 16000000 = 1.4056875 seconds 
	  rjmp display
          
;displays the value stored in register 16 on the output bits set for PORTB and PORTD         
display:  out PORTB, r16
          out PORTD, r16

;delay subroutine - delays for the amount of time set       
delay:    nop        ; 1 cycle
          dec r17    ; 1 cycle
          cpi r17, 0 ; 1 cycle
          brne delay ; 2 cycles
          ldi r17, 255 ; reset inner loop
          dec r18
          cpi r18, 0
          brne delay
          ldi r18, 126 ; reset first outer loop
          dec r19
          cpi r19, 0
          brne delay
          ret
