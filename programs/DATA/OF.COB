



       IDENTIFICATION DIVISION.
       PROGRAM-ID. OF.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ITEM-TABLE.
           03 INPUT-DATA.
               05 INPUT-CODE       PIC X(5).
               05 INPUT-NAME       PIC X(20).

           03 OUTPUT-DATA.
               05 OUTPUT-CODE      PIC X(5).
               05 OUTPUT-NAME      PIC X(20).

       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 'JK17' TO INPUT-CODE.
           MOVE 'KAMATA' TO INPUT-NAME.

           MOVE INPUT-CODE OF INPUT-DATA TO OUTPUT-CODE OF OUTPUT-DATA.
           MOVE INPUT-NAME OF INPUT-DATA TO OUTPUT-NAME OF OUTPUT-DATA.

           DISPLAY "CODE->" OUTPUT-CODE.
           DISPLAY "NAME->" OUTPUT-NAME.


           STOP RUN.
           