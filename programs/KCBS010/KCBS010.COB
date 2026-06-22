       IDENTIFICATION DIVISION.
       PROGRAM-ID. KCBS010.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：共通(ID:KC)
      * プログラム名　：日付チェック
      * 作成日／作成者：2026/06/18　小林健太郎
      * 変更日／変更者：
      * 　　　変更内容：
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LASTDAY          PIC 9(2) VALUE 31.
       01 QUOTIENT         PIC 9(4).
       01 URU-REM          PIC 9(4).
       01 URUDOSHI         PIC X VALUE 'N'.

       01 YEAR-FOUR        PIC 9(4) VALUE 0.

       LINKAGE SECTION.
           COPY KCBS010P.

       PROCEDURE DIVISION USING KCBS010-P1.

           MOVE SPACE TO S010-RCD.

      *************6ケタ************************

           IF S010-P1-Y1 = SPACE
             MOVE 00 TO S010-P1-Y1
           END-IF.

      *****S010-DATEが数字でなければ、S010-RCDに'E'を入れる
           IF S010-DATE NOT NUMERIC
             MOVE 'E' TO S010-RCD
           END-IF.

      *****月S010-D6-MMが1未満もしくは12より大きいなら、S010-RCDに'E'を入れる
           IF (S010-D6-MM < 1) OR (S010-D6-MM > 12)
             MOVE 'E' TO S010-RCD
           END-IF.

      *****月によってLASTDAYを設定する
           EVALUATE S010-D6-MM
            WHEN 2
              MOVE 29 TO LASTDAY
            WHEN 4
            WHEN 6
            WHEN 9
            WHEN 11
              MOVE 30 TO LASTDAY
            WHEN OTHER
              MOVE 31 TO LASTDAY
           END-EVALUATE.

      *****日S010-D6-DDが1未満もしくはLASTDAYより大きいなら、S010-RCDに'E'を入れる
           IF (S010-D6-DD < 1) OR (S010-D6-DD > LASTDAY)
             MOVE 'E' TO S010-RCD
           END-IF.


           IF S010-P1-Y1 = 00
      *****年下2桁が90未満の時、年上2桁は20
             IF S010-D6-Y2 < 90
               MOVE 20 TO S010-P1-Y1
             ELSE
               MOVE 19 TO S010-P1-Y1
             END-IF
           END-IF.

           COMPUTE YEAR-FOUR = S010-P1-Y1 * 100 + S010-D6-Y2.

      *****年を400で割る
           DIVIDE YEAR-FOUR BY 400
             GIVING QUOTIENT
             REMAINDER URU-REM.

           IF URU-REM = 0
             MOVE 'Y' TO URUDOSHI
           ELSE
      *****年を100で割る
             DIVIDE YEAR-FOUR BY 100
               GIVING QUOTIENT
               REMAINDER URU-REM
             IF URU-REM = 0
               MOVE 'N' TO URUDOSHI
             ELSE
      *****年を4で割る
               DIVIDE YEAR-FOUR BY 4
                 GIVING QUOTIENT
                 REMAINDER URU-REM
               IF URU-REM = 0
                 MOVE 'Y' TO URUDOSHI
               ELSE
                 MOVE 'N' TO URUDOSHI
               END-IF
             END-IF
           END-IF.

      *****URUDOSHIが'N'かつ月日が2/29なら、S010-RCDに'E'を入れる
           IF (URUDOSHI = 'N') AND 
               ((S010-D6-MM = 2) AND (S010-D6-DD = 29))
             MOVE 'E' TO S010-RCD
           END-IF.

      *******************8ケタ*************

      *****S010-DATE8が数字でなければ、S010-RCDに'E'を入れる
           IF S010-DATE8 NOT NUMERIC
             MOVE 'E' TO S010-RCD
           END-IF.

      *****月S010-D8-MMが1未満もしくは12より大きいなら、S010-RCDに'E'を入れる
           IF (S010-D8-MM < 1) OR (S010-D8-MM > 12)
             MOVE 'E' TO S010-RCD
           END-IF.

      *****月によってLASTDAYを設定する
           EVALUATE S010-D8-MM
            WHEN 2
              MOVE 29 TO LASTDAY
            WHEN 4
            WHEN 6
            WHEN 9
            WHEN 11
              MOVE 30 TO LASTDAY
            WHEN OTHER
              MOVE 31 TO LASTDAY
           END-EVALUATE.

      *****日S010-D8-DDが1未満もしくはLASTDAYより大きいなら、S010-RCDに'E'を入れる
           IF (S010-D8-DD < 1) OR (S010-D8-DD > LASTDAY)
             MOVE 'E' TO S010-RCD
           END-IF.

      *****年を400で割る
           DIVIDE S010-D8-YY BY 400
             GIVING QUOTIENT
             REMAINDER URU-REM.

           IF URU-REM = 0
             MOVE 'Y' TO URUDOSHI
           ELSE
      *****年を100で割る
             DIVIDE S010-D8-YY BY 100
               GIVING QUOTIENT
               REMAINDER URU-REM
             IF URU-REM = 0
               MOVE 'N' TO URUDOSHI
             ELSE
      *****年を4で割る
               DIVIDE S010-D8-YY BY 4
                 GIVING QUOTIENT
                 REMAINDER URU-REM
               IF URU-REM = 0
                 MOVE 'Y' TO URUDOSHI
               ELSE
                 MOVE 'N' TO URUDOSHI
               END-IF
             END-IF
           END-IF.

      *****URUDOSHIが'N'かつ月日が2/29なら、S010-RCDに'E'を入れる
           IF (URUDOSHI = 'N') AND 
               ((S010-D8-MM = 2) AND (S010-D8-DD = 29))
             MOVE 'E' TO S010-RCD
           END-IF.

 