


       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX12Q3.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WK-IDX           PIC 9(3).
       01 WK-SUM           PIC 9(3).

           
       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM VARYING WK-IDX FROM 1
                   UNTIL WK-IDX > 10
               ADD WK-IDX TO WK-SUM
           END-PERFORM.
           DISPLAY "SUM [" WK-SUM "]"

           STOP RUN.

           
       


       