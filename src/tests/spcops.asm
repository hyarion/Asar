;@00     01  02 12  03 12 F9  04 12  05 34 12  06        07 12  08 12     09 34 12 0A 34 72  0B 12  0C 34 12  0D     0E 34 12  0F      
;@10 FE  11  12 12  13 12 F8  14 12  15 34 12  16 34 12  17 12  18 34 12  19       1A 12     1B 12  1C        1D     1E 34 12  1F 34 12
;@20     21  22 12  23 12 F9  24 12  25 34 12  26        27 12  28 12     29 34 12 2A 34 72  2B 12  2C 34 12  2D     2E 12 E0  2F DE   
;@30 FE  31  32 12  33 12 F8  34 12  35 34 12  36 34 12  37 12  38 34 12  39       3A 12     3B 12  3C        3D     3E 12     3F 34 12
;@40     41  42 12  43 12 F9  44 12  45 34 12  46        47 12  48 12     49 34 12 4A 34 72  4B 12  4C 34 12  4D     4E 34 12  4F 12   
;@50 FE  51  52 12  53 12 F8  54 12  55 34 12  56 34 12  57 12  58 34 12  59       5A 12     5B 12  5C        5D     5E 34 12  5F 34 12
;@60     61  62 12  63 12 F9  64 12  65 34 12  66        67 12  68 12     69 34 12 6A 34 72  6B 12  6C 34 12  6D     6E 12 E0  6F      
;@70 FE  71  72 12  73 12 F8  74 12  75 34 12  76 34 12  77 12  78 34 12  79       7A 12     7B 12  7C        7D     7E 12     7F      
;@80     81  82 12  83 12 F9  84 12  85 34 12  86        87 12  88 12     89 34 12 8A 34 72  8B 12  8C 34 12  8D 12  8E        8F 34 12
;@90 FE  91  92 12  93 12 F8  94 12  95 34 12  96 34 12  97 12  98 34 12  99       9A 12     9B 12  9C        9D     9E 9E     9F      
;@A0     A1  A2 12  A3 12 F9  A4 12  A5 34 12  A6        A7 12  A8 12     A9 34 12 AA 34 72  AB 12  AC 34 12  AD 12  AE        AF      
;@B0 FE  B1  B2 12  B3 12 F8  B4 12  B5 34 12  B6 34 12  B7 12  B8 34 12  B9       BA 12     BB 12  BC        BD     BE        BF      
;@C0     C1  C2 12  C3 12 F9  C4 12  C5 34 12  C6        C7 12  C8 12     C9 34 12 CA 34 72  CB 12  CC 34 12  CD 12  CE        CF      
;@D0 FE  D1  D2 12  D3 12 F8  D4 12  D5 34 12  D6 34 12  D7 12  D8 12     D9 12    DA 12     DB 12  FC        DD     DE 12 E1  DF      
;@E0     E1  E2 12  E3 12 F9  E4 12  E5 34 12  E6        E7 12  E8 12     E9 34 12 EA 34 72  EB 12  EC 34 12  ED     EE        EF      
;@F0 FE  F1  F2 12  F3 12 F8  F4 12  F5 34 12  F6 34 12  F7 12  F8 12     F9 12    FA 34 12  FB 12  FC        FD     FE E1     FF      

arch spc700-raw
org $0000

label0:
nop
tcall 0
set1 $12.0
bbs1 $12.0,label0
or a,$12
or a,$1234
or a,(x)
or a,($12+x)
or a,#$12
or $12,$34
or1 c,$1234.3
asl $12
asl $1234
push p
tset $1234,a
brk

label1:
bpl label1
tcall 1
clr1 $12.0
bbc1 $12.0,label1
or a,$12+x
or a,$1234+x
or a,$1234+y
or a,($12)+y
or $12,#$34
or (x),(y)
decw $12
asl $12+x
asl a
dec x
cmp x,$1234
jmp ($1234+x)

label2:
clrp
tcall 2
set1 $12.1
bbs1 $12.1,label2
and a,$12
and a,$1234
and a,(x)
and a,($12+x)
and a,#$12
and $12,$34
or1 c,!$1234.3
rol $12
rol $1234
push a
cbne $12,label2
bra label2

