; EXERCÍCIO 13 – Fibonacci com correções
global main
extern printf, scanf

section .data
    msg_input db "Digite quantos termos da Fibonacci: ", 0
    fmt_int   db "%ld", 0
    fmt_out   db "%ld ", 0
    fmt_char  db "%c", 0
    newline   db 10, 0

section .bss
    n       resq 1
    a       resq 1
    b       resq 1
    count   resq 1

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

    ; Inicializar a = 0, b = 1
    mov qword [a], 0
    mov qword [b], 1
    mov qword [count], 0

.loop:
    mov rax, [count]
    cmp rax, [n]
    jge .fim

    ; imprimir a
    mov rdi, fmt_out
    mov rsi, [a]
    xor rax, rax
    call printf

    ; proximo = a + b
    mov rax, [a]
    add rax, [b]

    ; a = b
    mov r8, [b]          
    mov [a], r8

    ; b = proximo
    mov [b], rax

    ; contador++
    inc qword [count]
    jmp .loop

.fim:
    ; imprimir quebra de linha
    mov rdi, fmt_char
    movzx rsi, byte [newline]
    xor rax, rax
    call printf

    add rsp, 8
    ret
