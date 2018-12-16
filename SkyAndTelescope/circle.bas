10 REM  CIRCLE-DIVIDING PROGRAM
12 REM
14 N=9: DIM P1(N), P2(N)
16 I0=180: C$=CHR$(27)+"3"+CHR$(1)
18 H=8: REM MINIMUM VERTICAL
20 REM      LETTER SPACE IN MM
22 DATA 4,6,9,12,18,36,72,180,360
24 FOR I=1 TO N: READ P1(I): NEXT
26 DATA 9,6,8,6,4,5,10,8,6
28 FOR I=1 TO N: READ P2(I): NEXT
30 REM
32 INPUT "SCALE LENGTH (MM)";S
34 IF S<30 THEN 32
36 I1=0
38 I1=I1+1: IF I1=N THEN 42
40 IF S>=P1(I1)*H THEN 38
42 PRINT "PRINTING...": LPRINT C$
44 FOR I=1 TO I0/4: LPRINT: NEXT
46 LPRINT S;" MM STRIP DIVIDED ";
48 LPRINT "INTO ";P1(I1);" PARTS"
50 FOR I=1 TO I0/4: LPRINT: NEXT
52 REM
54 REM    PRINTING LOOP
55 REM    SET UP FOR DOT-MATRIX PRINTERS
56 W=0: S0=INT(360/P1(I1))
58 S1=S*I0/(25.4*360)
60 FOR I=0 TO 360 STEP S0
62 B=INT(I*S1-W): F=W
64 FOR J=0 TO P2(I1)
66 I3=INT(J*B/P2(I1)-F)
68 IF I3<0 THEN 76
70 FOR K=1 TO I3: LPRINT: NEXT K
72 IF I3<=0 OR J>=P2(I1) THEN 76
74 LPRINT "         -";
76 F=F+I3
78 NEXT J
80 LPRINT USING "   #### --";I;
82 W=W+B
84 NEXT I
86 FOR I=1 TO I0/4: LPRINT: NEXT
88 INPUT "ANOTHER (Y/N)";Q$
90 IF Q$="Y" THEN 32
92 END
94 REM *************************
96 REM   ASTRONOMICAL COMPUTING
97 REM SKY & TELESCOPE, MARCH 88
98 REM *************************
