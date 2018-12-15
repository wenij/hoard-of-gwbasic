100 KEY OFF:CLS:PRINT "(G)RAPHICS OR (T)EXT?"
110 INPUT GMODE$
120 IF GMODE$="G" THEN SCREEN 2
130 IF GMODE$="T" THEN SCREEN 0
140 CLS
150 GOSUB 540:REM LOAD ASSEMBLY LANGUAGE SUBROUTINE
160 REM -----
170 REGAH%=&H0:REGAL%=&H3             :REM FILL "REGISTERS"
180 REGBH%=&H0:REGBL%=&H0
190 REGCH%=&H0:REGCL%=&H0
200 REGDH%=&H0:REGDL%=&H0
210 INTERRUPT%=&H33:GOSUB 390          :REM CALL ASSEMBLY LANGUAGE SUBROUTINE
220 X=(REGCH%*256)+REGCL%
230 Y=(REGDH%*256)+REGDL%
240 REM -----
250 IF GMODE$="T" THEN 300
260 REM -----
270 PSET(X,Y),1
280 GOTO 320
290 REM -----
300 LOCATE (Y/8)+1,(X/8)+1:PRINT CHR$(219);
310 REM -----
320 LOCATE 12,35:PRINT "BUTTON STATUS-";
330 LOCATE 13,40:PRINT (REGBL% AND 7)
340 IN$=INKEY$:IF IN$="" THEN 170 ELSE END
350 IF IN$=CHR$(27) THEN END
360 GOTO 170
370 REM ----------------------------------------------------------------------
380 REM SET UP AND CALL ASSEMBLY LANGUAGE SUBROUTINE
390 DEF SEG=&H4B                      :REM POINT TO SEGMENT
400 POKE 31,INTERRUPT%                :REM INTERRUPT TO CALL
410 POKE 4,REGAH%:POKE 3,REGAL%
420 POKE 6,REGBH%:POKE 5,REGBL%
430 POKE 8,REGCH%:POKE 7,REGCL%
440 POKE 10,REGDH%:POKE 9,REGDL%
450 ASMSUB=0:CALL ASMSUB  :REM CALL ASSEMBLY LANGUAGE SUB. FOR INTERPRETER
460 REM CALL ABSOLUTE(0)      :REM CALL ASSEMBLY LANGUAGE SUB. FOR COMPILER
470 REGAH%=PEEK(4):REGAL%=PEEK(3)
480 REGBH%=PEEK(6):REGBL%=PEEK(5)
490 REGCH%=PEEK(8):REGCL%=PEEK(7)
500 REGDH%=PEEK(10):REGDL%=PEEK(9)
510 DEF SEG:RETURN                    :REM RETURN TO BASIC SEGMENT
520 REM ----------------------------------------------------------------------
530 REM LOAD AN ASSEMBLY LANGUAGE SUBROUTINE
540 DEF SEG=&H4B:FOR I=0 TO 51:READ B:POKE I,B:NEXT:DEF SEG:RETURN
550 REM -----
560 DATA &HEB,&H09,&H90
570 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00       :REM REGISTERS AX-DX
580 DATA &H2E,&HA1,&H03,&H00
590 DATA &H2E,&H8B,&H1E,&H05,&H00
600 DATA &H2E,&H8B,&H0E,&H07,&H00
610 DATA &H2E,&H8B,&H16,&H09,&H00
620 DATA &HCD,&H21                                     :REM INTERRUPT XX
630 DATA &H2E,&HA3,&H03,&H00
640 DATA &H2E,&H89,&H1E,&H5,&H0
650 DATA &H2E,&H89,&H0E,&H07,&H00
660 DATA &H2E,&H89,&H16,&H09,&H00
670 DATA &HCB                                          :REM RETF
680 LOCATE 1,1:PRINT REGBL% AND 7
