



       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX13Q1.

       DATA DIVISION.
       FILE SECTION.
       FD ITF-FILE.
       01 ITF-REC.
           03 EMP-NO                   PIC 9(4).
           03 EMP-NAME                 PIC N(20).
           03 EMP-JOINED-DATE          
               05 EMP-JOINED-Y         PIC 9(4).
               05 EMP-JOINED-M         PIC 9(2).
               05 EMP-JOINED-D         PIC 9(2).
       FD OTF-FILE.
       01 OTF-REC.
           03 EMP-NO                   PIC 9(4).
           03 EMP-NAME                 PIC N(20).
           03 EMP-JOINED-DATE          
               05 EMP-JOINED-Y         PIC 9(4).
               05 EMP-JOINED-M         PIC 9(2).
               05 EMP-JOINED-D         PIC 9(2).
       
       WORKING-STORAGE SECTION.
       
       

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           
           SELECT ITF-FILE ASSIGN TO ITF
           ORGANIZATION SEQUENTIAL.

           SELECT OTF-FILE ASSIGN TO OTF
           ORGANIZATION SEQUENTIAL.

       PROCEDURE DIVISION.
       MAIN-PARA.
           

       