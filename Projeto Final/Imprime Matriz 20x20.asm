TITLE Batalha Naval - Projeto Final
.MODEL SMALL
.stack 0100h
IMPLOGO macro PART1,PART2,PART3,PART4,PART5,MSGPRIN
            LEA DX, PART1
            MOV AH,09
            INT 21H

            LEA DX, PART2
            MOV AH,09
            INT 21H

            LEA DX, PART3
            MOV AH,09
            INT 21H

            LEA DX, PART4
            MOV AH,09
            INT 21h

            LEA DX, PART5
            MOV AH,09
            INT 21H

            LEA DX, MSGPRIN
            MOV AH,09
            INT 21H
ENDM
Controle_Programa macro CONTROLE
                      LEA DX, CONTROLE
                      MOV AH,09
                      INT 21H
ENDM
Pula_linha macro
               PUSH AX
               PUSH DX
               MOV  AH,02
               MOV  DL,10
               INT  21H
               POP  DX
               POP  AX
endm
ImprimeQUA macro VALORCOL,INCIALSI,INTEI,REGVALOR,MATRIZIMP
                 Local      MudaLinha
                 Local      L1
                 Local      IMPRIMELINHA
                 Local      Retornaimp

                 MOV        BX,VALORCOL
                 MOV        SI,INCIALSI
                 MOV        CX,INTEI
                 JMP        L1
    MudaLinha:   
                 MOV        BX,VALORCOL            ; zera o índice da coluna
                 ADD        SI,40                  ; Muda a linha
                 MOV        CX,INTEI                 ;Volta o valor de cx para o loop
                 CMP        SI,REGVALOR
                 JG         Retornaimp
    L1:          
                 pula_linha
                 MOV        AH, 02H
    IMPRIMELINHA:
                 MOV        DX, MATRIZIMP [SI][BX]    ; coloca o elemento MATRIZ4X4[0,0] em AL
                 OR         DL,30H                 ; nUmero em caractere
                 INT        21H
                 ADD        BX,2
                 LOOP       IMPRIMELINHA
                 JMP        MudaLinha
    Retornaimp:  
endm
ZeraMatriz macro COLUNAI,LINHAI,NUMDREP,LINHAMAX,MATRIZZERA
                 Local      PROXLinha
                 Local      ZERALINHA
                 Local      RetornaZera

                 MOV        BX,COLUNAI
                 MOV        SI,LINHAI
                 MOV        CX,NUMDREP
                 JMP        ZERALINHA
    PROXLinha:   
                 MOV        BX,COLUNAI            ; zera o índice da coluna
                 ADD        SI,40                  ; Muda a linha
                 MOV        CX,NUMDREP                  ;Volta o valor de cx para o loop
                 CMP        SI,LINHAMAX
                 JG         RetornaZera
                 
    ZERALINHA:
                 MOV        MATRIZZERA [SI][BX],0    ; coloca o elemento MATRIZ4X4[0,0] em AL
                 ADD        BX,2
                 LOOP       ZERALINHA
                 JMP        PROXLinha

    RetornaZera:  
    ENDM
.DATA
    MATRIZ       DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2

                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4


    VETOR        DB 10 DUP (0)
    ;Mensagens;
    ;Pagina Inicial;
    LOGO1        DB 13,10,'             ===================================================             ', '$'
    LOGO2        DB 13,10,'             =                                                 =            ', '$'
    LOGO3        DB 13,10,'             =     Batalha     Naval     Em     Assembly       =            ','$'
    LOGO4        DB 13,10,'             =                                                 =            ','$'
    LOGO5        DB 13,10,'             ===================================================             ', 13,10, '$'
    ENTMSG1      DB 13,10,'              Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'
    MSGCONTROLE  DB 13,10,'OK1', '$'
    MSGCONTROLE1 DB 'OK2', '$'

.CODE
MAIN PROC
    ;Acesso ao DATA
            MOV     AX, @DATA
            MOV     DS,AX

            CALL    INICIAR
            CALL    ZeraQua

    ;Termina o programa
            MOV     AH,4CH
            INT     21H
MAIN ENDP
INICIAR PROC
            IMPLOGO LOGO1, LOGO2, LOGO3, LOGO4, LOGO5, ENTMSG1
            MOV     AH,1
            INT     21h
            MOV     DL,AL

            RET
INICIAR ENDP
ZeraQua PROC
    pula_linha
    ImprimeQUA 0,0,20,760,MATRIZ

    ZeraMatriz 0,0,20,760,MATRIZ

    pula_linha
    ImprimeQUA 0,0,20,760,MATRIZ

    RET
ZeraQua ENDP
END MAIN