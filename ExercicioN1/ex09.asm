; EXERCÍCIO 09 – Contador Regressivo de 5 até 1
; Autor: Ricardo Kratz - PUC Goiás
; Contador Regressivo de 5 até 1

global main
extern printf

section .data
    fmt_int db "%ld", 10, 0     ; "%ld\n"

section .text
main:
    sub rsp, 8                 ; alinhamento da pilha

    mov rbx, 5                 ; contador começa em 5

.loop:
    ; imprimir valor atual
    mov rdi, fmt_int
    mov rsi, rbx
    xor rax, rax
    call printf

    dec rbx
    cmp rbx, 0
    jg .loop                   ; enquanto rbx > 0, repete

    add rsp, 8
    ret
