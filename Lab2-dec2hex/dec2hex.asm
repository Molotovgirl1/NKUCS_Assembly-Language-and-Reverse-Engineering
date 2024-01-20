.386
.model flat, stdcall
option casemap :none
include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib

.data
str1 BYTE "please input a dec number(0-4294967295):", 0
str2 BYTE "the dec num to hex number is:", 0
buf BYTE 20 DUP(0) ;十进制字符串
hexstr BYTE 9 DUP(48) ;十六进制字符串
hex_index DWORD 16 
dec_index DWORD 10
decnum DWORD 0 ;十进制数
remainder DWORD 0 ;余数

.code
start:
	invoke StdOut,addr str1
	invoke StdIn,addr buf,20
	
	;将十进制字符串转化为十进制数
	Mov eax,0 ;用来存放十进制数
	Mov esi,0
	
str2dec:
	cmp buf[esi],0
	jz init_hex
	Mov bh,buf[esi]
	Sub bh,48
	Movzx ebx,bh
	Mul dec_index  ;eax中存放乘法的结果且edx也会被影响
	Add eax,ebx
	inc esi
	jmp str2dec
;将十进制数转化为十六进制字符串
init_hex:
	;给十六进制字符串最后一位加上'\0'
	Mov decnum,eax 
	Mov esi,0
	Mov esi,offset hexstr
	Add esi,8
	mov bh,0
	mov [esi],bh

dec2hex:
	mov eax,0
	mov edx,0
	
	mov eax,decnum
	div hex_index ;eax中存放除法的商，edx中存放除法的余数
	mov decnum,eax
	cmp edx,10 ;当余数大于等于10时，把余数变为字母
	jnc toletter 
	
	add edx,48
save_remainder:
	dec esi
	Mov remainder,edx
	Mov dh,BYTE ptr remainder
	Mov [esi],dh
	
	cmp eax,0 ;判断是否除完
	jz display
	jmp dec2hex
	
toletter:
	add edx,55
	jmp save_remainder

display: 
	invoke StdOut,addr str2
	invoke StdOut,addr hexstr
	
	invoke ExitProcess,0
END start