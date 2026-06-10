       IDENTIFICATION DIVISION.
       PROGRAM-ID. KUBM020.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：受注 (ID: KJ)
      * プログラム名　：受注データ形式チェック
      * 作成日／作成者：2026/06/09　小林健太郎
      * 変更日／変更者：
      * 　　　変更内容：
      ******************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ITF-FILE ASSIGN TO ITF
               ORGANIZATION SEQUENTIAL.
           SELECT OTF-FILE ASSIGN TO OTF
               ORGANIZATION SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
           FD ITF-FILE.
           01 ITF-REC.
           COPY KUCF010.
           
           FD OTF-FILE.
           01 OTF-REC.
           COPY KUCF020.

       WORKING-STORAGE SECTION.
           01 ITF-END-FLG                  PIC X(1) VALUE 'N'.
           01 ITF-CNT                    PIC 9(5) VALUE ZERO.
           01 OTF-CNT                    PIC 9(5) VALUE ZERO.
           01 SHOHIN-NO-MEMORY             PIC 9(5) VALUE ZERO.
           01 JUCHU-DATE-MEMORY.
               03 JUCHU-DATE-MEMORY-YY     PIC 9(4) VALUE ZERO.
               03 JUCHU-DATE-MEMORY-MM     PIC 9(2) VALUE ZERO.
      *
      ******************************************************************
      *受注チェックファイル作成
      ******************************************************************
       PROCEDURE DIVISION.
           PERFORM INIT-RTN.
           PERFORM MAIN-RTN UNTIL ITF-END-FLG = "Y".
           PERFORM WRITE-RTN.
           PERFORM TERM-RTN.
           STOP RUN.
      ******************************************************************
      *開始処理
      ******************************************************************
       INIT-RTN SECTION.
           DISPLAY "*** KUBM020 START ***".

           OPEN INPUT ITF-FILE.
           OPEN OUTPUT OTF-FILE.

           PERFORM READ-RTN.
       EXT.
           EXIT.
      ******************************************************************
      *入力処理
      ******************************************************************
       READ-RTN SECTION.
           READ ITF-FILE
                AT END
                   MOVE 'Y' TO ITF-END-FLG
               NOT AT END
                   ADD 1 TO ITF-CNT
           END-READ.
       EXT.
           EXIT.
      ******************************************************************
      *編集処理
      ******************************************************************
       MAIN-RTN SECTION.
           
           IF UF010-SHOHIN-NO NOT = SHOHIN-NO-MEMORY OR
               UF010-JUCHU-YY NOT = JUCHU-DATE-MEMORY-YY OR
               UF010-JUCHU-MM NOT = JUCHU-DATE-MEMORY-MM

               IF ITF-CNT > 1
                   PERFORM WRITE-RTN
               END-IF
       
               MOVE SPACE TO OTF-REC
               MOVE ZERO TO UF020-KINGAKU
       
               MOVE UF010-SHOHIN-NO TO UF020-SHOHIN-NO
               MOVE UF010-SHOHIN-NO TO SHOHIN-NO-MEMORY
               MOVE UF010-JUCHU-YY TO UF020-JUCHU-YY
               MOVE UF010-JUCHU-MM TO UF020-JUCHU-MM
               MOVE UF010-JUCHU-YY TO JUCHU-DATE-MEMORY-YY
               MOVE UF010-JUCHU-MM TO JUCHU-DATE-MEMORY-MM
           END-IF.           

           IF UF010-DATA-KBN = '1'
               ADD UF010-KINGAKU TO UF020-KINGAKU
           ELSE
               SUBTRACT UF010-KINGAKU FROM UF020-KINGAKU
           END-IF.

           PERFORM READ-RTN.

       EXT.
           EXIT.
      ******************************************************************
      *出力処理
      ******************************************************************
       WRITE-RTN SECTION.
           WRITE OTF-REC.
           ADD 1 TO OTF-CNT.
       EXT.
           EXIT.
      ******************************************************************
      *終了処理
      ******************************************************************
       TERM-RTN SECTION.
           CLOSE ITF-FILE.
           CLOSE OTF-FILE.
           MOVE 0 TO RETURN-CODE.
           DISPLAY "*** KUBM020 ITF-REC:"ITF-CNT" ***".
           DISPLAY "*** KUBM020 OTF-REC:"OTF-CNT" ***".
           DISPLAY "*** KUBM020 END ***".
       EXT.
           EXIT.



           