label3:
bmi label3
tcall 3
clr1 $12.1
bbc1 $12.1,label3
and a,$12+x
and a,$1234+x
and a,$1234+y
and a,($12)+y
and $12,#$34
and (x),(y)
incw $12
rol $12+x
rol a
inc x
cmp x,$12
call $1234

label4:
setp
tcall 4
set1 $12.2
bbs1 $12.2,label4
eor a,$12
eor a,$1234
eor a,(x)
eor a,($12+x)
eor a,#$12
eor $12,$34
and1 c,$1234.3
lsr $12
lsr $1234
push x
tclr $1234,a
pcall $12

label5:
bvc label5
tcall 5
clr1 $12.2
bbc1 $12.2,label5
eor a,$12+x
eor a,$1234+x
eor a,$1234+y
eor a,($12)+y
eor $12,#$34
eor (x),(y)
cmpw ya,$12
lsr $12+x
lsr a
mov x,a
cmp y,$1234
jmp $1234

label6:
clrc
tcall 6
set1 $12.3
bbs1 $12.3,label6
cmp a,$12
cmp a,$1234
cmp a,(x)
cmp a,($12+x)
cmp a,#$12
cmp $12,$34
and1 c,!$1234.3
ror $12
ror $1234
push y
dbnz $12,label6
ret

label7:
bvs label7
tcall 7
clr1 $12.3
bbc1 $12.3,label7
cmp a,$12+x
cmp a,$1234+x
cmp a,$1234+y
cmp a,($12)+y
cmp $12,#$34
cmp (x),(y)
addw ya,$12
ror $12+x
ror a
mov a,x
cmp y,$12
reti

label8:
setc
tcall 8
set1 $12.4
bbs1 $12.4,label8
adc a,$12
adc a,$1234
adc a,(x)
adc a,($12+x)
adc a,#$12
adc $12,$34
eor1 c,$1234.3
dec $12
dec $1234
mov y,#$12
pop p
mov $12,#$34

label9:
bcc label9
tcall 9
clr1 $12.4
bbc1 $12.4,label9
adc a,$12+x
adc a,$1234+x
adc a,$1234+y
adc a,($12)+y
adc $12,#$34
adc (x),(y)
subw ya,$12
dec $12+x
dec a
mov x,sp
div ya,x
xcn : xcn a

labela:
ei
tcall 10
set1 $12.5
bbs1 $12.5,labela
sbc a,$12
sbc a,$1234
sbc a,(x)
sbc a,($12+x)
sbc a,#$12
sbc $12,$34
mov1 c,$1234.3
inc $12
inc $1234
cmp y,#$12
pop a
mov (x+),a

labelb:
bcs labelb
tcall 11
clr1 $12.5
bbc1 $12.5,labelb
sbc a,$12+x
sbc a,$1234+x
sbc a,$1234+y
sbc a,($12)+y
sbc $12,#$34
sbc (x),(y)
movw ya,$12
inc $12+x
inc a
mov sp,x
das a
mov a,(x+)

labelc:
di
tcall 12
set1 $12.6
bbs1 $12.6,labelc
mov $12,a
mov $1234,a
mov (x),a
mov ($12+x),a
cmp x,#$12
mov $1234,x
mov1 $1234.3,c
mov $12,y
mov $1234,y
mov x,#$12
pop x
mul ya

labeld:
bne labeld
tcall 13
clr1 $12.6
bbc1 $12.6,labeld
mov $12+x,a
mov $1234+x,a
mov $1234+y,a
mov ($12)+y,a
mov $12,x
mov $12+y,x
movw $12,ya
mov $12+x,y
inc y
mov a,y
cbne $12+x,labeld
daa a

labele:
clrv
tcall 14
set1 $12.7
bbs1 $12.7,labele
mov a,$12
mov a,$1234
mov a,(x)
mov a,($12+x)
mov a,#$12
mov x,$1234
not1 c,$1234.3
mov y,$12
mov y,$1234
notc
pop y
sleep

labelf:
beq labelf
tcall 15
clr1 $12.7
bbc1 $12.7,labelf
mov a,$12+x
mov a,$1234+x
mov a,$1234+y
mov a,($12)+y
mov x,$12
mov x,$12+y
mov $12,$34
mov y,$12+x
inc y
mov y,a
dbnz y,labelf
stop
