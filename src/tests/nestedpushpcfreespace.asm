;@+
;@07FD7 0A
;@07FDC 87 58 78 A7
;@80000
;@53 54 41 52 05 00 FA FF
;@01 02 03 04 05 06
;@53 54 41 52 02 00 FD FF
;@07 08 09
;@FFFFF 00
@freedata
db 1,2,3

pushpc
@freedata
db 7,8,9
pullpc

db 4,5,6
Label: