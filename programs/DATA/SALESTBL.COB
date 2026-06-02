      ********************************************************************
      *
      *
      ********************************************************************
       IDENTIFICATION  DIVISION.
       PROGRAM-ID. SALESTBL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    
       01 EMPLOYEE-DATA.
           03 EMP-ID               PIC 9(08).
           03 EMP-NAME             PIC X(20).
           03 EMP-DEPT             PIC 999.
           03 EMP-SARALY           PIC S9(10)V9(2).
           
       01 WK-LINE                  PIC X(50) VALUE ALL '-'.
       01 WK-COUNT                 PIC 9(05) VALUE ZERO.
       01 WK-HEADER                PIC X(30) VALUE SPACE.
       01 WK-END-MARK              PIC X(10) VALUE HIGH-VALUE.

       01 WK-DATE                  PIC 9(08).
       01 WK-DATE-R REDEFINES WK-DATE.
           03 WK-DATE-YYYY              PIC 9(04).
           03 WK-DATE-MM                PIC 9(02).
           03 WK-DATE-DD                PIC 9(02).

       PROCEDURE DIVISION.
       MAIN-PARA.
           