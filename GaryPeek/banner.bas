100 REM **********************************************************************
110 REM FILE NAME  - BANNER.BAS
120 REM
130 REM WRITTEN BY - GARY PEEK
140 REM              3201 HIGHGATE
150 REM              ST. CHARLES, MO.  63301
160 REM              314 946-5272
170 REM
180 REM LAST UPDATE - 3/25/87
190 REM
200 REM DESCRIPTION - CREATE BANNERS SIDEWAYS ON PRINTER
210 REM               ASKTERISKS WILL WORK ON ANY PRINTER
220 REM               GRAPHICS BOXES WILL WORK ON OKIDATA PRINTERS
230 REM
240 REM PLEASE NOTE - PERMISSION IS GRANTED TO COPY THIS PROGRAM ONLY IF
250 REM               COPIED IN ITS ENTIRETY INCLUDING THIS HEADING.
260 REM
270 REM **********************************************************************
280 REM
290 CLS:PRINT "INITIALIZING - PLEASE WAIT ..."
300 DIM FONT(96,8):FOR A= 1 TO 96:FOR B=1 TO 8:READ F:FONT(A,B)=F:NEXT B:NEXT A
310 KEY OFF:FOR A=1 TO 10:KEY A,"":NEXT:WIDTH "LPT1:",255
320 BLK$="":SP$="":FOR A=1 TO 72:BLK$=BLK$+CHR$(255):SP$=SP$+CHR$(0):NEXT
330 CLS:PRINT "BANNER PROGRAM  (GRAPHICS FOR OKIDATA uLINE 182)":PRINT
340 PRINT "1. DISPLAY TO SCREEN"
350 PRINT "2. PRINT IN ASTERISKS"
360 PRINT "3. PRINT IN GRAPHICS BOXES":PRINT
370 PRINT "SELECT METHOD TO DISPLAY ---> ";
380 LINE INPUT DISPLAY$
390 IF DISPLAY$<>"1" AND DISPLAY$<>"2" AND DISPLAY$<>"3" THEN 330
400 REM ----------------------------------------
410 IF DISPLAY$="2" THEN LPRINT CHR$(27)+"3"+CHR$(36);:REM X/216" LF
420 IF DISPLAY$="3" THEN LPRINT CHR$(27)+"3"+CHR$(22);:REM X/216" LF
430 PRINT
440 PRINT "ENTER WHAT YOU WANT PRINTED AS A BANNER -":PRINT:PRINT "---> ";
450 LINE INPUT BANNER$
460 CLS:PRINT "PRINTING BANNER - PLEASE WAIT ..."
470 FOR CHARPOS=1 TO LEN(BANNER$)
480    CHAR$=MID$(BANNER$,CHARPOS,1):C=ASC(CHAR$):CHARNUM=C-31
490       MASK=128
500       GOSUB 550:GOSUB 550:GOSUB 550:GOSUB 550          REM ... WIDTH
510       MASK=MASK/2:IF MASK<>.5 THEN 500
520 NEXT CHARPOS
530 GOTO 330
540 REM ----------------------------------------
550       FOR OFFSET=7 TO 0 STEP -1
560          F=FONT(CHARNUM,OFFSET+1)
570          IF (F AND MASK)=MASK THEN GOSUB 610 ELSE GOSUB 660
580       NEXT OFFSET:GOSUB 710:REM      ... NEXT LINE
590 RETURN
600 REM ----------------------------------------
610 D=VAL(DISPLAY$):ON D GOTO 620,630,640
620 PRINT "*********";:RETURN
630 LPRINT "*********";:RETURN
640 LPRINT CHR$(27)+"L"+CHR$(72)+CHR$(0)+BLK$;:RETURN
650 REM ----------------------------------------
660 D=VAL(DISPLAY$):ON D GOTO 670,680,690
670 PRINT "         ";:RETURN
680 LPRINT "         ";:RETURN
690 LPRINT CHR$(27)+"L"+CHR$(72)+CHR$(0)+SP$;:RETURN
700 REM ----------------------------------------
710 D=VAL(DISPLAY$):ON D GOTO 720,730,740
720 PRINT:RETURN
730 LPRINT:RETURN
740 LPRINT:RETURN
750 REM ----------------------------------------
760 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H0
770 DATA &H30,&H78,&H78,&H30,&H30,&H00,&H30,&H0
780 DATA &H6C,&H6C,&H6C,&H00,&H00,&H00,&H00,&H0
790 DATA &H6C,&H6C,&HFE,&H6C,&HFE,&H6C,&H6C,&H0
800 DATA &H30,&H7C,&HC0,&H78,&H0C,&HF8,&H30,&H0
810 DATA &H00,&HC6,&HCC,&H18,&H30,&H66,&HC6,&H0
820 DATA &H38,&H6C,&H38,&H76,&HDC,&HCC,&H76,&H0
830 DATA &H60,&H60,&HC0,&H00,&H00,&H00,&H00,&H0
840 DATA &H18,&H30,&H60,&H60,&H60,&H30,&H18,&H0
850 DATA &H60,&H30,&H18,&H18,&H18,&H30,&H60,&H0
860 DATA &H00,&H66,&H3C,&HFF,&H3C,&H66,&H00,&H0
870 DATA &H00,&H30,&H30,&HFC,&H30,&H30,&H00,&H0
880 DATA &H00,&H00,&H00,&H00,&H00,&H30,&H30,&H60
890 DATA &H00,&H00,&H00,&HFC,&H00,&H00,&H00,&H0
900 DATA &H00,&H00,&H00,&H00,&H00,&H30,&H30,&H0
910 DATA &H06,&H0C,&H18,&H30,&H60,&HC0,&H80,&H0
920 DATA &H7C,&HC6,&HCE,&HDE,&HF6,&HE6,&H7C,&H0
930 DATA &H30,&H70,&H30,&H30,&H30,&H30,&HFC,&H0
940 DATA &H78,&HCC,&H0C,&H38,&H60,&HCC,&HFC,&H0
950 DATA &H78,&HCC,&H0C,&H38,&H0C,&HCC,&H78,&H0
960 DATA &H1C,&H3C,&H6C,&HCC,&HFE,&H0C,&H1E,&H0
970 DATA &HFC,&HC0,&HF8,&H0C,&H0C,&HCC,&H78,&H0
980 DATA &H38,&H60,&HC0,&HF8,&HCC,&HCC,&H78,&H0
990 DATA &HFC,&HCC,&H0C,&H18,&H30,&H30,&H30,&H0
1000 DATA &H78,&HCC,&HCC,&H78,&HCC,&HCC,&H78,&H0
1010 DATA &H78,&HCC,&HCC,&H7C,&H0C,&H18,&H70,&H0
1020 DATA &H00,&H30,&H30,&H00,&H00,&H30,&H30,&H0
1030 DATA &H00,&H30,&H30,&H00,&H00,&H30,&H30,&H60
1040 DATA &H18,&H30,&H60,&HC0,&H60,&H30,&H18,&H0
1050 DATA &H00,&H00,&HFC,&H00,&H00,&HFC,&H00,&H0
1060 DATA &H60,&H30,&H18,&H0C,&H18,&H30,&H60,&H0
1070 DATA &H78,&HCC,&H0C,&H18,&H30,&H00,&H30,&H0
1080 DATA &H7C,&HC6,&HDE,&HDE,&HDE,&HC0,&H78,&H0
1090 DATA &H30,&H78,&HCC,&HCC,&HFC,&HCC,&HCC,&H0
1100 DATA &HFC,&H66,&H66,&H7C,&H66,&H66,&HFC,&H0
1110 DATA &H3C,&H66,&HC0,&HC0,&HC0,&H66,&H3C,&H0
1120 DATA &HF8,&H6C,&H66,&H66,&H66,&H6C,&HF8,&H0
1130 DATA &HFE,&H62,&H68,&H78,&H68,&H62,&HFE,&H0
1140 DATA &HFE,&H62,&H68,&H78,&H68,&H60,&HF0,&H0
1150 DATA &H3C,&H66,&HC0,&HC0,&HCE,&H66,&H3E,&H0
1160 DATA &HCC,&HCC,&HCC,&HFC,&HCC,&HCC,&HCC,&H0
1170 DATA &H78,&H30,&H30,&H30,&H30,&H30,&H78,&H0
1180 DATA &H1E,&H0C,&H0C,&H0C,&HCC,&HCC,&H78,&H0
1190 DATA &HE6,&H66,&H6C,&H78,&H6C,&H66,&HE6,&H0
1200 DATA &HF0,&H60,&H60,&H60,&H62,&H66,&HFE,&H0
1210 DATA &HC6,&HEE,&HFE,&HFE,&HD6,&HC6,&HC6,&H0
1220 DATA &HC6,&HE6,&HF6,&HDE,&HCE,&HC6,&HC6,&H0
1230 DATA &H38,&H6C,&HC6,&HC6,&HC6,&H6C,&H38,&H0
1240 DATA &HFC,&H66,&H66,&H7C,&H60,&H60,&HF0,&H0
1250 DATA &H78,&HCC,&HCC,&HCC,&HDC,&H78,&H1C,&H0
1260 DATA &HFC,&H66,&H66,&H7C,&H6C,&H66,&HE6,&H0
1270 DATA &H78,&HCC,&HE0,&H70,&H1C,&HCC,&H78,&H0
1280 DATA &HFC,&HB4,&H30,&H30,&H30,&H30,&H78,&H0
1290 DATA &HCC,&HCC,&HCC,&HCC,&HCC,&HCC,&HFC,&H0
1300 DATA &HCC,&HCC,&HCC,&HCC,&HCC,&H78,&H48,&H0
1310 DATA &HC6,&HC6,&HC6,&HD6,&HFE,&HEE,&HC6,&H0
1320 DATA &HC6,&HC6,&H6C,&H38,&H38,&H6C,&HC6,&H0
1330 DATA &HCC,&HCC,&HCC,&H78,&H30,&H30,&H78,&H0
1340 DATA &HFE,&HC6,&H8C,&H18,&H32,&H66,&HFE,&H0
1350 DATA &H78,&H60,&H60,&H60,&H60,&H60,&H78,&H0
1360 DATA &HC0,&H60,&H30,&H18,&H0C,&H06,&H02,&H0
1370 DATA &H78,&H18,&H18,&H18,&H18,&H18,&H78,&H0
1380 DATA &H10,&H38,&H6C,&HC6,&H00,&H00,&H00,&H0
1390 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&HFF
1400 DATA &H30,&H30,&H18,&H00,&H00,&H00,&H00,&H0
1410 DATA &H00,&H00,&H78,&H0C,&H7C,&HCC,&H76,&H0
1420 DATA &HE0,&H60,&H60,&H7C,&H66,&H66,&HDC,&H0
1430 DATA &H00,&H00,&H78,&HCC,&HC0,&HCC,&H78,&H0
1440 DATA &H1C,&H0C,&H0C,&H7C,&HCC,&HCC,&H76,&H0
1450 DATA &H00,&H00,&H78,&HCC,&HFC,&HC0,&H78,&H0
1460 DATA &H38,&H6C,&H60,&HF0,&H60,&H60,&HF0,&H0
1470 DATA &H00,&H00,&H76,&HCC,&HCC,&H7C,&HC,&HF8
1480 DATA &HE0,&H60,&H6C,&H76,&H66,&H66,&HE6,&H0
1490 DATA &H30,&H00,&H70,&H30,&H30,&H30,&H78,&H0
1500 DATA &H0C,&H00,&H0C,&H0C,&H0C,&HCC,&HCC,&H78
1510 DATA &HE0,&H60,&H66,&H6C,&H78,&H6C,&HE6,&H0
1520 DATA &H70,&H30,&H30,&H30,&H30,&H30,&H78,&H0
1530 DATA &H00,&H00,&HCC,&HFE,&HFE,&HD6,&HC6,&H0
1540 DATA &H00,&H00,&HF8,&HCC,&HCC,&HCC,&HCC,&H0
1550 DATA &H00,&H00,&H78,&HCC,&HCC,&HCC,&H78,&H0
1560 DATA &H00,&H00,&HDC,&H66,&H66,&H7C,&H60,&HF0
1570 DATA &H00,&H00,&H76,&HCC,&HCC,&H7C,&H0C,&H1E
1580 DATA &H00,&H00,&HDC,&H76,&H66,&H60,&HF0,&H0
1590 DATA &H00,&H00,&H7C,&HC0,&H78,&H0C,&HF8,&H0
1600 DATA &H10,&H30,&H7C,&H30,&H30,&H34,&H18,&H0
1610 DATA &H00,&H00,&HCC,&HCC,&HCC,&HCC,&H76,&H0
1620 DATA &H00,&H00,&HCC,&HCC,&HCC,&H78,&H30,&H0
1630 DATA &H00,&H00,&HC6,&HD6,&HFE,&HFE,&H6C,&H0
1640 DATA &H00,&H00,&HC6,&H6C,&H38,&H6C,&HC6,&H0
1650 DATA &H00,&H00,&HCC,&HCC,&HCC,&H7C,&H0C,&HF8
1660 DATA &H00,&H00,&HFC,&H98,&H30,&H64,&HFC,&H0
1670 DATA &H1C,&H30,&H30,&HE0,&H30,&H30,&H1C,&H0
1680 DATA &H18,&H18,&H18,&H00,&H18,&H18,&H18,&H0
1690 DATA &HE0,&H30,&H30,&H1C,&H30,&H30,&HE0,&H0
1700 DATA &H76,&HDC,&H00,&H00,&H00,&H00,&H00,&H0
1710 DATA &H00,&H10,&H38,&H6C,&HC6,&HC6,&HFE,&H0
