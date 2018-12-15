100 REM **********************************************************************
110 REM FILENAME                          MAKEFONT.BAS
120 REM LAST UPDATE                       4/6/92
130 REM DESCRIPTION                       CREATES 56 x 56 FONT DATA
140 REM                                   IN X,Y COORDINATES FOR SCREEN 9
150 REM *********************************************************************
160 REM
170 SCREEN 9:KEY OFF:CLS
180 FOR N=1 TO 10:KEY N,"":NEXT
190 XSIZE=64:YSIZE=56:XDIM=6:YDIM=6:PIXELCOLOR=7:GRIDCOLOR=8
200 XOFFSET=496:YOFFSET=266
210 DIM PIX%(XSIZE,YSIZE)
220 DIM CURSOR%(7):LINE (0,0)-(2,2),7,BF:GET(0,0)-(2,2),CURSOR%
230 DIM V(8):REM
250 CLS
260 INPUT "ENTER CHARACTER TO EDIT  ";FILE$
270 IF FILE$="" THEN END
300 CLS
310 INPUT "INPUT FROM (F)ILE OR (D)ATA";I$
320 IF I$="F" THEN 500
330 IF I$="D" THEN 1500
340 IF I$="" THEN END
350 GOTO 250
490 REM -----
500 GOSUB 2000:REM READ FILE INTO PIXEL ARRAY
890 REM ----- EDITING
900 GOSUB 3000:REM DRAW GRID
910 GOSUB 4000:REM PRINT TEXT
920 IF FILELENGTH<10 THEN 1000
930 GOSUB 3500:REM PAINT PIXELS IN GRID
940 REM
1000 LOCATE 16,62:PRINT"Normal Mode";
1010 X=1:Y=1:GOTO 1030
1020 REM:BEEP:REM ILLEGAL CURSOR MOVEMENT
1030 GOSUB 1380:REM DRAW NEW CURSOR AT THIS POINT
1040 IN$=INKEY$:IF IN$="" THEN 1040
1050 REM XOR OLD CURSOR, INSERT, DELETE, OR NO PAINT, DO MOVEMENT CALCULATION
1060 IF IN$=CHR$(0)+CHR$(72) THEN GOSUB 1380:GOSUB 1250:GOTO 1160:REM UP
1070 IF IN$=CHR$(0)+CHR$(80) THEN GOSUB 1380:GOSUB 1250:GOTO 1180:REM DOWN
1080 IF IN$=CHR$(0)+CHR$(75) THEN GOSUB 1380:GOSUB 1250:GOTO 1200:REM LEFT
1090 IF IN$=CHR$(0)+CHR$(77) THEN GOSUB 1380:GOSUB 1250:GOTO 1220:REM RIGHT
1100 IF IN$=CHR$(0)+CHR$(82) THEN GOSUB 1420:REM INS
1110 IF IN$=CHR$(0)+CHR$(83) THEN GOSUB 1440:REM DEL
1120 IF IN$=CHR$(0)+CHR$(71) THEN GOSUB 3800:REM HOME
1130 IF IN$=CHR$(0)+CHR$(79) THEN GOSUB 2500:REM END
1135 IF IN$=CHR$(27) THEN END
1140 GOTO 1040
1150 REM -----------------------------
1160 Y=Y-1:IF Y<1 THEN Y=1:GOTO 1020 ELSE GOTO 1020
1170 REM
1180 Y=Y+1:IF Y>YSIZE THEN Y=YSIZE:GOTO 1020 ELSE GOTO 1030
1190 REM
1200 X=X-1:IF X<1 THEN X=1:GOTO 1020 ELSE GOTO 1030
1210 REM
1220 X=X+1:IF X>XSIZE THEN X=XSIZE:GOTO 1020 ELSE GOTO 1030
1230 REM --------------------------------------
1240 REM
1250 ON CMODE+1 GOSUB 1260,1280,1330
1260 RETURN
1270 REM -----
1280 PIX%(X,Y)=PIXELCOLOR:REM INSERT PIXEL
1290 XX=(X*XDIM)-2:YY=(Y*YDIM)-2
1300 PAINT(XX,YY),PIXELCOLOR,GRIDCOLOR
1305 PSET (XOFFSET+X-1,YOFFSET+Y-1),PIXELCOLOR
1310 RETURN
1320 REM -----
1330 PIX%(X,Y)=0:REM DELETE PIXEL
1340 XX=(X*XDIM)-2:YY=(Y*YDIM)-2
1350 PAINT(XX,YY),0,GRIDCOLOR
1355 PSET (XOFFSET+X-1,YOFFSET+Y-1),0
1360 RETURN
1370 REM -----
1380 XX=(X*XDIM)+1-XDIM:YY=(Y*YDIM)+1-YDIM
1390 PUT(XX+1,YY+1),CURSOR%,XOR:REM ERASE PREVIOUS CURSOR
1400 RETURN
1410 REM -----
1420 IF CMODE=1 THEN CMODE=0:LOCATE 16,62:PRINT"Normal Mode";:RETURN
1430 CMODE=1:LOCATE 16,62:PRINT"Insert Mode";:RETURN
1440 IF CMODE=2 THEN CMODE=0:LOCATE 16,62:PRINT"Normal Mode";:RETURN
1450 CMODE=2:LOCATE 16,62:PRINT"Delete Mode";:RETURN
1490 REM -----
1500 CLS
1505 FOR VLOOP=1 TO 8
1510   PRINT "ENTER VALUE";:PRINT VLOOP;:INPUT V(VLOOP)
1515 NEXT VLOOP
1520 ROWOFFSET=0
1525 FOR VLOOP=1 TO 8
1530   MASK=&H80
1540   FOR MASKLOOP=0 TO 7
1550     IF (V(VLOOP) AND MASK)<>MASK THEN 1580
1555     FOR ROW=0 TO 6
1560       FOR COL=0 TO 7
1565         REM:PRINT 1+COL+(8*MASKLOOP),1+(ROW+ROWOFFSET)
1566         PIX%(1+COL+(8*MASKLOOP),1+(ROW+ROWOFFSET))=PIXELCOLOR
1570       NEXT COL
1575     NEXT ROW
1580     MASK=MASK/2
1590   NEXT MASKLOOP
1600   ROWOFFSET=ROWOFFSET+7
1610 NEXT VLOOP
1700 GOTO 900:REM EDITING
1980 REM
1990 REM ----- READ FILE INTO PIXEL ARRAY
2000 ON ERROR GOTO 2100
2010 F$=FILE$+".CHR":OPEN F$ FOR INPUT AS #1
2015 ON ERROR GOTO 0
2017 FILELENGTH=LOF(1)
2018 PRINT:PRINT "READING FILE, PLEASE WAIT...";
2020 IF EOF(1) THEN 2075
2030 INPUT #1,LOOPX,LOOPY
2050 PIX%(LOOPX+1,LOOPY+1)=PIXELCOLOR
2060 IN$=INKEY$:IF IN$=CHR$(27) THEN 2075
2070 GOTO 2020
2075 CLOSE #1
2090 RETURN
2095 REM
2100 RESUME 2110
2110 ON ERROR GOTO 0
2120 RETURN
2490 REM ----- SAVE PIXEL ARRAY TO FILE
2500 LOCATE 18,62:PRINT "Saving Array ...";
2510 F$=FILE$+".CHR"
2520 OPEN F$ FOR OUTPUT AS #1
2530 FOR LOOPY=1 TO YSIZE
2540    FOR LOOPX=1 TO XSIZE
2550    IF PIX%(LOOPX,LOOPY)<>PIXELCOLOR THEN 2590
2560      X$=RIGHT$(STR$(LOOPX-1),LEN(STR$(LOOPX-1))-1)
2570      Y$=RIGHT$(STR$(LOOPY-1),LEN(STR$(LOOPY-1))-1)
2580    PRINT #1,X$;",";Y$
2590   NEXT LOOPX
2600   IN$=INKEY$:IF IN$=CHR$(27) THEN 2560
2610 NEXT LOOPY
2620 CLOSE #1
2630 LOCATE 18,62:PRINT "                ";
2640 RETURN
2990 REM ----- DRAW GRID
3000 CLS
3010 FOR YY=0 TO (YSIZE*YDIM) STEP YDIM
3020   LINE(0,YY)-((XSIZE*XDIM),YY),GRIDCOLOR
3030 NEXT YY
3040 FOR XX=0 TO (XSIZE*XDIM) STEP XDIM
3050   LINE (XX,0)-(XX,(YSIZE*YDIM)),GRIDCOLOR
3060 NEXT XX
3070 LINE (390,84)-(400,84),7
3080 LINE (390,168)-(400,168),7
3090 LINE (390,252)-(400,252),7
3100 LINE (96,339)-(96,349),7
3110 LINE (288,339)-(288,349),7
3120 LINE (192,339)-(192,349),7
3130 REM VIEWING BOX
3140 LINE (XOFFSET-5,YOFFSET-5)-(XOFFSET+5+XSIZE,YOFFSET+5+YSIZE),GRIDCOLOR,B
3150 RETURN
3490 REM ----- PAINT PIXELS IN GRID AND VIEWING BOW
3500 LOCATE 18,62:PRINT "Filling Grid ...";
3515 YY=INT(YDIM/2)
3520 FOR R=1 TO YSIZE
3525   XX=INT(XDIM/2)
3530   FOR C=1 TO XSIZE
3540     PAINT(XX,YY),PIX%(C,R),GRIDCOLOR
3545     PSET (XOFFSET+C-1,YOFFSET+R-1),PIX%(C,R)
3550     XX=XX+XDIM
3560   NEXT C
3570   YY=YY+YDIM
3580 NEXT R
3585 LOCATE 18,62:PRINT "                ";
3590 RETURN
3790 REM ----- DRAW CHARACTER AT PIXEL SIZE
3800 LINE (XOFFSET-5,YOFFSET-5)-(XOFFSET+5+XSIZE,YOFFSET+5+YSIZE),GRIDCOLOR,B
3805 LOCATE 18,62:PRINT "Drawing Char....";
3810 YY=YOFFSET
3820 FOR R=1 TO YSIZE
3830   XX=XOFFSET
3840   FOR C=1 TO XSIZE
3850     PSET (XX,YY),PIX%(C,R)
3860     XX=XX+1
3870   NEXT C
3880   YY=YY+1
3890 NEXT R
3895 LOCATE 18,62:PRINT "                ";
3900 RETURN
3990 REM ----- PRINT CURSOR COMMANDS
4000 LOCATE 2,62:PRINT "Commands-";
4010 LOCATE 4,62:PRINT CHR$(24);"  - Cursor Up";
4020 LOCATE 5,62:PRINT CHR$(25);"  - Cursor Down";
4030 LOCATE 6,62:PRINT CHR$(27);"  - Cursor Left";
4040 LOCATE 7,62:PRINT CHR$(26);"  - Cursor Right";
4050 LOCATE 9,62:PRINT "INS  - Pixels ON";
4060 LOCATE 10,62:PRINT "DEL  - Pixels OFF";
4070 LOCATE 11,62:PRINT "HOME - Draw Char.";
4080 LOCATE 12,62:PRINT "END  - Done Editing";
4090 LOCATE 14,62:PRINT "ESC  - Exit";
4100 RETURN
