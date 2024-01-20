.386
.model flat, stdcall
option casemap:none
include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib

.data
str0 BYTE "please input ten number:",0
str1 BYTE "the Bubble Sort result is:",0
number_array Dword 10 DUP(0)
number_input BYTE 64 DUP(0)
number_output BYTE 64 DUP(0)
dec_index DWORD 10
count DWORD 10 ;输入十次
const10 Dword 10
str_sep BYTE ','

.code
start:
; 输入并将输入字符串数转化为十个十进制数
invoke StdOut,addr str0
Mov edi,offset number_array
;循环十次输入
Input_str:
	invoke StdIn,addr number_input,64
	Mov eax,0 ;用来存放十进制数
	Mov esi,0
str2dec:
	;将字符串转化为十进制数
	Mov bh,number_input[esi]
	Sub bh,48
	Movzx ebx,bh
	Mul dec_index  ;eax中存放乘法的结果且edx也会被影响
	Add eax,ebx
	inc esi
	cmp number_input[esi],0
	jnz str2dec
save_dec:
	;将十进制数存储到十进制数组中
	Mov [edi],eax
	Add edi,TYPE number_array
	Dec count
	cmp count,0
	jnz Input_str
	
; 冒泡排序
sort:
	Mov ecx,9 ;外层循环9次
L1:
	Mov ebx,ecx
	Mov edi,offset number_array
L2:
	Mov eax,[edi]
	cmp eax,[edi+4]
	JLE L3
	xchg eax,[edi+4] ;交换元素位置
	xchg eax,[edi]
L3:
	Add edi,TYPE number_array
	Loop L2
	Mov ecx,ebx
	Loop L1
;将十进制数转化为字符串
invoke StdOut,addr str1
	mov ebp,0
dec2str:
	mov esi,4
	mov eax,number_array[ebp]
save_result:
	mov edx,0
	div const10;
	add edx,48
	cmp dl,58
	mov BYTE PTR[number_output+esi],dl;
	dec esi
	cmp esi,0
	jnl save_result
	INVOKE StdOut, addr number_output
	INVOKE StdOut, addr str_sep
	add ebp,4
	cmp ebp,38
	jl dec2str

invoke ExitProcess,0
END start