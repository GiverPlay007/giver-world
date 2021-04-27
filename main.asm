INCLUDE Irvine32.inc

.data
ground BYTE "------------------------------------------------------------------------------------------------------------------------", 0

xPos BYTE 16
yPos BYTE 10

inputChar BYTE ?

.code
main PROC
	; Draw ground (0, 29)
	mov dl, 0
	mov dh, 29
	call Gotoxy
	mov edx, OFFSET ground
	call WriteString

	call DrawPlayer

	gameLoop:
		; Get user input key char
		call ReadChar
		mov inputChar, al

		; Exit game if user types x
		cmp inputChar, "x"
		je exitGame

		cmp inputChar, "w"
		je moveUp

		cmp inputChar, "s"
		je moveDown

		cmp inputChar, "a"
		je moveLeft

		cmp inputChar, "d"
		je moveRight

		jmp gameLoop

		moveUp:
			call ClearPlayer
			dec yPos
			call DrawPlayer
			jmp gameLoop

		moveDown:
			call ClearPlayer
			inc yPos
			call DrawPlayer
			jmp gameLoop

		moveLeft:
			call ClearPlayer
			dec xPos
			call DrawPlayer
			jmp gameLoop

		moveRight:
			call ClearPlayer
			inc xPos
			call DrawPlayer
			jmp gameLoop

	jmp gameLoop

	exitGame:
		exit
main ENDP

DrawPlayer PROC
	; Draw player (xPos, yPos)
	mov dl, xPos
	mov dh, yPos
	call Gotoxy
	mov al, "X"
	call WriteChar
	ret
DrawPlayer ENDP

ClearPlayer PROC
	; Remove player from current position
	mov dl, xPos
	mov dh, yPos
	call Gotoxy
	mov al, " "
	call WriteChar
	ret
ClearPlayer ENDP

END main