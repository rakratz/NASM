; EXERCÍCIO 08 – Converter para maiúsculas
; Autor: Ricardo Kratz - PUC Goiás
; Converte mínusculo para maiúsculo

global main
extern printf, scanf

section .data
    msg_input db "Digite uma string: ", 0
    fmt_str   db "%s", 0
    msg_out   db "String convertida: %s", 10, 0

section .bss
    entrada resb 100

section .text
main:
    sub rsp, 8              ; alinhamento da pilha

    ; mostrar mensagem
    mov rdi, msg_input
    call printf

    ; ler string
    mov rdi, fmt_str
    mov rsi, entrada
    xor rax, rax
    call scanf

    ; converter para maiúscula
    mov rsi, entrada        ; ponteiro para a string

.loop:
    mov al, [rsi]
    cmp al, 0
    je .fim

    ; Como converter letra minúscula para maiúscula:
    ; - Em ASCII, 'a' até 'z' vão de 97 a 122
    ; - As letras maiúsculas 'A' a 'Z' vão de 65 a 90
    ; - A diferença entre elas é sempre 32 ('a' - 'A' = 32)
    ; - Então: sub byte [rsi], 32

    ; se estiver entre 'a' e 'z', subtrair 32
    cmp al, 'a'
    jb .proximo
    cmp al, 'z'
    ja .proximo

    sub byte [rsi], 32      ; converte para maiúscula

.proximo:
    inc rsi
    jmp .loop

.fim:
    ; mostrar string convertida
    mov rdi, msg_out
    mov rsi, entrada
    xor rax, rax
    call printf

    add rsp, 8
    ret
