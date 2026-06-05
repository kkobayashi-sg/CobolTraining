       IDENTIFICATION DIVISION.
       PROGRAM-ID. KJBM010.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：受注 (ID: KJ)
      * プログラム名　：受注チェックファイル作成
      * 作成日／作成者：2026/06/04　小林健太郎
      * 変更日／変更者：2026/06/05  小林健太郎
      * 　　　変更内容：
      ******************************************************************

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
           01 ITF-END-FLG                  PIC X(1) VALUE 'N'.
           01 ITF-CNT                    PIC 9(5) VALUE ZERO.
           01 OTF-CNT                    PIC 9(5) VALUE ZERO.
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
           DISPLAY "*** KJBM010 START ***".

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
      *レコード全体をスペースクリア 
           MOVE SPACE TO OTF-REC.
      *データ区分
           MOVE JF010-DATA-KBN
               TO JF020-DATA-KBN.
      *受注番号(-X)(集団項目)
           MOVE JF010-JUCHU-NO-X
               TO JF020-JUCHU-NO-X.
      *受注日付(集団項目)
           MOVE 00 TO JF020-JUCHU-Y1.
           MOVE JF010-JUCHU-DATE TO JF020-JUCHU-DATE6.
      *商品番号
           MOVE JF010-SHOHIN-NO TO JF020-SHOHIN-NO.
      *数量（集団項目）
           MOVE JF010-SURYO-X TO JF020-SURYO-X.
      *エラー区分テーブル（集団項目）
            MOVE SPACE TO JF020-ERR-KBN-TBL.
      *商品名
           MOVE SPACE TO JF020-SHOHIN-MEI.
      *単価
           MOVE ZERO TO JF020-TANKA.
      *金額
           MOVE ZERO TO JF020-KINGAKU.
      *
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
           DISPLAY "*** KJBM010 ITF-REC:"ITF-CNT" ***".
           DISPLAY "*** KJBM010 OTF-REC:"OTF-CNT" ***".
           DISPLAY "*** KJBM010 END ***".
       EXT.
           EXIT.



           
