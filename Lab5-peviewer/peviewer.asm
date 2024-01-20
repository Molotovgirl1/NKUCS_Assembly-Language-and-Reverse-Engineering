.386
.model flat, stdcall
option casemap :none
include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\masm32.lib
includelib D:\masm32\lib\kernel32.lib

.data 
	buffin db 20 DUP(0) ;从文件中获取的内容
    buffout db 20 DUP(0) ;转换后输出的内容
    fileName db 20 DUP(0) ;文件名
    hFile HANDLE 0 ;文件句柄
	point db 0 ;记录偏移
	
	;定义输出字符串
    str0 db "Please input a PE file :",0    
    str1 db 0Ah,"IMAGE_DOS_HEADER",0
	str11 db 0Ah,"   e_magic: ",0
    str12 db 0Ah,"   e_lfanew: ",0
    str2 db 0Ah,"IMAGE_NT_HEADERS",0
	str21 db 0Ah,"   Signature: ",0 
    str3 db 0Ah,"IMAGE_FILE_HEADER",0
	str31 db 0Ah,"   Number0fSections: ",0 
    str32 db 0Ah,"   TimeDateStamp: ",0
    str33 db 0Ah,"   Charateristics: ",0
    str4 db 0Ah,"IMAGE_OPTIONAL_HEADER",0
	str41 db 0Ah,"   Address0fEntryPoint: ",0 
    str42 db 0Ah,"   ImageBase: ",0
    str43 db 0Ah,"   SectionAlignment: ",0
    str44 db 0Ah,"   FileAlignment: ",0
	
.code
start:
    invoke StdOut, ADDR str0
    invoke StdIn, ADDR fileName, 20
    
	;e_magic
    ;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           0,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
   
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
    invoke StdOut, ADDR str1
    invoke StdOut, ADDR str11
	invoke StdOut, ADDR [buffout+4]
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;e_lfanew
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           3Ch,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
	mov DWORD PTR point,eax
    invoke dw2hex, eax, ADDR buffout
    ;输出
    invoke StdOut, ADDR str12
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;Signature
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
    invoke StdOut, ADDR str2
	invoke StdOut, ADDR str21
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;Number0fSections
	add point,06h ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
    invoke StdOut, ADDR str3
	invoke StdOut, ADDR str31
	invoke StdOut, ADDR [buffout+4]
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;TimeDateStamp
	add point,02h ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str32
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;Charateristics
	add point,0Eh ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str33
	invoke StdOut, ADDR buffout+4
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;Address0fEntryPoint
	add point,12h ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str4
	invoke StdOut, ADDR str41
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;ImageBase
	add point,0Ch ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str42
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;SectionAlignment
	add point,04h ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str43
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
	;FileAlignment
	add point,04h ;改变point的偏移值
	;调用函数CreateFile来打开PE文件
    invoke CreateFile, ADDR fileName,\
                       GENERIC_READ,\
                       FILE_SHARE_READ,\
                       0,\
                       OPEN_EXISTING,\
                       FILE_ATTRIBUTE_ARCHIVE,\
                       0
    ;设置文件句柄
    mov hFile, eax
	;设置文件指针
    invoke SetFilePointer, hFile,\
                           point,\
                           0,\
                           FILE_BEGIN
	;读取文件内容，从hfile指向的位置读取20个字节到buffin
    invoke ReadFile, hFile,\
                     ADDR buffin,\
                     20,\
                     0,\
                     0
    ;将buffin转化为16进制存储到buffout
    mov eax, DWORD PTR buffin
    invoke dw2hex, eax, ADDR buffout
    ;输出
	invoke StdOut, ADDR str44
	invoke StdOut, ADDR buffout
	;调用函数CloseHandle关闭句柄
    invoke CloseHandle, hFile
	
    invoke ExitProcess, 0
END start
    