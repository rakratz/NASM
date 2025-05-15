; EXERCÍCIO Fatorial
; Autor: Ricardo Kratz - PUC Goiás
; Fatorial de um número
global main
extern printf, scanf

section .data
    msg_input  db "Digite um número inteiro positivo: ", 0
    fmt_int    db "%ld", 0
    msg_saida  db "Fatorial = %ld", 10, 0

section .bss
    num        resq 1
    resultado  resq 1

section .text
main:
    sub rsp, 8                  ; alinhamento da pilha

    ; Entrada do número
    mov rdi, msg_input
    call printf
    mov rdi, fmt_int
    mov rsi, num
    xor rax, rax
    call scanf

    ; Resultado = 1
    mov rax, 1
    mov [resultado], rax

    ; contador = num
    mov rbx, [num]
    cmp rbx, 0
    je .fim_calculo  ; Fatorial de 0 = 1

.loop:
    mov rax, [resultado]
    imul rax, rbx
    mov [resultado], rax

    dec rbx
    cmp rbx, 0
    jne .loop


.fim_calculo:
     ; imprimir resultado
    mov rdi, msg_saida
    mov rsi, [resultado]
    xor rax, rax
    call printf

    add rsp, 8
    ret