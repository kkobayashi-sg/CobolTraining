      **********************************************
      *
      *
      **********************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MOVE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01 WK-DATA.
           03 WK-EMP-NO            PIC 9(6).
           03 WK-EMP-NAME          PIC X(20).
           03 WK-DEPT              PIC X(10).

       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 123 TO WK-EMP-NO.
           MOVE 'SUZUKI' TO WK-EMP-NAME.
           MOVE 'SALES' TO WK-DEPT.


           DISPLAY 'WK-EMP-NO->' WK-EMP-NO "FIN".
      *000123
           DISPLAY "WK-EMP-NAME->" WK-EMP-NAME "FIN".
      *SUZUKI‚Æ‹ó”’14Œ…
           DISPLAY "WK-DEPT->" WK-DEPT "FIN".
      *SALES‚Æ‹ó”’5Œ…