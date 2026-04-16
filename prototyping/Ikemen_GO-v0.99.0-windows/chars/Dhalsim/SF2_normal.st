;SF2_DHALSIM
;var(8)   = 1 face is 1P
;var(8) = 2 face is 2P
;var(14) = 1 is EX
;var(14) = 0 is SF
;
;exp 13500 is SF
;exp 13560 is EX
;
;1,1 LPK air sound
;1,2 MPK air sound
;1,3 HPK air sound
;2,1                              to                                2,6           is hitsound
;3,1 is guard sound
;4,1 is jump
;6,1 is super sound
;5,1 is through sound
;fight FX
;1 is  L             FX no
;2 is M or H FX no
;3 is guard no
;30 is super effect
;40 is super finish
;
;DAMAGE
;LPK is 30
;MPK is 45
;HPK is 60
;
;POWER ADD
;LPK is 30 and MPK is 45 and HPK is 60 same asd energy
;
;GivePower 
;LPK is 10 and MPK is 15 and HPK is 20 is 1/3 of energy
;juggle
;LPK juggle = 5 MPK juggle = 10
;
;
pausetime
;LPK pausetime is 11,11 MPK is 13,13  HPK is 15,15
;
;====================================================================================================================
[Data]
life = 1000
attack = 100
defence = 100
fall.defence_up = 30
liedown.time = 20
airjuggle = 15
juggle = 15
sparkno = F2
guard.sparkno = 40
KO.echo = 1
volume = 10
IntPersistIndex = 60
FloatPersistIndex = 40

[Size]
xscale = 1           
yscale = 1           
ground.back = 20
ground.front = 20
air.back = 20
air.front = 20
z.width = 3          
height = 60	     
attack.dist = 160
proj.attack.dist = 90
proj.doscale = 0
head.pos = -5, -90
mid.pos = -5, -60
shadowoffset = 0
draw.offset = 0,0

[Velocity]
walk.fwd  = 1.7
walk.back = -1.5
run.fwd  =  0
run.back = 0
jump.neu = 0,-7.5
jump.back = -1.7
jump.fwd = 1.7
runjump.back = -3.5,-9.5
runjump.fwd = 4,-9.5
airjump.neu = 0,-8.1
airjump.back = -2.55
airjump.fwd = 2.5

[Movement]
airjump.num = 0
airjump.height = 35
yaccel = .3				;.44 is default	1 is light and bigger is faster
stand.friction =.82				; .85  
crouch.friction =.82				; .82 

[Quotes]
victory1 = "I will meditate and then destroy you."
victory2 = "Now you've realized the inner mysteries of yoga."
victory3 = "Mastery comes from within."
victory4 = "Your mind is full of wrong ideas. It's best your empty it."
victory5 = "You must master yourself before you can truly complete."

;====================================================================================================
;time over lose
[Statedef 170]
type = S
ctrl = 0
anim = 170
velset = 0,0

[State 170,1]
type = NotHitBy
trigger1 = 1
value = SCA

[State 170,12]
type = AssertSpecial
trigger1 = Time = [0,140]
flag = RoundNotOver

;---------------------------------------------------------------------
;win
[Statedef 180]
type = S
movetype = I
physics = N
velset = 0, 0
ctrl = 0

[State 180,NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA

[State 1130,PlaySnd]
type = PlaySnd
trigger1 = Time = 1
value = 4,0

[State 180,ChangeState]
type = ChangeState
trigger1 = time = 0
value = 181

;------------------------ ï™äÚ
[Statedef 181]
type = S
ctrl = 0
anim = 180
velset = 0,0

[State 1130,PlaySnd]
type = PlaySnd
trigger1 = Time = 1
value = 180,0

[State 181, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1


;win2 
[StateDef 182];èüóò
Type = S
Ctrl = 0
VelSet = 0, 0
Anim = 181
SprPriority = 1

[State 182]
Type = NotHitBy
Trigger1 = 1
Value = SCA

[State 182]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 180+MatchOver

[State 182]
Type = AssertSpecial
Trigger1 = Time < 200
Flag = RoundNotOver
;---------------------------------------------------------------------
;intro
[Statedef 191]
type = S
ctrl = 0
anim = 0
velset = 0,0

[State 191, 1] ;Freeze animation until PreIntro is over
type = ChangeAnim
trigger1 = RoundState = 0
value = 0

[State 191, 2] ;Assert this until you want "round 1, fight" to begin
type = AssertSpecial
trigger1 = 1
flag = Intro

[State 191, 3] ;Change to stand state when done
type = ChangeState
trigger1 = AnimTime = 0
value = 0

;=====================================================================
;Near Stand Light Punch
[Statedef 200]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 200
juggle = 5

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 8,8
guard.pausetime = 8,8
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 12
;
guard.hittime = 11
guard.ctrltime = 11
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-75
;
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30

[State 200,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;FAR Stand Light Punch
[Statedef 240]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 240
juggle = 15

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 8,8
guard.pausetime = 8,8
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 12
;
guard.hittime = 11
guard.ctrltime = 11
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-75
;
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30

[State 240,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND LIGHT KICK
[Statedef 220]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 220
juggle = 5

[State 205,2]
type = HitDef
trigger1 = time = 0
priority=4, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 8,8
guard.pausetime = 8,8
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 12
;
guard.hittime = 11
guard.ctrltime = 11
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-75
;
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30

[State 220,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;FAR STAND LIGHT KICK
[Statedef 260]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 260
juggle = 5

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 8,8
guard.pausetime = 8,8
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 12
;
guard.hittime = 11
guard.ctrltime = 11
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-75
;
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30

[State 260,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND MIDDLE PUNCH
[Statedef 205]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 205
juggle = 10

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 14
guard.ctrltime = 14
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 90
GivePower = 45

[State 205,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;FAR STAND MIDDLE PUNCH
[Statedef 245]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 245
juggle = 10

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 14
guard.ctrltime = 14
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 90
GivePower = 45

[State 245,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND MIDDLE KICK
[Statedef 225]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 225
juggle = 15

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 14
guard.ctrltime = 14
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 90
GivePower = 45

[State 225,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;FAR STAND MIDDLE KICK
[Statedef 265]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 265
juggle = 15

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 14
guard.ctrltime = 14
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 90
GivePower = 45

[State 265,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND HEAVY PUNCH
[Statedef 210]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 210
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 60
GivePower = 20
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 20
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5.5
guard.velocity = -12
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 210,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;FAR STAND HEAVY PUNCH
[Statedef 250]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 250
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 60
GivePower = 20
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 20
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5.5
guard.velocity = -12
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 250,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND HEAVY KICK
[Statedef 230]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 230
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 60
GivePower = 20
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 20
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5.5
guard.velocity = -12
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 230,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;NEAR STAND HEAVY KICK
[Statedef 270]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 270
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 60
GivePower = 20
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 20
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5.5
guard.velocity = -12
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40


[State 270,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;========================================================================================================
;---------------------------------------------------------------------------
;C LP
[Statedef 300]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 300
juggle = 5

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light			;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 15
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -8
air.velocity = -3,-5
;
guard.velocity = -8
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30
;
;p2getp1state = 
p2facing = 1

[State 300,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;CMP
[Statedef 305]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 305
juggle = 10

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-35
;
juggle = 10
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 305,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;C H P
[Statedef 310]
type = C
physics = C
movetype = A
ctrl = 0
velset = 0
anim = 310
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr =C,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 120
GivePower = 60
;
pausetime = 12,12
guard.pausetime = 12,12
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 20
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
guard.velocity = -12
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-25
;
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 310,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;C LK
[Statedef 320]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 320
juggle = 5

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light			;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 15
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -8
air.velocity = -3,-5
;
guard.velocity = -8
airguard.velocity = -3, -2
;
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-15
;
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 60
GivePower = 30
;
;p2getp1state = 
p2facing = 1

[State 320,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

[State 205,2]
type = velset
trigger1 = time = 1
x = 10
[State 205,2]
type = velset
trigger1 = time = 9
x = .2

;---------------------------------------------------------------------------
;C M K
[Statedef 325]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 325
juggle = 15

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -15
guard.cornerpush.veloff = -15
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 325,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

[State 205,2]
type = velset
trigger1 = time = 5
x = 11
[State 205,2]
type = velset
trigger1 = time = 16
x = .4

;---------------------------------------------------------------------------
;C H K
[Statedef 330]
type = C
physics = C
movetype = A
ctrl = 0
velset = 0
anim = 330
juggle = 15

[State 330,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = C,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
;
animtype = heavy			;2p ANIM
;air.animtype = Back		;2p ANIM
ground.type = trip
;
damage = 60
getpower =120
GivePower = 60
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 15
ground.hittime = 15
air.hittime = 9
;
guard.hittime = 15
guard.ctrltime = 15
;
ground.velocity = -2,-6
air.velocity = -2,-6
guard.velocity = -12
airguard.velocity = -4,-2
;
ground.cornerpush.veloff = -20
guard.cornerpush.veloff = -20
;
sparkxy = 0,-15
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
fall = 1
fall.recover = 0

[State 330,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

[State 205,2]
type = velset
trigger1 = time = 5
x = 14
[State 205,2]
type = velset
trigger1 = time = 16
x = .4

;=================================================================================================================== 
; FRONT/BACk 		JUMP light punch
[Statedef 340]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 340 

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = Light
air.animtype = Back
;
damage = 30
pausetime = 8,10
ground.slidetime = 9
ground.hittime = 9
guard.hittime = 13
air.hittime = 9
guard.ctrltime = 13
ground.velocity = -3
air.velocity = -3,-5.5
guard.velocity = -3
airguard.velocity = -3, -1.5
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
juggle = 5
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
air.juggle = 16

;==============================================================
; STRIGHT JUMP light punch
[Statedef 370]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 370 

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = Light
air.animtype = Back
;
damage = 30
pausetime = 8,10
ground.slidetime = 9
ground.hittime = 9
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14
ground.velocity = -3
air.velocity = -3,-5.5
guard.velocity = -3
airguard.velocity = -3, -1.5
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
juggle = 5
hitsound = S7,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
air.juggle = 16

;==============================================================
; FRONT/BACk 		JUMP light K
[Statedef 355]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 355

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = Light
air.animtype = Back
;
damage = 30
pausetime = 8,10
ground.slidetime = 9
ground.hittime = 9
guard.hittime = 14
air.hittime = 9
ground.velocity = -3
air.velocity = -3,-5.5
guard.velocity = -3
airguard.velocity = -3, -1.5
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
juggle = 5
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
air.juggle = 16

;==============================================================
; stright 		JUMP light K
[Statedef 385]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 385

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = Light
air.animtype = Back
;
damage = 30
pausetime = 8,10
ground.slidetime = 9
ground.hittime = 9
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14
ground.velocity = -3
air.velocity = -3,-5.5
guard.velocity = -3
airguard.velocity = -3, -1.5
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
juggle = 5
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
air.juggle = 16

;==============================================================
; F/B 		JUMP MP
[Statedef 345]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 345

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 45
pausetime = 10,13
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14
ground.velocity = -4
air.velocity = -3,-5.5
guard.velocity = -4
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 30
GivePower = 10
;
air.juggle = 16
juggle = 10

;==============================================================
;STRIGHT 		JUMP MP
[Statedef 375]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 375

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 45
pausetime = 10,13
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14	
ground.velocity = -4
air.velocity = -3,-5.5
guard.velocity = -4
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 30
GivePower = 10
;
air.juggle = 16
juggle = 10

;==============================================================
;F/B		JUMP MK
[Statedef 360]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 360
juggle = 10

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 45
pausetime = 10,13
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14
ground.velocity = -4
air.velocity = -3,-5.5
guard.velocity = -4
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 30
GivePower = 10
;
air.juggle = 16
juggle = 10

;==============================================================
;STRIGHT 		JUMP MK
[Statedef 390]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 390
juggle = 10

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 45
pausetime = 10,14
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 14
air.hittime = 9
guard.ctrltime = 14
ground.velocity = -4
air.velocity = -3,-5.5
guard.velocity = -4
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 30
GivePower = 10
;
air.juggle = 16
juggle = 10

;==============================================================
;F/B		JUMP HP
[Statedef 350]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 350
juggle = 15

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 60
pausetime = 10,15
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 17
air.hittime = 9
guard.ctrltime = 17
guard.hittime = 17
ground.velocity = -5
air.velocity = -3,-4
guard.velocity = -8
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 60
GivePower = 20
;
air.juggle = 16
juggle = 10

;==============================================================
;STRIGHT		JUMP HP
[Statedef 380]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 380
juggle = 15

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 60
pausetime = 10,14
ground.slidetime = 12
ground.hittime = 18
guard.hittime = 17
guard.ctrltime = 17
air.hittime = 9
ground.velocity = -5
air.velocity = -3,-4
guard.velocity = -8
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 60
GivePower = 20
;
air.juggle = 16
juggle = 10

;==============================================================
;F/B		JUMP HK
[Statedef 365]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 365
juggle = 15

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 60
pausetime = 10,14
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 17
guard.ctrltime = 17
air.hittime = 9
ground.velocity = -5
air.velocity = -3,-4
guard.velocity = -8
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 60
GivePower = 20
;
air.juggle = 16
juggle = 10

;==============================================================
;ST		JUMP HK
[Statedef 395]
type = A
movetype = A
physics = A
ctrl = 0  
anim = 395
juggle = 15

[State 300,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = A, NA
hitflag = MA
guardflag = HA
ground.type = Low
;
animtype = middle
;air.animtype = Back
;
damage = 60
pausetime = 10,14
ground.slidetime = 15
ground.hittime = 15
guard.hittime = 17
air.hittime = 9
guard.ctrltime = 17
ground.velocity = -5
air.velocity = -3,-4
guard.velocity = -8
airguard.velocity = -3, -1
ground.cornerpush.veloff = -8
guard.cornerpush.veloff = -8
sparkxy = 0,-55
;
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
getpower = 60
GivePower = 20
;
air.juggle = 16
juggle = 10






























;=====================================================================
;SPECIAL PK:::
;STAND BACK LP
[Statedef 440]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 440
juggle = 5

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 8,8
guard.pausetime = 8,8
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 12
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-75
;
juggle = 10
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
;p2getp1state = 
p2facing = 1

[State 200,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------------------------------------------------------------------------------------
;STAND BACK M P
[Statedef 445]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 445
juggle = 10

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
juggle = 10
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 205,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------------------------------------------------------------------------------------
;STAND BACK HP
[Statedef 450]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 450
juggle = 15

[State 210,2]
type = HitDef
trigger1 = Animelem = 3
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 40
getpower = 120
GivePower = 60
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 5
;
ground.hittime = 5
air.hittime = 17
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -5
air.velocity = -3,-5
guard.velocity = -5
airguard.velocity = -4,-5
air.juggle = 16
;
ground.cornerpush.veloff = 0
guard.cornerpush.veloff = 0
;
sparkxy = 10,-65
;
juggle = 10
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 210,2]
type = HitDef
trigger1 =  animelem = 4
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 40
getpower = 120
GivePower = 60
;
pausetime = 14,14
guard.pausetime = 14,14
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 30
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5
guard.velocity = -12
airguard.velocity = -4,-5
air.juggle = 16
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
juggle = 10
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40


[State 210,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------------------------------------------------------------------------------------
;STAND FRONT LK
[Statedef 420]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 420
juggle = 5

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 15
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-65
;
juggle = 10
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
;p2getp1state = 
p2facing = 1

[State 220,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------------------------------------------------------------------------------------
;STAND BACK MK
[Statedef 460]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 460
juggle = 10

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
juggle = 10
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 265,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;STAND BACK HK
[Statedef 465]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 465
juggle = 15

[State 210,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = S,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 120
GivePower = 60
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 30
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5.5
guard.velocity = -12
airguard.velocity = -4,-5
air.juggle = 16
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-65
;
juggle = 10
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 230,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;BACK C LP
[Statedef 470]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 470
juggle = 5

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light			;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 15
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -8
air.velocity = -3,-5.5
;
guard.velocity = -8
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,1
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
;p2getp1state = 
p2facing = 1

[State 300,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;BACK CMP
[Statedef 475]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 475
juggle = 10

[State 205,2]
type = HitDef
trigger1 = time = 0
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5.5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-75
;
juggle = 10
hitsound = S2,2
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 305,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;BACK C H P
[Statedef 480]
type = C
physics = C
movetype = A
ctrl = 0
velset = 0
anim = 480
juggle = 15

[State 210,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr =C,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = M			;GUARD is MIDDLE /L is LOW
;
animtype = hard	 		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup"
air.animtype = back			;2p ANIM
ground.type = high
;
damage = 60
getpower = 120
GivePower = 60
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 20
;
ground.hittime = 20
air.hittime = 30
;
guard.hittime = 17
guard.ctrltime =17
;
ground.velocity = -12
air.velocity = -3,-5
guard.velocity = -12
airguard.velocity = -4,-5
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 10,-25
;
juggle = 10
hitsound = S2,3
guardsound = S3,1
sparkno = 2
guard.sparkno = 40

[State 310,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1


;---------------------------------------------------------------------------
;BACK C LK
[Statedef 485]
type = C
movetype = A
physics = C
ctrl = 0
velset = 0
anim = 485
juggle = 5

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = light			;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = light			;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 30
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 10
;
ground.hittime = 10
air.hittime = 15
;
guard.hittime = 12
guard.ctrltime = 12
;
ground.velocity = -7
air.velocity = -3,-5
;
guard.velocity = -7
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,4
guardsound = S3,1
sparkno = 1
guard.sparkno = 40
getpower = 30
GivePower = 10
;
;p2getp1state = 
p2facing = 1

[State 320,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;BACK C M K
[Statedef 490]
type = S
physics = S
movetype = A
ctrl = 0
velset = 0
anim = 490
juggle = 10

[State 205,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit			;2 for ??, 3 for M/H att, 4 for L att, 5 for super, 6 fot hyper
;
attr = C,NA			;STAND / NORMAL ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
hitflag = MA
;
animtype = Medium		;2p ANIM, light", "medium", "hard", "back", "up",    or "diagup".
air.animtype = medium		;2p ANIM
ground.type = high			;  high,	middle	low	trip
;
damage = 45
;
pausetime = 10,10
guard.pausetime = 10,10
;
ground.slidetime = 15
;
ground.hittime = 15
air.hittime = 15
;
guard.hittime = 13
guard.ctrltime = 13
;
ground.velocity = -10
air.velocity = -3,-5
;
guard.velocity = -10
airguard.velocity = -3, -2
;
air.juggle = 16
;
ground.cornerpush.veloff = -18
guard.cornerpush.veloff = -18
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,5
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
getpower = 45
GivePower = 15
;
;p2getp1state = 
p2facing = 1

[State 325,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;BACK C H K
[Statedef 495]
type = C
physics = C
movetype = A
ctrl = 0
velset = 0
anim = 495
juggle = 15

[State 330,2]
type = HitDef
trigger1 = Animelem = 2
priority = 3, Hit
;
attr = C,NA			;STAND / NORMAL ATTACK
hitflag = MA			;MIDDLE ATTACK
guardflag = L			;GUARD is MIDDLE /L is LOW
;
animtype = heavy			;2p ANIM
;air.animtype = Back		;2p ANIM
ground.type = high
;
damage = 60
getpower = 60
GivePower = 20
;
pausetime = 12,12
guard.pausetime = 12,12
;
ground.slidetime = 15
ground.hittime = 15
air.hittime = 9
;
guard.hittime = 15
guard.ctrltime = 15
;
ground.velocity = -12
air.velocity = -2,-7
guard.velocity = -12
airguard.velocity = -4,-2
air.juggle = 16
;
ground.cornerpush.veloff = -25
guard.cornerpush.veloff = -25
;
sparkxy = 0,-15
;
juggle = 10
hitsound = S2,6
guardsound = S3,1
sparkno = 2
guard.sparkno = 40
;
fall = 0
fall.recover = 0
air.juggle = 16

[State 330,3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

























;=====================================================================
;=================================================================
[Statedef 14444]
type    = S
movetype= A
physics = N
ctrl = 0

;varset
[State 14444, var]
type = Varadd
trigger1 =  var(14) = 0
v = 14
ignorehitpause = 1
value = 1

[State 14444, var]
type = ChangeState
trigger1 = time = 5
value = 0
ctrl = 1

[Statedef 44444]
type    = S
movetype= A
physics = N
ctrl = 0

[State 14444, var]
type = Varadd
trigger1 =  var(14) = 1
v = 14
ignorehitpause = 1
value = -1

[State 14444, var]
type = ChangeState
trigger1 = time = 5
value = 0
ctrl = 1

;===========================================================================
;------------------------------------------------------------------------------------------------------------------------------------
[Statedef -2]
[State -2, Super finish style 1]
type = Explod
triggerall = Win && !WinTime
triggerall = NumExplod(13580) = 0
trigger1 = StateNo = [2000,2999]		;normal ∂W•≤±˛ßﬁ
trigger2 = StateNo = [3000,3999]		;EX ∂W•≤±˛ßﬁ
anim = F 40
ID = 13580
sprpriority = -3
postype = left
pos = -30,10
bindtime = -1
supermove = 1
ownpal = 1
removetime = 160
scale = 1,1.2

[State -2,AssertSpecial]
type = AssertSpecial
triggerall = 1
trigger1 = NumExplod(13580) = 1
flag = NoBarDisplay
flag2 = NoBG
flag3 = NoFG
ignorehitpause = 1

[State -2, AssertSpecial]
Type =AssertSpecial
trigger1 = 1
flag = noairguard

;---------------------------------------------------------------------------
;=================== [-2 states] ======================================
[State -2, Var0 set]
;set var(8) is 1 when the round is start
type = VarSet
trigger1 = RoundState < 2        	 ;<--Ω–∞—¶“data\triggers.txt§§™∫ª°©˙
trigger1 = facing = 1
v = 8
value = 1

[State -2, Var0 set]
;set var(8) is 1 when the round is start
type = VarSet
trigger1 = RoundState < 2         	;<--Ω–∞—¶“data\triggers.txt§§™∫ª°©˙
trigger1 = facing = -1
v = 8
value = 2

;AIAIAIAIAI
[State -2, Var0 set]
;set var(14) is 0 when the round is start
type = VarSet
trigger1 = RoundState < 2         	;<--Ω–∞—¶“data\triggers.txt§§™∫ª°©˙
v = 25
value = 0
;AIAIAIAIAI
[State -2, Var0 set]
;set var(14) is 0 when the round is start
type = VarSet
trigger1 = RoundState < 2         	;<--Ω–∞—¶“data\triggers.txt§§™∫ª°©˙
v = 26
value = 0

[State -2, Var0 set]
;set var(14) is 0 when the round is start
type = VarSet
trigger1 = RoundState < 2         	;<--Ω–∞—¶“data\triggers.txt§§™∫ª°©˙
v = 14
value = 0

;L
[State -2, Cap1_L ]	;SF
type = Explod
triggerall = NumExplod(140) = 0
trigger1 = var(8) =1 && var(14) = 0
id = 140
persistent = 0
sprpriority = -2
anim = F140
pos = 5,213
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;R
[State -2, Cap1_L ]	;SF
type = Explod
triggerall = NumExplod(140) = 0
trigger1 = var(8) =2 && var(14) = 0
id = 140
persistent = 0
sprpriority = -2
anim = F140
pos = 255,213
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;L
;for show groove if 3p also geese/ dont use my pack(mmx) 1350-1361
[State -2, Cap1_L ]	;EX
type = Explod
triggerall = NumExplod(141) = 0
trigger1 = var(8) =1 && var(14) = 1
id = 141
persistent = 0
sprpriority = -2
anim = F141
pos = 5,213
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;R
[State -2, Cap1_L ]	;EX
type = Explod
triggerall = NumExplod(141) = 0
trigger1 = var(8) =2 && var(14) = 1
id = 141
persistent = 0
sprpriority = -2
anim = F141
pos = 260,213
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

[State -2, red fir]
Type = RemoveExplod
Trigger1 = NumExplod(140) = 1 && var(14) = 1
ID = 140
[State -2, red fir]
Type = RemoveExplod
Trigger1 = NumExplod(141) = 1 && var(14) = 0
ID = 141

;POWER ICON
;L
[State -2, Cap1_L ]	;3000
type = Explod
triggerall = NumExplod(3000) = 0
trigger1 = var(8) =1 && power >= 3000
id = 3000
persistent = 0
sprpriority = 2
anim = F3000
pos = 8,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;R
[State -2, Cap1_R ]	;SF
type = Explod
triggerall = NumExplod(3000) = 0
trigger1 = var(8) =2 && power >= 3000
id = 3000
persistent = 0
sprpriority = 2
anim = F3000
pos = 255,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

[State -2, red fir]
Type = RemoveExplod
Trigger1 = NumExplod(3000) = 1 && Power < 3000
ID = 3000

;L
[State -2, Cap1_L ]	;2000
type = Explod
triggerall = NumExplod(2000) = 0
trigger1 = var(8) =1 && power >= 2000
id = 2000
persistent = 0
sprpriority = 2
anim = F2000
pos = 8,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;R
[State -2, Cap1_R ]	;SF
type = Explod
triggerall = NumExplod(2000) = 0
trigger1 = var(8) =2 && power >= 2000
id = 2000
persistent = 0
sprpriority = 2
anim = F2000
pos = 255,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

[State -2, red fir]
Type = RemoveExplod
Trigger1 = NumExplod(2000) = 1 && ( Power < 2000 || Power >= 3000 )
ID = 2000

;L
[State -2, Cap1_L ]	;1000
type = Explod
triggerall = NumExplod(1000) = 0
trigger1 = var(8) =1 && power >= 1000
id = 1000
persistent = 0
sprpriority = 2
anim = F1000
pos = 8,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

;R
[State -2, Cap1_R ]	;SF
type = Explod
triggerall = NumExplod(1000) = 0
trigger1 = var(8) =2 && power >= 1000
id = 1000
persistent = 0
sprpriority = 2
anim = F1000
pos = 255,225
postype = left
ignorehitpause = 1
bindtime = -1
ownpal = 1

[State -2, red fir]
Type = RemoveExplod
Trigger1 = NumExplod(1000) = 1 && ( Power < 1000 || Power >= 2000 )
ID = 1000
;================================================================
[State -2,sound]	;have sound when use  PK
type = PlaySnd
triggerall = animelem = 2
trigger1 = stateno = 200 || stateno = 220 || stateno = 240 || stateno = 260 || stateno = 300 || stateno = 320 || stateno = 340 || stateno = 370 || stateno = 400 || stateno = 440 || stateno = 470 || stateno = 355 || animelem = 385 || animelem = 390
trigger2 = stateno = 420 || stateno = 485
value = 1,1

[State -2,sound]
type = PlaySnd
triggerall = animelem = 2
trigger1 = stateno =  205 || stateno = 245 || stateno =  305 || stateno =  345 || stateno = 375||stateno =  405 || stateno =  445 || stateno =  475
trigger2 = stateno =  225 || stateno = 265 || stateno =  305 || stateno =  325 || stateno = 360 ||stateno =  425 || stateno =  460 || stateno =  490 || stateno = 390 
value = 1,2

[State -2,sound]
type = PlaySnd
triggerall = animelem = 2
trigger1 = stateno =   210 || stateno = 250 || stateno = 250 || stateno = 310 || stateno = 350 || stateno = 380 || stateno = 410 || stateno = 450 || stateno = 480
trigger2 = stateno =   230 || stateno = 270 || stateno = 250 || stateno = 330 || stateno = 365|| stateno = 395|| stateno = 430 || stateno = 465 || stateno = 495
value = 1,3

[State -2, Landing Sound]
type = PlaySnd
triggerall = Time = 1
trigger1 = stateno = 52 
value =  4,1

;after inamge if not super
[State -2, 1]
type = AfterImageTime
trigger1 = MoveType = H
;trigger2 = StateNo = 52
Time = 0

;when win, then zoom the char.
[State -2,ScreenBound]
type = ScreenBound
triggerall = 1
trigger1 = StateNo = 190
trigger2 = StateNo = 191
value = 0
movecamera = 1, 0

[State -2,turn]
type = turn
trigger1 = statetype !=L && movetype != H  && P2BodyDist X < -30  && ctrl = 1 && stateno = 40
trigger2 = statetype !=L && movetype != H  && P2BodyDist X < -30  && ctrl = 1 && stateno = 52

;
;
;light fire body 8001
;heavy fire body 8000
;light fire body air 8003
;heavy fire body air 8002
;fire body croch 8004
;

;electric
[State -2, electric]
Type = RemoveExplod
Trigger1 = P2StateNo=5100 
ID = 5410
;
[State -2, blue fire]
Type = RemoveExplod
Trigger1 = P2StateNo=5100 
ID = 1102

;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, red fir]
Type = RemoveExplod
Trigger1 = P2StateNo =5100 
ID = 8002
;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, red fir]
Type = RemoveExplod
Trigger1 = P2StateNo =5100 
ID = 8003

;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, 1227]
type = Explod
trigger1 = P2stateno = 1227 && numexplod(8003) = 0 && P2name != "zangief"
anim = 8003
ID = 8003
sprpriority = -1
postype = p2
pos = 0,0
bindtime = -1
supermove = 1
ownpal = 1
removetime = 100
;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, 1227]
type = Explod
trigger1 = P2stateno = 1227 && numexplod(8002) = 0 && P2name = "zangief"
anim = 8002
ID = 8002
sprpriority = -1
postype = p2
pos = 0,0
bindtime = -1
supermove = 1
ownpal = 1
removetime = 100

;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, 1015]
type = Explod
trigger1 = P2stateno = 1015 && numexplod(8003) = 0 && P2name != "zangief"
trigger2 = P2stateno = 10155 && numexplod(8003) = 0 && P2name != "zangief"
anim = 8003
ID = 8003
sprpriority = -1
postype = p2
pos = 0,0
bindtime = -1
supermove = 1
ownpal = 1
removetime = 100
;DHALSIM and KEN RED FIRE FOR DHALSIM ONLY
[State -2, 1015]
type = Explod
trigger1 = P2stateno = 1015 && numexplod(8002) = 0 && P2name = "zangief"
trigger2 = P2stateno = 10155 && numexplod(8002) = 0 && P2name = "zangief"
anim = 8002
ID = 8002
sprpriority = -1
postype = p2
pos = 0,0
bindtime = -1
supermove = 1
ownpal = 1
removetime = 100

;µLºvthgrow
[State -2, µLºvthgrow]
type = changestate
trigger1 = P2stateno = 1301 && p2name = "guile" && stateno != 13055
value = 13055

;dhalsim super 2000 chnage anim!!!
[State -2, changeanim1]
type = changeAnim
trigger1 = P2stateno = 2001 || P2stateno = 2010 || P2stateno  = 2012 || P2stateno  = 2013 || P2stateno  = 2011 
trigger1 = p2name ="dhalsim" &&  statetype != A
trigger1 = stateno = [5000,5099] 
value = 8001
[State -2, changeanim2]
type = changeAnim
trigger1 = anim = 8001
trigger1 = stateno = 5100
value = 0
[State -2, changeanim3]
type = changeAnim
trigger1 = P2stateno = 2001 || P2stateno = 2010 || P2stateno  = 2012 || P2stateno  = 2013 || P2stateno  = 2011 
trigger1 = p2name ="dhalsim" &&  statetype = A
trigger1 = stateno = [5000,5099] 
value = 8003

;Dhalsim special; frame remove exp
[State -2, flash2]
Type = RemoveExplod
triggerall = name = "dhalsim"
Trigger1 = stateno = [5000, 5999]
trigger2 = movecontact = 1 && stateno = 1100
trigger3 = movecontact = 1 && stateno = 1110
trigger4 = movecontact = 1 && stateno = 1120
ID = 1101

;=====================================================================
;Prevent the P1 char. after gethit in the air then attack P2, or can change the state 5040 state.
[State -2, Ctrlset]
type = ctrlset
triggerall = statetype = A
trigger1 = PrevStateNo = [5000,5105]	;5000, 5105    5040
value = 0

;first att
[State -2, Var5 set]
;set var(5) is 1 when the round is start
type = VarSet
trigger1 = RoundState < 2        
v = 5
value = 0

[State -2, Var6 set]
;set var(6) is 1 when the round is start
type = VarSet
trigger1 = RoundState < 2        
v = 6
value = 0

[State -2, Var5 set]
type = Varadd
trigger1 =  movehit = 1
trigger2 = P2stateno = [5000, 5999]
v = 5
value = 1

[State -2, Var5 set]
type = Varadd
trigger1 = stateno = [5000,5999]
v = 6
value = 1

[State -2,first]
type = Explod
trigger1 = var(5) = 1 && var(6) = 0
trigger1 = numexplod(80) = 0 
trigger1 = var(8) = 1
anim = F80
ID = 80
sprpriority = -1
postype = left
pos = -17,70
bindtime = -1
supermove = 1
ownpal = 1
removetime = 200

[State -2,first]
type = Explod
trigger1 = var(5) = 1 && var(6) = 0
trigger1 = numexplod(80) = 0 
trigger1 = var(8) = 2
anim = F82
ID = 80
sprpriority = -1
postype = left
pos = 342,70
bindtime = -1
supermove = 1
ownpal = 1
removetime = 200

;cannot hit P2 after hit p2 in the air.
[State -2, Nothitby]
type = nothitby
triggerall = statetype = A 
triggerall = PrevStateNo = [5000,5105] 				;5000, 5105    5040
trigger1 = P2name = "ryu" && P2stateno != 345
trigger1 = P2stateno != [2000,2999] 				;for ryu
trigger2 = P2name = "honda" && P2stateno != [2000,2999]
trigger3 = P2name = "ken" && P2stateno != [2000,2999]
trigger4 = P2name = "ken" && P2stateno != [2000,2999]
trigger5 = P2name = "chun li" && P2stateno != [2000,2999]
trigger6 = P2name = "zangief" && P2stateno != [2000,2999]
trigger7 = P2name = "dhalsim" && P2stateno != [2000,2999]
trigger8 = P2name = "guile" && P2stateno != [2000,2999]
trigger9 = P2name = "M.bison" && P2stateno != [2000,2999]
trigger10 = P2name = "sagat" && P2stateno != 1221
trigger10 = P2stateno != [2000,2999] 
trigger11 = P2name = "balrog"  && P2stateno != [2000,2999]
trigger12 = P2name = "vega" && P2stateno != [2000,2999]
trigger13 = P2name = "blanka"  && P2stateno != [2000,2999]
;
trigger14 = P2name = "deejay" && P2stateno != 1311
trigger14 = P2stateno != 1321
trigger14 = P2stateno != 13211
trigger14 = P2stateno != [2000,2999] 	
trigger15 = P2name = "thawk" && P2stateno = [0,999]
trigger16 = P2name = "feilong" && P2stateno = [0,1099]
trigger17 = P2name = "cammy" && P2stateno != [2000,2999]
trigger18 = P2name = "gouki" && P2stateno = [0,999]
value = SCA

[State -2, flash2]
Type = Attackmulset
trigger1 = P2life >= 400
value = 1.4

[State -2, flash2]
Type = Attackmulset
trigger1 = P2life < 400
value = 0.6

;RYU special
[State -2, flash2]
Type = RemoveExplod
Trigger1 = stateno != 2301 && name = "ryu"
ID = 30

[State -2,sound]
type = PlaySnd
triggerall = Win && !WinTime && animtime = 0
trigger1 = StateNo = [2000,2999]		;normal ∂W•≤±˛ßﬁ
trigger2 = StateNo = [3000,3999]		;EX ∂W•≤±˛ßﬁ
value = 8,0

; States that are executed when in self's state file (use statedef -3)
;---------------------------------------------------------------------------
;=================== [-3 states] ======================================
[Statedef -3]

[State -2, Velset]
type = Velset
trigger1 = stateno = 52
x = 0