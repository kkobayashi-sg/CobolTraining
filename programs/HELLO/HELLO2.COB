      ********************************************************************
      *プログラム名：HELLO2
      *機能　　　　：名前を使ったメッセージを表示する
      ********************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WK-NAME             PIC X(10) VALUE 'KOBAYASHI'.

       PROCEDURE DIVISION.
       MAIN-PARA.
           DISPLAY  '========================'.
           DISPLAY  'GOOD EVENING, ' WK-NAME '!'.
           DISPLAY  'HELLO, ' WK-NAME '!'.
           DISPLAY  WK-NAME ', LONG TIME NO SEE!'
           DISPLAY  '========================'.
           STOP RUN.