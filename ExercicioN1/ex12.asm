; EXERCÍCIO 12 – Verifica se número é primo
; Autor: Ricardo Kratz - PUC Goiás
; Verificar se um número é primo

global main
extern printf, scanf

section .data
    msg_input  db "Digite um número: ", 0
    fmt_int    db "%ld", 0
    msg_sim    db "É primo", 10, 0
    msg_nao    db "Não é primo", 10, 0

section .bss
    num        resq 1
    i          resq 1
    resto      resq 1

section .text
main:
    sub rsp, 8

    ; Entrada
    mov rdi, msg_input
    call printf
    mov rdi, fmt_int
    mov rsi, num
    xor rax, rax
    call scanf

    ; carregar o número em rbx
    mov rbx, [num]
    cmp rbx, 2
    jl .nao_primo       ; se n < 2 → não é primo

    mov rcx, 2          ; rcx = divisor

.loop:
    cmp rcx, rbx
    je .eh_primo        ; nenhum divisor encontrado

    ; testar se rbx % rcx == 0
    mov rax, rbx
    xor rdx, rdx
    div rcx             ; rax / rcx → quociente em rax, resto em rdx
    cmp rdx, 0
    je .nao_primo       ; se resto == 0, não é primo

    inc rcx
    jmp .loop

.eh_primo:
    mov rdi, msg_sim
    call printf
    jmp .fim

.nao_primo:
    mov rdi, msg_nao
    call printf

.fim:
    add rsp, 8
    ret
