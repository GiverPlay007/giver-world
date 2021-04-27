INCLUDE Irvine32.inc

.code
main PROC
	mov eax, 1000h
	mov ebx, 2000h
	mov ecx, 3000h

	call DumpRegs
	exit
main ENDP
END main