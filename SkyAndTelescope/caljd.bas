800 REM   CALENDAR --> JD
805 REM
810 INPUT "Y,M,D ";Y,M,D
815 INPUT "JC (0) OR GC (1) ";G
820 D1=INT(D): F=D-D1-0.5
825 J=-INT(7*(INT((M+9)/12)+Y)/4)
830 IF G=0 THEN 850
835 S=SGN(M-9): A=ABS(M-9)
840 J1=INT(Y+S*INT(A/7))
845 J1=-INT((INT(J1/100)+1)*3/4)
850 J=J+INT(275*M/9)+D1+G*J1
855 J=J+1721027+2*G+367*Y
860 IF F>=0 THEN 870
865 F=F+1: J=J-1
870 PRINT "J.D.: ";J;F
875 END
880 REM  ------------------------
885 REM  APPEARED IN ASTRONOMICAL
890 REM  COMPUTING, SKY & TELE-
895 REM  SCOPE, MAY, 1984
900 REM  ------------------------
