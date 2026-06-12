       IDENTIFICATION DIVISION.
       PROGRAM-ID. KJBM030.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：受注 (ID: KJ)
      * プログラム名　：受注データ商品番号チェック
      * 作成日／作成者：2026/06/10　小林健太郎
      * 変更日／変更者：
      * 　　　変更内容：
      ******************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ITF-FILE ASSIGN TO ITF
             ORGANIZATION SEQUENTIAL.
           SELECT IMF-FILE ASSIGN TO IMF
             ORGANIZATION SEQUENTIAL.
           SELECT OTF-FILE ASSIGN TO OTF
             ORGANIZATION SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
           FD ITF-FILE.
           01 ITF-REC.
           COPY KJCF020.

           FD IMF-FILE.
           01 IMF-REC.
           COPY KCCFSHO.
           
           FD OTF-FILE.
           01 OTF-REC.
           COPY KJCF020.

       WORKING-STORAGE SECTION.
           01 ITF-END-FLG                  PIC X(1) VALUE 'N'.
           01 ITF-CNT                    PIC 9(5) VALUE ZERO.
           01 IMF-CNT                    PIC 9(5) VALUE ZERO.
           01 OTF-CNT                    PIC 9(5) VALUE ZERO.
      *
      ******************************************************************
      *受注チェックファイル作成
      ******************************************************************
       PROCEDURE DIVISION.
           PERFORM INIT-RTN.
           PERFORM MAIN-RTN UNTIL ITF-END-FLG = "Y".
           PERFORM TERM-RTN.
           STOP RUN.
      ******************************************************************
      *開始処理
      ******************************************************************
       INIT-RTN SECTION.
           DISPLAY "*** KJBM030 START ***".
           OPEN INPUT ITF-FILE.
           OPEN INPUT IMF-FILE.
           OPEN OUTPUT OTF-FILE.
           PERFORM READ_ITF-RTN.
           PERFORM READ_IMF-RTN.
       EXT.
           EXIT.
      ******************************************************************
      *入力処理
      ******************************************************************
       READ_ITF-RTN SECTION.
           READ ITF-FILE
             AT END
               MOVE 'Y' TO ITF-END-FLG
             NOT AT END
               ADD 1 TO ITF-CNT
           END-READ.
       EXT.
           EXIT.

       READ_IMF-RTN SECTION.
           READ IMF-FILE
             AT END
               MOVE HIGH-VALUE TO CFSHO-SHOHIN-NO
             NOT AT END
               ADD 1 TO IMF-CNT
           END-READ.
       EXT.
           EXIT.
      ******************************************************************
      *編集処理
      ******************************************************************
       MAIN-RTN SECTION.
           MOVE ITF-REC TO OTF-REC.
           IF JF020-ERR-KBN OF ITF-REC (5) NOT = SPACE
             PERFORM WRITE-RTN
             PERFORM READ_ITF-RTN
           ELSE
             EVALUATE TRUE
               WHEN JF020-SHOHIN-NO OF ITF-REC = CFSHO-SHOHIN-NO
                 MOVE CFSHO-SHOHIN-MEI TO JF020-SHOHIN-MEI OF OTF-REC
                 MOVE CFSHO-TANKA TO JF020-TANKA OF OTF-REC
                 IF JF020-ERR-KBN OF ITF-REC (6) = SPACE
                   COMPUTE JF020-KINGAKU OF OTF-REC 
                     = JF020-SURYO OF ITF-REC * CFSHO-TANKA
                 ELSE
                   MOVE 0 TO JF020-KINGAKU OF OTF-REC
                 END-IF
                   PERFORM WRITE-RTN
                   PERFORM READ_ITF-RTN
                 WHEN JF020-SHOHIN-NO OF ITF-REC < CFSHO-SHOHIN-NO
                   MOVE '2' TO JF020-ERR-KBN OF OTF-REC (5)
                   PERFORM WRITE-RTN
                   PERFORM READ_ITF-RTN
                 WHEN JF020-SHOHIN-NO OF ITF-REC > CFSHO-SHOHIN-NO
                   PERFORM READ_IMF-RTN
             END-EVALUATE
           END-IF.
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
           CLOSE IMF-FILE.
           CLOSE OTF-FILE.
           MOVE 0 TO RETURN-CODE.
           DISPLAY "*** KJBM030 ITF-REC:"ITF-CNT" ***".
           DISPLAY "*** KJBM030 IMF-REC:"IMF-CNT" ***".
           DISPLAY "*** KJBM030 OTF-REC:"OTF-CNT" ***".
           DISPLAY "*** KJBM030 END ***".
       EXT.
           EXIT.



           
