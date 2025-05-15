; EXERCÍCIO 10 – Desenhar Retângulo
; Autor: Ricardo Kratz - PUC Goiás
; Desenhar Retângulo com Asteriscos

global main
extern printf, scanf

section .data
    msg_linhas  db "Digite o número de linhas: ", 0
    msg_colunas db "Digite o número de colunas: ", 0
    fmt_int     db "%ld", 0
    fmt_char    db "%c", 0
    char_ast    db '*', 0
    newline     db 10, 0

section .bss
    linhas  resq 1
    colunas resq 1

section .text
main:
    sub rsp, 8                ; alinhamento

    ; Ler número de linhas
    mov rdi, msg_linhas
    call printf
    mov rdi, fmt_int
    mov rsi, linhas
    xor rax, rax
    call scanf

    ; Ler número de colunas
    mov rdi, msg_colunas
    call printf
    mov rdi, fmt_int
    mov rsi, colunas
    xor rax, rax
    call scanf

    ; r12 = número de linhas (loop externo)
    mov r12, [linhas]

.loop_linha:
    cmp r12, 0
    je .fim

    ; r13 = número de colunas (loop interno)
    mov r13, [colunas]

.loop_coluna:
    cmp r13, 0
    je .nova_linha

    ; imprime '*'
    mov rdi, fmt_char
    movzx rsi, byte [char_ast]
    xor rax, rax
    call printf

    dec r13
    jmp .loop_coluna

.nova_linha:
    ; imprime \n
    mov rdi, fmt_char
    movzx rsi, byte [newline]
    xor rax, rax
    call printf

    dec r12
    jmp .loop_linha

.fim:
    add rsp, 8
    ret