; EXERCÍCIO 07 – Contador de Caracteres
; Autor: Ricardo Kratz - PUC Goiás

global main
extern printf, scanf

section .data
    msg_input  db "Digite uma string (max 100): ", 0
    fmt_str    db "%s", 0

    ; Mensagens separadas (um por linha)
    msg_vogais     db "Vogais: %ld", 10, 0
    msg_consoantes db "Consoantes: %ld", 10, 0
    msg_digitos    db "Algarismos: %ld", 10, 0
    msg_outros     db "Outros: %ld", 10, 0

section .bss
    texto       resb 100
    vogais      resq 1
    consoantes  resq 1
    algarismos  resq 1
    outros      resq 1

section .text
main:
    sub rsp, 8            ; alinhamento da pilha (System V ABI)

    ; Mostrar mensagem e ler string
    mov rdi, msg_input
    call printf

    mov rdi, fmt_str
    mov rsi, texto
    xor rax, rax
    call scanf

    ; Zerar contadores
    xor rax, rax
    mov [vogais], rax
    mov [consoantes], rax
    mov [algarismos], rax
    mov [outros], rax

    ; Rastrear string
    mov rsi, texto

.loop:
    mov al, [rsi]
    cmp al, 0
    je .fim

    ; Testa vogal
    cmp al, 'a'
    je .inc_v
    cmp al, 'e'
    je .inc_v
    cmp al, 'i'
    je .inc_v
    cmp al, 'o'
    je .inc_v
    cmp al, 'u'
    je .inc_v

    cmp al, 'A'
    je .inc_v
    cmp al, 'E'
    je .inc_v
    cmp al, 'I'
    je .inc_v
    cmp al, 'O'
    je .inc_v
    cmp al, 'U'
    je .inc_v

    ; Testa se letra (minúscula ou maiúscula) que não é vogal
    cmp al, 'a'
    jb .chk_upper
    cmp al, 'z'
    ja .chk_upper
    jmp .inc_c

.chk_upper:
    cmp al, 'A'
    jb .chk_digit
    cmp al, 'Z'
    ja .chk_digit
    jmp .inc_c

.chk_digit:
    cmp al, '0'
    jb .inc_o
    cmp al, '9'
    ja .inc_o
    jmp .inc_d

.inc_v:
    inc qword [vogais]
    inc rsi
    jmp .loop

.inc_c:
    inc qword [consoantes]
    inc rsi
    jmp .loop

.inc_d:
    inc qword [algarismos]
    inc rsi
    jmp .loop

.inc_o:
    inc qword [outros]
    inc rsi
    jmp .loop

.fim:
    ; Imprimir os resultados
    mov rdi, msg_vogais
    mov rsi, [vogais]
    xor rax, rax
    call printf

    mov rdi, msg_consoantes
    mov rsi, [consoantes]
    xor rax, rax
    call printf

    mov rdi, msg_digitos
    mov rsi, [algarismos]
    xor rax, rax
    call printf

    mov rdi, msg_outros
    mov rsi, [outros]
    xor rax, rax
    call printf

    add rsp, 8
    ret
