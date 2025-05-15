; EXERCÍCIO 05 – Deslocamento de bit
; Autor: Ricardo Kratz - PUC Goiás
; Lê dois inteiros positivos x e y, calcula x*(a^y)
; sem usar pow e sem mul, usando apenas movimentação 
; de bits (deslocamento) e imprime o resultado.

global main
extern printf, scanf

section .data
    msg_x       db "Digite o valor de X: ", 0
    msg_y       db "Digite o valor de y: ", 0
    fmt_int     db "%ld", 0
    fmt_saida   db "Resultado: %ld", 10, 0

section .bss
    x           resq 1
    y           resq 1
    resultado   resq 1


section .text
main:
    ; Alinhar a pilha para chamada C
    sub rsp, 8

    ; Leitura do x
    mov rdi, msg_x
    xor rax, rax    ; mov rax, 0
    call printf

    mov rdi, fmt_int
    mov rsi, x
    xor rax, rax
    call scanf

    ; Leitura do y
    mov rdi, msg_y
    xor rax, rax    ; mov rax, 0
    call printf

    mov rdi, fmt_int
    mov rsi, y
    xor rax, rax
    call scanf

    ; reslutado x << y
    mov rax, [x]
    mov rcx, [y]
    sh1 rax, rc

   
    ; Escrever o resultado
    mov rdi, fmt_saida
    mov rsi, [resultado]
    xor rax, rax    ; mov rax, 0
    call printf

   ; restaurar a pilha
    add rsp, 8
    ret