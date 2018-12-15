100 REM     WAVELENGTHS
110 REM
120 DATA 6563,14.5
130 DATA 4861,49.0
140 DATA 3889,85.0
150 READ W1,S1
160 READ W2,S2
170 READ W3,S3
180 P=W2-W1: Q=W3-W1: R=S2-S1
190 S=S3-S1: T=S3-S2
200 A=R/P: B=S/Q
210 U=A-B: V=T/U: L=W1-V
220 D1=A*(W2-L): D2=D1+S1
230 C=(D1*T)/U
240 PRINT
250 INPUT "DISTANCE";D
260 IF D<0 THEN 310
270 W=L+(C/(D2-D))
280 W=INT(W+0.5)
290 PRINT "WAVELENGTH = ";W
300 GOTO 240
310 END
320 REM  ------------------------
330 REM  APPEARED IN ASTRONOMICAL
340 REM  COMPUTING, SKY & TELE-
350 REM  SCOPE, JUNE, 1985
360 REM  ------------------------
