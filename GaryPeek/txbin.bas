10 CLS
20 PRINT "TRANSMIT (BINARY) FILE NAMED TEST.BIN TO COM1 AT 9600, N, 8, 1"
40 PRINT "HIT ESCAPE TO CANCEL"
50 PRINT
60 OPEN "COM1:9600,N,8,1,CS,DS,CD" AS #1
70 OPEN "TEST.BIN" FOR INPUT AS #2:FILELNG=LOF(2)
80 CLOSE #2:OPEN "R",#2,"TEST.BIN",1:FIELD #2,1 AS A$
90 RECNUM=1
100 B$=INKEY$:IF B$=CHR$(27) THEN CLOSE:END
110 GET #2,RECNUM
120 PRINT ASC(A$);
130 PRINT #1,A$;
140 RECNUM=RECNUM+1
150 IF RECNUM>FILELNG THEN CLOSE:END
160 GOTO 100
