       IDENTIFICATION DIVISION.
       PROGRAM-ID. KJBM010.
      **************************************
      *
      *
      **************************************


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT ITF-FILE ASSIGN TO ITF
               ORGANIZATION LINE SEQUENTIAL.

           SELECT OTF-FILE ASSIGN TO OTF
               ORGANIZATION SEQUENTIAL.

           
       DATA DIVISION.
       FILE SECTION.
           FD ITF-FILE.
           01 ITF-REC.
           COPY KJCF010.
           
           
           FD OTF-FILE.
           01 OTF-REC.
           COPY KJCF020.

       WORKING-STORAGE SECTION.
           01 WK-EOF                       PIC X(1) VALUE 'N'.
           01 WK-COUNT                     PIC 9(5) VALUE ZERO.

       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT ITF-FILE.
           OPEN OUTPUT OTF-FILE.

           PERFORM READ-RTN.

           PERFORM UNTIL WK-EOF = 'Y'
               MOVE JF010-DATA-KBN 
                   TO JF020-DATA-KBN
               MOVE JF010-JUCHU-NO
                   TO JF020-JUCHU-NO
               MOVE 00 TO JF020-JUCHU-Y1
               MOVE JF010-JUCHU-YY TO JF020-JUCHU-Y2
               MOVE JF010-JUCHU-MM TO JF020-JUCHU-MM
               MOVE JF010-JUCHU-DD TO JF020-JUCHU-DD
               MOVE JF010-SHOHIN-NO TO JF020-SHOHIN-NO
               MOVE JF010-SURYO TO JF020-SURYO
               MOVE SPACE TO JF020-ERR-KBN-TBL
               MOVE SPACE TO JF020-SHOHIN-MEI
               MOVE ZERO TO JF020-TANKA
               MOVE ZERO TO JF020-KINGAKU
               WRITE OTF-REC
               PERFORM READ-RTN
           END-PERFORM.

           WRITE OTF-REC.

           CLOSE ITF-FILE.
           CLOSE OTF-FILE.
           STOP RUN.


           READ-RTN SECTION.
               READ ITF-FILE
                   AT END MOVE 'Y' TO WK-EOF
               END-READ.
           EXT.
               EXIT.
