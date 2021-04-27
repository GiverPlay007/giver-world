INCLUDE Irvine32.inc

.data
ground BYTE "------------------------------------------------------------------------------------------------------------------------", 0

strScore BYTE "Score: ", 0
score BYTE 0

xPos BYTE 16
yPos BYTE 20

xCoinPos BYTE ?
yCoinPos BYTE ?

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
	
	call CreateRandomCoin
	call DrawCoin

	call Randomize

	gameLoop:
		; Check if is colliding with the coin
		mov bl, xPos
		cmp bl, xCoinPos
		jne notCollecting
		mov bl, yPos
		cmp bl, yCoinPos
		jne notCollecting
		; Collect the coin
		inc score
		call CreateRandomCoin
		call DrawCoin

		notCollecting:
			; Clear text color
			mov eax, white (black * 16)
			call SetTextColor

			; Draw score
			mov dl, 0
			mov dh, 0
			call Gotoxy
			mov edx, OFFSET strScore
			call WriteString
			mov al, score
			add al, '0'
			call WriteChar
		; Gravity logic
		gravity:
			cmp yPos, 28
			jge onGround

			; Make player fall
			call ClearPlayer
			inc yPos
			call DrawPlayer

			mov eax, 80
			call Delay
			jmp gravity

		onGround:
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
			; Allow player to jump
			mov ecx, 1
			jumpLoop:
				call ClearPlayer
				dec yPos
				call DrawPlayer
				mov eax, 50
				call Delay

			loop jumpLoop
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

DrawCoin PROC
	mov eax, yellow (yellow * 16)
	call SetTextColor
	mov dl, xCoinPos
	mov dh, yCoinPos
	call Gotoxy
	mov al, "O"
	call WriteChar
	ret
DrawCoin ENDP

CreateRandomCoin PROC
	mov eax, 35
	inc eax
	call RandomRange
	mov xCoinPos, al
	mov yCoinPos, 27
	ret
CreateRandomCoin ENDP

END main