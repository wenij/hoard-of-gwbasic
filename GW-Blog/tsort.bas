16000 REM ===================================
16001 REM File sort and title gen
16002 REM
16003 REM INPUT - FL$ list of files
16004 REM         LC file count
16005 REM         DIREC$ directory with files
16006 REM OUTPUT - SFL$ sorted list of files
16007 REM          TIT$ titles of files
16008 REM ===================================
16010 IF C16000 = 1 THEN ERASE SFL$:ERASE TIT$
16012 C16000 = 1
16015 DIM SFL$(LC), TIT$(LC)
16020 FOR I = 1 TO LC
16025     IF INSTR(FL$,":") = 0 AND LEN(DIREC$) > 0 THEN FULLFILE$ = DIREC$+"\"+FL$(I) ELSE FULLFILE$ = FL$(I)
16030     OPEN FULLFILE$ FOR INPUT AS #10
16040     TIT$(I) = "****"
16050     WHILE(NOT EOF(10)) 
16060         LINE INPUT#10, LTXT$
16070         IF LEFT$(LTXT$, 3) = "h1." THEN TIT$(I) = RIGHT$(LTXT$, LEN(LTXT$)-4):GOTO 16100
16080     WEND
16090     TIT$(I) = FL$(I)
16100     CLOSE #10
16110     SFL$(I) = FL$(I)
16120 NEXT I
16130 REM Sort...
16140 FOR ILOW = 1 TO LC-1
16150     FOR IHI = (ILOW+1) TO LC
16160         NEEDSWAP = 0
16170         ILOWDOT=0:WHILE(MID$(SFL$(ILOW),ILOWDOT+1,1) <> "."):ILOWDOT = ILOWDOT+1:WEND
16180         IHIDOT=0:WHILE(MID$(SFL$(IHI),IHIDOT+1,1) <> "."):IHIDOT = IHIDOT+1:WEND

16184         IF INSTR(SFL$(ILOW), "\") = 0 THEN ILOWSL=1:GOTO 16189 
16185         ILOWSL=ILOWDOT:WHILE(ILOWSL>1 AND MID$(SFL$(ILOW),ILOWSL-1,1) <> "\"):ILOWSL=ILOWSL-1:WEND
16189         IF INSTR(SFL$(IHI), "\") = 0 THEN IHISL = 1:GOTO 16195
16190         IHISL=IHIDOT:WHILE(IHISL>1 AND MID$(SFL$(IHI),IHISL-1,1) <> "\"):IHISL=IHISL-1:WEND

16195         VLOW = VAL(MID$(SFL$(ILOW), ILOWSL, ILOWDOT-ILOWSL+1))
16200         VHI = VAL(MID$(SFL$(IHI), IHISL, IHIDOT-IHISL+1))

16205         IF VHI = 0 AND VLOW = 0 THEN 16210 ELSE 16220
16210         IF TIT$(ILOW) > TIT$(IHI) THEN SWAP TIT$(ILOW),TIT$(IHI):SWAP SFL$(ILOW),SFL$(IHI)
16215         GOTO 16300

16220         IF VHI > 0 AND VLOW > 0 THEN GOTO 16230 ELSE GOTO 16250
16230         IF SFL$(ILOW) > SFL$(IHI) THEN SWAP TIT$(ILOW),TIT$(IHI):SWAP SFL$(ILOW),SFL$(IHI)
16240         GOTO 16300

16250         IF VLOW = 0 AND VHI > 0 THEN SWAP TIT$(ILOW),TIT$(IHI):SWAP SFL$(ILOW),SFL$(IHI)

16300     NEXT IHI
16310 NEXT ILOW
16320 RETURN