; EXERCÍCIO 03 - Versão com leitura do teclado
; Autor: Ricardo Kratz - PUC Goiás
; Lê uma string do teclado, altera os 3 primeiros caracteres e imprime o resultado

global main
extern printf, scanf

section .data
    msg_entrada  db "Digite uma string: ", 0
    fmt_str_in   db "%s", 0
    fmt_str_out  db "String modificada: %s", 10, 0

section .bss
    texto        resb 100     ; buffer de até 100 caracteres

section .text

main:
    sub rsp, 8                ; alinhamento da pilha

    ; --- Pede a string ao usuário ---
    mov rdi, msg_entrada
    xor rax, rax
    call printf

    ; --- Lê a string com scanf ---
    mov rdi, fmt_str_in
    mov rsi, texto
    xor rax, rax
    call scanf

    ; --- Altera os 3 primeiros caracteres ---
    mov byte [texto], 'X'
    mov byte [texto + 1], 'Y'
    mov byte [texto + 2], 'Z'

    ; --- Imprime a string modificada ---
    mov rdi, fmt_str_out
    mov rsi, texto
    xor rax, rax
    call printf

    add rsp, 8
    ret
