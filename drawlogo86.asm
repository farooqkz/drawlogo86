;
; Copyright (C) 2017 Farooq Karimi Zadeh <farooghkarimizadeh at gmail dot com>
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;

org 0x7c00
mov AX, 0
mov DS, AX
; because nasm (by default) does optimization itself, I didn't bother!

jmp start
%include "pixels.inc" ; this include file has the pixels table and LEN
start:
mov AH, 0
mov AL, 0x13
int 0x10 ; changing mode to 13h


mov SI, pixels ; the pixels variable is in "pixels.inc" include file
mov DI, SI
add DI, LEN ; this should be declared in pixels.inc

mov BH, byte [SI] ; color of our dear pixel!
mov CL, 0 ; Y
mov CH, 0 ; and X
; X and Y may not be smaller than 0 or bigger than 15 + 1


loop: ; drawing pixels
call drawpix
inc SI
mov BH, byte [SI]
inc CH
cmp CH, 15 + 1
jnz loop
mov CH, 0
inc CL
cmp DI, SI
jnz loop

; now reboot if user pressed any key
mov AH, 0x10 ; input a character
int 0x16 ; from keyboard
int 0x19 ; this might not reboot any machine
         ; on some machines, it boots the
         ; next device.



drawpix:
; args: X, Y and Color in CH, CL and BH
; draws a 10x10 square which its starting 
; point is (X,Y) and (X+10,Y+10) its
; ending point
pusha

mov AL, 10 ; calculating real y
mul CL     ; which is 10*Y + 20
mov DX, AX ; and Y is the givel Y
add DX, 20 ; in CL

mov AL, 10 ; calculating real x
mul CH     ; which is 10*X + 80
mov CX, AX ; and X is the given X
add CX, 80 ; in CH

mov SI, CX ; saving starting values of CX
mov DI, DX ; and DX, we'll need them later

mov AH, 0x0C ; draw pixel function
mov AL, BH ; color of our dear pixels
mov BH, 0 ; page number

; this loop draws a 10x10 square
loopxy:
int 0x10
inc CX
push CX
sub CX, SI
cmp CX, 10
pop CX
jnz loopxy

inc DX
mov CX, SI
push DX
sub DX, DI
cmp DX, 10
pop DX
jnz loopxy

popa
ret

times 510 - ($-$$) db 0 ; edit these two lines to suit your need
dw 0xAA55 ; boot sign
