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

           MOVE "011113" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "990404" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "820112" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "010631" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "011131" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "000229" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "020229" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "030332" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "040931" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "050230" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "060100" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "070001" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "081301" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "0B0609" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "991C13" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           MOVE "26042D" TO S010-DATE6.
           PERFORM CALL-CALCKCBS010-RTN.

           STOP RUN.

       CALL-CALCKCBS010-RTN SECTION.
           CALL "KCBS010" USING KCBS010-P1.
           DISPLAY S010-DATE8 " -> S010-RCD: " S010-RCD.
           DISPLAY " ".
           EXIT. 




       