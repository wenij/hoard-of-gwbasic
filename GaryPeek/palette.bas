10 SCREEN 9:COLOR 7,0:CLS
20 PRINT "1.   SHOW 4 SHADES OF A COLOR"
30 PRINT "2.   ROTATE THROUGH ALL 64 COLORS"
40 PRINT "ESC  EXIT"
50 IN$=INKEY$:IF IN$="" THEN 50
60 IF IN$="1" THEN GOSUB 300:GOTO 10
70 IF IN$="2" THEN GOSUB 500:GOTO 10
80 IF IN$=CHR$(27) THEN END
90 GOTO 50
290 REM -----
300 PRINT:INPUT "ENTER COLOR 0-15";C
310 CLS
320 P=C
330 FOR ROW=1 TO 4
340 COLOR C:PALETTE C,P
350 LOCATE ROW,1:PRINT P;
360 FOR DELAY=1 TO 90:NEXT DELAY
370 LOCATE ROW,1:PRINT "   ";
380 P=P+16
390 IF P>63 THEN P=P-64
400 NEXT ROW
410 IN$=INKEY$:IF IN$<>"" THEN RETURN
420 GOTO 330
490 REM -----
500 P=0
510 FOR PLOOP=1 TO 4
520   CLS
530   FOR C=0 TO 15
540     LINE(0,C*14)-(639,(C*14)+13),C,BF:PALETTE C,C+P
550     LOCATE C+1,1:PRINT "COLOR";C;"PALETTE";P+C;"  ";
560   NEXT C
570   IN$=INKEY$:IF IN$="" THEN 570
580   IF IN$=CHR$(27) THEN RETURN
590   P=P+16
600 NEXT PLOOP
610 GOTO 500

