.386
.model flat, stdcall 
option casemap :none 
include D:\masm32\include\windows.inc 
include D:\masm32\include\kernel32.inc 
include D:\masm32\include\user32.inc 
includelib D:\masm32\lib\kernel32.lib 
includelib D:\masm32\lib\user32.lib 
.data
str_hello BYTE "Hello World!", 0 
.code 
start: 
invoke MessageBox, NULL, addr str_hello, addr str_hello, MB_OK 
invoke ExitProcess, 0
END start 
