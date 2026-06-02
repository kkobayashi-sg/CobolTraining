


       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX12Q1.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WK-TABLE.
           03 WK-PRICE             PIC 9(8) VALUE 5000.
           03 WK-QTY               PIC 9(4) VALUE 3.
           03 WK-TOTAL             PIC 9(12).

       PROCEDURE DIVISION.
       MAIN-PARA.
           COMPUTE WK-TOTAL = WK-PRICE * WK-QTY.
           DISPLAY "WK-TOTAL [" WK-TOTAL "]".
           STOP RUN.
           
       


       