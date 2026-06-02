


       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX12Q2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WK-TEMPERATURE           PIC 9(3).

           
       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 30 TO WK-TEMPERATURE.

           EVALUATE TRUE
               WHEN WK-TEMPERATURE >= 35
                   DISPLAY "VERY HOT"
               WHEN (WK-TEMPERATURE >=25) AND (WK-TEMPERATURE <35)
                   DISPLAY "WARM"
               WHEN (WK-TEMPERATURE >=15) AND (WK-TEMPERATURE <25)
                   DISPLAY "COOL"
               WHEN OTHER
                   DISPLAY "COLD"
           END-EVALUATE.

           STOP RUN.

           
       


       