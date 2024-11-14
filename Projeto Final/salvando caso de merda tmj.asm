TITLE Batalha Naval - Projeto Final
.MODEL SMALL
.stack 0100h

IMPMENSAG MACRO MGSDESJ
              LEA DX, MGSDESJ
              MOV AH,09
              INT 21H
ENDM

PULA_LINHA MACRO
               PUSH AX
               PUSH DX
               MOV  AH, 02
               MOV  DL, 10
               INT  21H
               POP  DX
               POP  AX
ENDM

;Remover em Projeto Final;
Controle_Programa MACRO CONTROLE
                      LEA DX, CONTROLE
                      MOV AH,09
                      INT 21H
ENDM

INFORMATRIZ MACRO COLUNAINICIAL, LINHAINICIAL,LINHAFINAL
                MOV BX,COLUNAINICIAL
                MOV SI,LINHAINICIAL
                MOV DI,LINHAFINAL
ENDM
LIMPA_TELA MACRO
    ;Limpa a Tela
               MOV AH, 06H
               MOV AL, 0
               MOV BH, 07H
               MOV CX, 0
               MOV DX, 184FH
               INT 10H

    ;Move Cursor
               MOV AH, 02H
               MOV BH, 0        
               MOV DH, 10        ;Linha
               MOV DL, 0
               INT 10H
ENDM
Espaso MACRO QUANTIDADE
Local CONTAESPASOS, END_SPACES
                 PUSH CX
                 MOV  CX, QUANTIDADE
    CONTAESPASOS:
                 MOV  DL, 20H
                 MOV  AH,02
                 INT  21h
                 LOOP CONTAESPASOS
    END_SPACES:  
                 POP  CX
ENDM
SALVAMJOGO MACRO
               PUSH BX
               PUSH SI
               PUSH DI
ENDM
VOLTAVALOR MACRO
               POP BX
               POP SI
               POP DI
ENDM
.DATA
    MATRIZ       DW 0,0,0,0,0,0,1,1,1,0     ,     1,1,1,0,0,0,0,0,0,0
                 DW 0,0,1,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,0,0,0,0
                 DW 0,0,1,0,0,0,0,0,0,0     ,     0,0,0,1,1,0,0,0,0,0
                 DW 0,0,0,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,1,1,0,0
                 DW 0,0,0,0,0,0,0,1,1,0     ,     0,0,0,0,0,0,0,0,0,0
                 DW 0,0,0,0,0,0,0,1,0,0     ,     1,1,1,1,0,0,0,0,0,0
                 DW 1,1,1,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
                 DW 0,0,0,0,0,1,1,0,0,0     ,     1,1,0,0,0,0,0,1,1,0
                 DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
                 DW 1,1,1,1,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0

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
    LOGO1        DB 13,10,'              ===================================================              ', '$'
    LOGO2        DB 13,10,'              =                                                 =            ', '$'
    LOGO3        DB 13,10,'              =     Batalha     Naval     Em     Assembly       =            ','$'
    LOGO4        DB 13,10,'              =                                                 =            ','$'
    LOGO5        DB 13,10,'              ===================================================              ', 13,10, '$'
    ENTMSG1      DB 13,10,'              Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'
    ;Mensagens de controle;
    ;Mensagens de controle;
    ;Remover em Projeto Final;
    MSGCONTROLE  DB 13,10,'OK1', '$'
    MSGCONTROLE1 DB 13,10,'OK2', '$'
    MSGCONTROLE2 DB 13,10,'OK3', '$'
    MSGCONTROLE3 DB 13,10,'OK4', '$'
.CODE
MAIN PROC
    ;Acesso ao DATA
                  MOV               AX, @DATA
                  MOV               DS,AX

    ;Chamadas;
                  CALL              INICIAR

    ;Termina o programa
                  MOV               AH,4CH
                  INT               21H
MAIN ENDP
INICIAR PROC
                  LIMPA_TELA
                  IMPMENSAG         LOGO1
                  IMPMENSAG         LOGO2
                  IMPMENSAG         LOGO3
                  IMPMENSAG         LOGO4
                  IMPMENSAG         LOGO5
                  IMPMENSAG         ENTMSG1

                  MOV               CX, 3
                  XOR               BX,BX
                  XOR               DX,DX
                  MOV               AH,1

    LerEnt:       
                  INT               21h
                  CMP               AL, 0DH
                  JE                CompENT
                  MOV               DL,AL
                  ADD               BL, DL
                  LOOP              LerEnt
                  LIMPA_TELA
    ;Aqui ó - Gabi;
    CompENT:      
                  CMP               BL, 4
                  JB                RetornaEnt

    DivDerminadaM:
                  MOV               AX, BX
                  MOV               BL, 4
                  DIV               BL

    CompQUA:      
                  CMP               AH, 1
                  JE                QUA1

                  CMP               AH, 2
                  JE                QUA2

                  CMP               AH, 3
                  JE                QUA3
                      
                  CMP               AH, 0
                  JE                QUA4

    ;Vai determinar o quadrante ultilizado e definir o zerado;
    QUA1:         
                  INFORMATRIZ       0,0,360
                  CALL              QUARDANTEJOGO
                  JMP               RetornaEnt
    QUA2:         
                  INFORMATRIZ       20,0,360
                  CALL              QUARDANTEJOGO
                  JMP               RetornaEnt
    QUA3:         
                  INFORMATRIZ       0,400,760
                  CALL              QUARDANTEJOGO
                  JMP               RetornaEnt

    QUA4:         
                  INFORMATRIZ       20,400,760
                  CALL              QUARDANTEJOGO
                  JMP               RetornaEnt

    RetornaEnt:   
                  RET
INICIAR ENDP
QUARDANTEJOGO PROC
                  SALVAMJOGO
                  MOV               CX,10
                  
                  JMP               L1
    MudaLinha:    
                  SUB               BX,20
                  pula_linha                  
                  ADD               SI,40                  
                  MOV               CX,10                  
                  CMP               SI,DI
                  JG                Retornaimp
    L1:                       
                  MOV               AH, 02H
    IMPRIMELINHA: 
                  MOV               DX, MATRIZ [SI][BX]    
                  OR                DL,30H                 
                  INT               21H
                  ADD               BX,2
                  LOOP              IMPRIMELINHA
                  Espaso 15
                  JMP               MudaLinha
    Retornaimp:   
                  RET
QUARDANTEJOGO ENDP
END MAIN