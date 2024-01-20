.386
.model flat, stdcall
option casemap :none
include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib
.data
str_hello BYTE "Hello World!", 0
.code
start:
invoke StdOut, addr str_hello
invoke ExitProcess, 0
END start