



       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX13Q1.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           
           SELECT ITF-FILE ASSIGN TO ITF
               ORGANIZATION SEQUENTIAL.

           


       DATA DIVISION.
       FILE SECTION.
       FD ITF-FILE.
       01 ITF-REC.
           03 GOODS-CODE                 PIC X(5).
           03 GODDS-NAME                 PIC X(20).
           03 GOODS-PRICE                PIC 9(8).
       
       WORKING-STORAGE SECTION.
       01 WK-EOF                       PIC X(1) VALUE 'N'.
       01 WK-COUNT                     PIC 9(8).
       

       

       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT ITF-FILE.

           READ ITF-FILE
               AT END MOVE 'Y' TO WK-EOF
           END-READ.

           PERFORM UNTIL WK-EOF = 'Y'
               ADD 1 TO WK-COUNT
               READ ITF-FILE
                   AT END MOVE 'Y' TO WK-EOF
               END-READ
           END-PERFORM.

           DISPLAY "TOTAL RECORDS:" WK-COUNT.


           CLOSE ITF-FILE.
           STOP RUN.

       