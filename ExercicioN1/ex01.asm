; EXERCÍCIO 01 – Operações com dois números
; Autor: Ricardo Kratz - PUC Goiás
; Objetivo: Ler dois números inteiros e imprimir soma, 
; diferença, produto, quociente e resto.

global main
extern printf, scanf

section .data
    msg1       db "Digite o primeiro número: ", 0
    msg2       db "Digite o segundo número: ", 0

    fmt_in     db "%ld", 0
    fmt_out1   db "Soma: %ld", 10, 0
    fmt_out2   db "Diferença: %ld", 10, 0
    fmt_out3   db "Produto: %ld", 10, 0
    fmt_out4   db "Quociente: %ld", 10, 0
    fmt_out5   db "Resto: %ld", 10, 0

section .bss
    x          resq 1
    y          resq 1
    soma       resq 1
    dif        resq 1
    prod       resq 1
    quoc       resq 1
    resto      resq 1

section .text
main: 
    sub rsp, 8         ; alinhamento da pilha
    ; Leitura dos valores
    mov rdi, msg1
    xor rax, rax
    call printf
    
    mov rdi, fmt_in
    mov rsi, x
    xor rax, rax
    call scanf
    
    mov rdi, msg2
    xor rax, rax
    call printf
    
    mov rdi, fmt_in
    mov rsi, y
    xor rax, rax
    call scanf

    ; Operações Matemáticas
    
    ; Soma
    mov rax, [x]
    add rax, [y]
    mov [soma], rax
    
    ; Diferença
    mov rax, [x]
    sub rax, [y]
    mov [dif], rax
    
    ; Produto
    mov rax, [x]
    imul rax, [y]
    mov [prod], rax
     
     ; Divisão (quociente e Resto)
    mov rax, [x]
    cqo ; estende o RAX para RDX:RAX
    idiv qword [y]
    mov [quoc], rax
    mov [resto], RDX

    ; Impressão dos REsultados
    mov rdi, fmt_out1
    mov rsi, [soma]
    xor rax, rax
    call printf

    mov rdi, fmt_out2
    mov rsi, [dif]
    xor rax, rax
    call printf

    mov rdi, fmt_out3
    mov rsi, [prod]
    xor rax, rax
    call printf

    mov rdi, fmt_out4
    mov rsi, [quoc]
    xor rax, rax
    call printf

    mov rdi, fmt_out5
    mov rsi, [Resto]
    xor rax, rax
    call printf

    add rsp, 8
    ret