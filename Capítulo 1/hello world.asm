global _start

section .data                    ; Define o trecho como uma sessão de variáveis
message: db 'Hello, World!', 10  ; message é um rótulo, apelido para endereço de memória. db informa que message é um dado tipo byte. 'Hello, World!' é a
                                 ; nossa string e ,10 é o caractere quebra de linha do ASCII. Nesse caso, como usamos db, cada caractere tem um byte.
section .text                    ; Define o trecho como sessão de instruções, na prática, isso serve apenas para estruturar o código.

_start:                          ; Outro rótulo, dessa vez para definir um procedimento em ASM. Nosso objetivo é chamar o SO e imprimir na tela uma messagem.
    mov rax, 1                   ; RAX funciona armazenando o código da chamada do sistema, no caso, estamos chamando o código write(). 
    mov rdi, 1                   ; RDI, registrador que armazena aonde deve ser escrita nossa string. No caso, 1 significa o descritor stdout, ou seja, a tela.
    mov rsi, message             ; RSI, registrador que armazena aonde se encontra a string.
    mov rdx, 14                  ; RDX, registrador que funciona armazenando o tamanho em byte da nossa string.
    syscall                      ; Finalmente a chamada do sistema operacional.
    
    mov rax, 60                  ; Dessa vez, RAX armazemará o código de chamada de sistema 60, que indica para encerrar o programa ASM com a função exit().
    xor rdi,rdi                  ; Usando rdi XOR rdi, o resultado será 0, logo o parametro de exit() será 0, indicando ao SO que não houve problemas.
    syscall                      ; Chamada do sistema.
    
;Geralmente, ao executarmos algo em assembly, precisamos pedir permissão primeiro ao SO para então utilizar parte do hardware. Essa comunicação com o SO 
;se dá por meio das chamadas de sistema e essas chamadas de sistemas são funções(ou procedimentos) com parametros. No primeiro syscall, em RAX colocamos 1
;indicando que chamariamos a função write e assim, os parametros que passamos a ela foram aonde deve ser escrito, o endereço do que deve ser escrito e 
;quanto deve ser escrito indicao por RDI, RSI e RDX respectivamente.
