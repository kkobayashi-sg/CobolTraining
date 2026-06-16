       IDENTIFICATION DIVISION.
       PROGRAM-ID. KJBM011.
      ******************************************************************
      * システム名　　：研修
      * サブシステム名：受注 (ID: KJ)
      * プログラム名　：受注チェックファイル作成(DB入力版)
      * 作成日／作成者：2026/06/12　小林健太郎
      * 変更日／変更者：
      * 　　　変更内容：
      ******************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OTF-FILE ASSIGN TO OTF
                 ORGANIZATION SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
       FD OTF-FILE.
       01 OTF-REC.
       COPY KJCF020.

       WORKING-STORAGE SECTION.
       01 OTF-CNT      PIC 9(9) PACKED-DECIMAL VALUE 0.
       01 FETCH-CNT     PIC 9(9) PACKED-DECIMAL VALUE 0.
       01 FETCH-END    PIC X VALUE 'N'.
      ******************************************************************
      *データベースアクセス関連
      *※ＣＯＢＯＬ⇔ＤＢする変数はDECLARE SECTIONで行う
      ******************************************************************

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

       01 DSN          PIC X(256).
       
       01 WK-KCCMJUCHU.
           EXEC SQL INCLUDE KCCMJUCHU END-EXEC.

       EXEC SQL DECLARE 
           JUCHU-CURSOR CURSOR FOR
             SELECT *
             FROM KCCMJUCHU
       END-EXEC.

       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

      *
      ******************************************************************
      *メインルーチン
      ******************************************************************
       PROCEDURE DIVISION.
           PERFORM INIT-RTN. 
           PERFORM WRITE-TO-FILE-RTN UNTIL FETCH-END = 'Y'.
           PERFORM SUCCESSFUL-TERM-RTN.
           STOP RUN.
      ******************************************************************
      *初期化処理
      ******************************************************************
       INIT-RTN SECTION.
           DISPLAY "*** KJBM011 START ***".
  
           OPEN OUTPUT OTF-FILE.
             
           PERFORM DBCONNECT-RTN.
           PERFORM FETCH-RTN.
       EXT.
           EXIT.
      ******************************************************************
      *データベースへ接続する処理
      ******************************************************************
       DBCONNECT-RTN       SECTION.

           STRING
             "DRIVER={Postgresql Unicode};"
             "SERVER=db;"
             "DBQ=postgres;"
             "UID=postgres;"
             "PWD=postgres;"
             "CONNSETTINGS=SET CLIENT_ENCODING to 'SJIS';"
             INTO DSN
           END-STRING.
      ******************************************************************
           EXEC SQL CONNECT TO :DSN END-EXEC.
           IF SQLCODE NOT = ZERO
             PERFORM ERROR-RTN
           END-IF.

           EXEC SQL OPEN JUCHU-CURSOR END-EXEC.
       EXT.
           EXIT.

      ******************************************************************
      *目的のカーソル（テーブル）から1レコード読み取る
      ******************************************************************
       FETCH-RTN       SECTION.
           EXEC SQL
             FETCH JUCHU-CURSOR
             INTO :CMJUCHU-DATA-KBN,
                  :CMJUCHU-JUCHU-NO,
                  :CMJUCHU-JUCHU-DATE,
                  :CMJUCHU-SHOHIN-NO,
                  :CMJUCHU-SURYO
           END-EXEC.

           EVALUATE SQLCODE
            WHEN 0
              ADD 1 TO FETCH-CNT
            WHEN 100
              MOVE "Y" TO FETCH-END
            WHEN OTHER
              PERFORM ERROR-RTN
           END-EVALUATE.
       EXT.
           EXIT.

      ******************************************************************
      *処理結果をファイルに出力
      ******************************************************************
       WRITE-TO-FILE-RTN       SECTION.
           MOVE SPACE TO OTF-REC.
           MOVE CMJUCHU-DATA-KBN TO JF020-DATA-KBN.
           MOVE CMJUCHU-JUCHU-NO TO JF020-JUCHU-NO.
           MOVE 00 TO JF020-JUCHU-Y1.
           MOVE CMJUCHU-JUCHU-DATE TO JF020-JUCHU-DATE6.
           MOVE CMJUCHU-SHOHIN-NO TO JF020-SHOHIN-NO.
           MOVE CMJUCHU-SURYO TO JF020-SURYO.
           MOVE SPACE TO JF020-ERR-KBN-TBL.
           MOVE SPACE TO JF020-SHOHIN-MEI.
           MOVE ZERO TO JF020-TANKA.
           MOVE ZERO TO JF020-KINGAKU.
  
           WRITE OTF-REC.
           ADD 1 TO OTF-CNT.
  
           PERFORM FETCH-RTN.
       EXT.
           EXIT.

      ******************************************************************
      *問題なく処理が完了したときの終了処理
      ******************************************************************
       SUCCESSFUL-TERM-RTN      SECTION.
           PERFORM TERM-RTN.
       EXT.
           EXIT.

      ******************************************************************
      *処理中にエラーが発生したときの終了処理
      ******************************************************************
       ERROR-RTN      SECTION.
           DISPLAY "!!! FETCHDB ABEND : DATABASE ACCESS ERROR !!!"
           DISPLAY "SQLCODE = " SQLCODE.
           DISPLAY "SQLERRMC = " SQLERRMC.
           MOVE 9 TO RETURN-CODE.
           PERFORM TERM-RTN.
       EXT.
           EXIT.

      ******************************************************************
      *共通の終了処理
      ******************************************************************
       TERM-RTN SECTION.
           EXEC SQL CLOSE JUCHU-CURSOR END-EXEC.
           EXEC SQL DISCONNECT ALL     END-EXEC.
           CLOSE OTF-FILE.
           MOVE 0 TO RETURN-CODE.
           DISPLAY "*** KJBM011 FETCH:"FETCH-CNT" ***".
           DISPLAY "*** KJBM011 OTF-REC:"OTF-CNT" ***".
           DISPLAY "*** KJBM011 END ***".
       EXT.
           STOP RUN.



           
