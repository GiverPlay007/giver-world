INCLUDE Irvine32.inc

.data
ground BYTE "------------------------------------------------------------------------------------------------------------------------", 0

.code
main PROC
	; draw ground (0, 29)
	mov dl, 0
	mov dh, 29
	call Gotoxy
	mov edx, OFFSET ground
	call WriteString

	call ReadChar
	exit
main ENDP

END main