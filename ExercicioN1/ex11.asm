global main
extern printf, scanf

section .data
    msg_a      db "Digite 5 valores para A:", 10, 0
    msg_b      db "Digite 5 valores para B:", 10, 0
    fmt_int    db "%ld", 0
    fmt_out    db "%ld ", 0
    msg_soA    db 10, "Somente em A: ", 0
    msg_soB    db 10, "Somente em B: ", 0
    msg_ambos  db 10, "Em A e B    : ", 0
    msg_uniao  db 10, "Em A ou B   : ", 0

section .bss
    A      resq 5
    B      resq 5
    soA    resq 5
    soB    resq 5
    inter  resq 5
    uniao  resq 10
    cont_soA   resq 1
    cont_soB   resq 1
    cont_inter resq 1
    cont_uniao resq 1

section .text
main:
    push rbp
    mov rbp, rsp

    ; Ler vetor A
    mov rdi, msg_a
    call printf
    xor rcx, rcx
.readA:
    cmp rcx, 5
    je .readB
    lea rsi, [A + rcx*8]
    mov rdi, fmt_int
    xor rax, rax
    call scanf
    inc rcx
    jmp .readA

    ; Ler vetor B
.readB:
    mov rdi, msg_b
    call printf
    xor rcx, rcx
.readB_loop:
    cmp rcx, 5
    je .processar
    lea rsi, [B + rcx*8]
    mov rdi, fmt_int
    xor rax, rax
    call scanf
    inc rcx
    jmp .readB_loop

; Processar conjuntos
.processar:
    xor r8, r8           ; índice A
    xor r9, r9           ; cont_soA
    xor r10, r10         ; cont_inter
.loopA:
    cmp r8, 5
    je .checkB
    mov rax, [A + r8*8]  ; elemento de A
    xor rcx, rcx
    xor rbx, rbx         ; flag encontrado
.checkB:
    cmp rcx, 5
    je .end_checkB
    cmp rax, [B + rcx*8]
    je .found_in_B
    inc rcx
    jmp .checkB
.found_in_B:
    mov [inter + r10*8], rax
    inc r10
    mov bl, 1
.end_checkB:
    test rbx, rbx
    jnz .next_A
    mov [soA + r9*8], rax
    inc r9
.next_A:
    inc r8
    jmp .loopA

; Verificar elementos apenas em B
.checkB:
    xor r8, r8           ; índice B
    xor r11, r11         ; cont_soB
.loopB:
    cmp r8, 5
    je .build_uniao
    mov rax, [B + r8*8]
    xor rcx, rcx
    xor rbx, rbx
.checkA:
    cmp rcx, 5
    je .end_checkA
    cmp rax, [A + rcx*8]
    je .found_in_A
    inc rcx
    jmp .checkA
.found_in_A:
    mov bl, 1
.end_checkA:
    test rbx, rbx
    jnz .next_B
    mov [soB + r11*8], rax
    inc r11
.next_B:
    inc r8
    jmp .loopB

; Construir união
.build_uniao:
    xor r12, r12         ; cont_uniao
    xor r8, r8
.copy_A:
    cmp r8, 5
    je .copy_B
    mov rax, [A + r8*8]
    mov [uniao + r12*8], rax
    inc r12
    inc r8
    jmp .copy_A
.copy_B:
    xor r8, r8
.add_B:
    cmp r8, 5
    je .imprimir
    mov rax, [B + r8*8]
    xor rcx, rcx
.check_uniao:
    cmp rcx, r12
    je .add_to_uniao
    cmp rax, [uniao + rcx*8]
    je .skip_B
    inc rcx
    jmp .check_uniao
.add_to_uniao:
    mov [uniao + r12*8], rax
    inc r12
.skip_B:
    inc r8
    jmp .add_B

; Imprimir resultados
.imprimir:
    mov [cont_soA], r9
    mov [cont_soB], r11
    mov [cont_inter], r10
    mov [cont_uniao], r12

    ; Imprimir soA
    mov rdi, msg_soA
    call printf
    xor rcx, rcx
.print_soA:
    cmp rcx, [cont_soA]
    je .print_soB
    mov rsi, [soA + rcx*8]
    mov rdi, fmt_out
    xor rax, rax
    call printf
    inc rcx
    jmp .print_soA

    ; Imprimir soB
.print_soB:
    mov rdi, msg_soB
    call printf
    xor rcx, rcx
.print_soB_loop:
    cmp rcx, [cont_soB]
    je .print_inter
    mov rsi, [soB + rcx*8]
    mov rdi, fmt_out
    xor rax, rax
    call printf
    inc rcx
    jmp .print_soB_loop

    ; Imprimir interseção
.print_inter:
    mov rdi, msg_ambos
    call printf
    xor rcx, rcx
.print_inter_loop:
    cmp rcx, [cont_inter]
    je .print_uniao
    mov rsi, [inter + rcx*8]
    mov rdi, fmt_out
    xor rax, rax
    call printf
    inc rcx
    jmp .print_inter_loop

    ; Imprimir união
.print_uniao:
    mov rdi, msg_uniao
    call printf
    xor rcx, rcx
.print_uniao_loop:
    cmp rcx, [cont_uniao]
    je .fim
    mov rsi, [uniao + rcx*8]
    mov rdi, fmt_out
    xor rax, rax
    call printf
    inc rcx
    jmp .print_uniao_loop

.fim:
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret