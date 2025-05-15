; EXERCÍCIO 14 – Soma dos dígitos
; Autor: Ricardo Kratz - PUC Goiás
; Soma dos Dígitos
; Entrada: 1234 → Saída: 10 (1 + 2 + 3 + 4)
; n = 123 → soma = 0
; 123 % 10 = 3 → soma = 3
; 123 / 10 = 12
; 12 % 10 = 2 → soma = 5
; 12 / 10 = 1
; 1 % 10 = 1 → soma = 6

global main
extern printf, scanf

section .data
    msg_input db "Digite um número: ", 0
    fmt_int   db "%ld", 0
    msg_saida db "Soma dos dígitos: %ld", 10, 0

section .bss
    n     resq 1
    soma  resq 1
    temp  resq 1

section .text
main:
    sub rsp, 8

    ; Entrada
    mov rdi, msg_input
    call printf
    mov rdi, fmt_int
    mov rsi, n
    xor rax, rax
    call scanf

    ; soma = 0
    mov qword [soma], 0

    ; temp = n
    mov rax, [n]
    mov [temp], rax

.loop:
    mov rax, [temp]
    cmp rax, 0
    je .fim

    ; resto = temp % 10
    xor rdx, rdx
    mov rbx, 10
    div rbx            ; rax = temp / 10, rdx = temp % 10

    ; soma += rdx
    mov rcx, [soma]
    add rcx, rdx
    mov [soma], rcx

    ; temp = temp / 10 (já está em rax)
    mov [temp], rax
    jmp .loop

.fim:
    ; exibir resultado
    mov rdi, msg_saida
    mov rsi, [soma]
    xor rax, rax
    call printf

    add rsp, 8
    ret
