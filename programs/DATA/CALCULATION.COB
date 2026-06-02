



       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATION.


       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WK-TABLE.
           03 WK-PRICE         PIC 9(8) VALUE 1500.
           03 WK-QTY           PIC 9(4) VALUE 25.
           03 WK-SUBTOTAL      PIC 9(8).
           03 WK-TAX-RATE      PIC 9(10).
           03 WK-TOTAL      PIC 9(8).

       PROCEDURE DIVISION.
       MAIN-PARA.

           COMPUTE WK-SUBTOTAL = WK-PRICE * WK-QTY.

           COMPUTE WK-TAX-RATE =
               WK-SUBTOTAL * 0.10.
           
           COMPUTE WK-TOTAL = WK-SUBTOTAL + WK-TAX-RATE.


           DISPLAY "è¨åv" WK-SUBTOTAL.
           DISPLAY "è¡îÔê≈" WK-TAX-RATE.
           DISPLAY "çáåv" WK-TOTAL.

           STOP RUN.
           
           