


       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX12Q4.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WK-IDX           PIC 9(3) OCCURS 10 TIMES.
       01 WK-I             PIC 9(2).
       01 WK-MAX           PIC 9(2).
       

           
       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 17 TO WK-IDX(1).
           MOVE 50 TO WK-IDX(2).
           MOVE 38 TO WK-IDX(3).
           MOVE 77 TO WK-IDX(4).
           MOVE 21 TO WK-IDX(5).
           MOVE 3 TO WK-IDX(6).
           MOVE 25 TO WK-IDX(7).
           MOVE 9 TO WK-IDX(8).
           MOVE 69 TO WK-IDX(9).
           MOVE 81 TO WK-IDX(10).

           PERFORM VARYING WK-I FROM 1 BY 1
                   UNTIL WK-I > 10
               IF WK-IDX(WK-I)>WK-MAX
                   MOVE WK-IDX(WK-I) TO WK-MAX
               END-IF
           END-PERFORM.
           DISPLAY "MAX [" WK-MAX "]"

           STOP RUN.

           
       


       