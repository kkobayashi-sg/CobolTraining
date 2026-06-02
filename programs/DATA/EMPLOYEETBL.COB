      ********************************************************************
      *
      *
      ********************************************************************
       IDENTIFICATION  DIVISION.
       PROGRAM-ID. EMPLOYEETBL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 EMPLOYEE-TABLE.
           03 EMP-ENTRY OCCURS 5 TIMES.
                  05 EMP-ID               PIC 9(06).
                  05 EMP-NAME             PIC X(20).
      
       PROCEDURE DIVISION.
       MAIN-PARA.
      
           