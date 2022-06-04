masm 
model small

.data
    first db 'Enter Hex Num: $'
    second db 'Enter next Hex Num: $'
    a db ?
    b db ?
    nLine db 10,13,'$'
    
.stack  
    db 256 dup ('?')

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    mov dx,offset first
    int 21h
    mov dx,offset nLine
    mov ah,9
    int 21
    
    ;1 num
    xor ax,ax
    mov ah,1h
    int 21h
    
    mov dh,al
    sub dh,30h
    cmp dh,9h
    jle M1
    sub dh,7h
M1:
    mov cl,4h
    shl dh,cl
    int 21h
    sub al,30h
    cmp al,9h
    jle M2
    sub al,7h
M2:
    add dh,al
    
    mov a,dh
    
    mov dx,offset nLine
    mov ah,9
    int 21h
    mov ah,9
    mov dx,offset second
    int 21h
    
    ;2 num
    xor ax,ax
    mov ah,1h
    int 21h
    
    mov dl,al
    sub dl,30h
    cmp dl,9h
    jle M3
    sub dl,7h
M3:
    mov cl,4h
    shl dl,cl
    int 21h
    sub al,30h
    cmp al,9h
    jle M4
    sub al,7h
M4:
    add dl,al
    
    mov b,dl
    
    mov dx,offset nLine
    mov ah,9
    int 21h
    
    mov dl, a
    mov cl, 1

    ;A / 2
    shr dl,cl
    mov al,b
    add dl,al ; A / 2 + B
    adc dh, 0
    
    ;Odd
    mov bx, 0101010101010101b
    or dx, bx

    ;Output 
    mov cx,16 
    mov bx,dx
    mov ah,2h
    mov dl,32
    int 21h
M5:
    mov dl,0
    sal bx,1
    adc dl,30h
    int 21h
    loop M5
    
    mov ax,4c00h
    int 21h
main endp

end main