       IDENTIFICATION DIVISION.
       PROGRAM-ID. KJBM020.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：受注 (ID: KJ)
      * プログラム名　：受注データ形式チェック
      * 作成日／作成者：2026/06/05　小林健太郎
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
           COPY KJCF020.
           
           FD OTF-FILE.
           01 OTF-REC.
           COPY KJCF020.

       WORKING-STORAGE SECTION.
           01 ITF-END-FLG                  PIC X(1) VALUE 'N'.
           01 ITF-CNT                    PIC 9(5) VALUE ZERO.
           01 OTF-CNT                    PIC 9(5) VALUE ZERO.
           COPY KCBS010P.
      *
      ******************************************************************
      *受注チェックファイル作成
      ******************************************************************
       PROCEDURE DIVISION.
           PERFORM INIT-RTN.
           PERFORM MAIN-RTN UNTIL ITF-END-FLG = "1".
           PERFORM TERM-RTN.
           STOP RUN.
      ******************************************************************
      *開始処理
      ******************************************************************
       INIT-RTN SECTION.
           DISPLAY "*** KJBM020 START ***".

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
                   MOVE '1' TO ITF-END-FLG
               NOT AT END
                   ADD 1 TO ITF-CNT
           END-READ.
       EXT.
           EXIT.
      ******************************************************************
      *編集処理
      ******************************************************************
       MAIN-RTN SECTION.

       MOVE ITF-REC TO OTF-REC.
      *データ区分
           MOVE JF020-DATA-KBN OF ITF-REC
               TO JF020-DATA-KBN OF OTF-REC.
      *受注番号(-X)(集団項目)
           MOVE JF020-JUCHU-NO-X OF ITF-REC
               TO JF020-JUCHU-NO-X OF OTF-REC.
      *受注日付(集団項目)
           MOVE JF020-JUCHU-DATE OF ITF-REC 
               TO S010-DATE OF KCBS010-P1.
      *商品番号
           MOVE JF020-SHOHIN-NO OF ITF-REC 
               TO JF020-SHOHIN-NO OF OTF-REC.
      *数量（集団項目）
           MOVE JF020-SURYO-X OF ITF-REC TO JF020-SURYO-X OF OTF-REC.
      *データ区分の判定
           IF NOT(JF020-DATA-KBN  OF OTF-REC = '1' 
               OR JF020-DATA-KBN OF OTF-REC = '9')
               MOVE "1" TO JF020-ERR-KBN OF OTF-REC (1)
           END-IF.
      *受注番号の判定
           IF (JF020-JUCHU-NO OF OTF-REC IS NOT NUMERIC)
               OR(JF020-JUCHU-NO OF OTF-REC = 0)
               MOVE "1" TO JF020-ERR-KBN OF OTF-REC (2)
           END-IF.
      *日付の判定
           CALL "KCBS010" USING KCBS010-P1
           END-CALL.
           IF S010-RCD OF KCBS010-P1 = 'E'
               MOVE '1' TO JF020-ERR-KBN OF OTF-REC (3)
           ELSE
               MOVE S010-DATE8 OF KCBS010-P1 
               TO JF020-JUCHU-DATE OF OTF-REC 
           END-IF.
      *エラー区分(4)は未使用なのでスペースを入れる
           MOVE SPACE TO JF020-ERR-KBN OF OTF-REC (4).
      *商品番号の判定
           IF (JF020-SHOHIN-NO OF OTF-REC IS NOT NUMERIC)
               OR(JF020-SHOHIN-NO OF OTF-REC = 0)
               MOVE "1" TO JF020-ERR-KBN OF OTF-REC (5)
           END-IF.
      *数量の判定
           IF (JF020-SURYO OF OTF-REC IS NOT NUMERIC)OR
               ( (JF020-SURYO OF OTF-REC < 1 ) 
                   OR (JF020-SURYO OF OTF-REC > 999) )
               MOVE "1" TO JF020-ERR-KBN OF OTF-REC (6)
           END-IF.

           PERFORM WRITE-RTN.
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
           DISPLAY "*** KJBM020 ITF-REC:"ITF-CNT" ***".
           DISPLAY "*** KJBM020 OTF-REC:"OTF-CNT" ***".
           DISPLAY "*** KJBM020 END ***".
       EXT.
           EXIT.



           
