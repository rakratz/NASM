; EXERCÍCIO Fatorial
; Autor: Ricardo Kratz - PUC Goiás
; Fatorial de um número
global main
extern printf, scanf

section .data
    msg_input db "Digite um número inteiro positivo: ", 0
    fmt_int db "%ld", 0
    msg_output db "Fatorial = %ld", 10, 0

section .bss
    num resq 1
    fat resq 1

section .text
main:
    sub rsp, 8 ; alinhamento da pilha

    ; Leitura de dados
    mov rdi, msg_input
    call printf 
    mov rdi, fmt_int
    mov rsi, num
    xor rax, rax  ; mov rax, 0
    call scanf

    ; fat = 1
    mov rax, 1
    mov [fat], rax

    ; cont (rbx) = num
    mov rbx, [num]
    cmp rbx, 0
    je .end_fat  ; Se num for Zero o fatorial de Zero é 1

.loop:
    mov rax, [fat]
    imul rax, rbx
    mov [fat], rax

    dec rbx
    cmp rbx, 0
    jne .loop

.end_fat:
    ; Escrever o Resultado do fatorial
    mov rdi, msg_output
    mov rsi, [fat]
    xor rax, rax
    call printf

    add rsp, 8 ; retornar a pilha
    ret