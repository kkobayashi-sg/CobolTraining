       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-KCBS010.
      ******************************************************************
      * システム名    ：テストプログラム
      * サブシステム名：
      * プログラム名  ：サブプログラムのスタブ
      * 作成日／作成者：2026年6月18日　小林健太郎
      * 変更日／変更者：
      *       変更内容：
      ******************************************************************
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY KCBS010P.

       PROCEDURE DIVISION.
           DISPLAY "*** SYSTEM-DATE ***".

           MOVE "011113" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "990404" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "19820112" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20000229" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "21000229" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "020229" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20030332" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20040931" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20050230" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20060100" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20070001" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "20081301" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "2A110112" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "190B0609" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "19991C13" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "2026042D" TO S010-DATE.
           PERFORM CALL-CALCKCBS010-RTN.

           STOP RUN.

       CALL-CALCKCBS010-RTN SECTION.
           CALL "KCBS010" USING KCBS010-P1.
           DISPLAY S010-DATE8 " -> S010-RCD: " S010-RCD.
           DISPLAY " ".
           EXIT. 




       