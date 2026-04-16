;SF2_zaf
;===========================================
[Statedef 500]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
;trigger1 = command = "holdfwd" && command = "y"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 501
p2stateno = 505
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 405

[Statedef 501]
type = S
movetype = A
physics = S
anim = 510
velset = 0, 0
ctrl = 0

[State 501,playsnd]
type = playsnd
trigger1 = animelem = 1
value = 10,0

[State 501,playsnd]
type = playsnd
trigger1 = animelem = 6
value = 5,1

[State 501,velset]
type = velset
trigger1 = time>= 37
x = 3
y = -6
[State 501,velset]
type = velset
trigger1 = time>= 41
y = -3
[State 501,velset]
type = velset
trigger1 = time>= 45
y = -1
[State 501,velset]
type = velset
trigger1 = time>= 47
y = 1
[State 501,velset]
type = velset
trigger1 = time>= 49
y = 3
[State 501,velset]
type = velset
trigger1 = time>= 53
y = 6
[State 501,velset]
type = velset
trigger1 = time>= 55
x = 0
y = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 50,0
time = 3

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = 30,-60
time = 8

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 5
pos = 30,-40
time = 20

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 6
pos = 0,20
time = 5

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = 1

;[State 1215,Gravity]
;type = Gravity
;trigger1 = 1

[State 1220,EnvShake]
type = EnvShake
trigger1 = animelem = 6
time = 28

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0
;trigger1 = Vel Y > 0 && Pos Y >= 30
value = 502

[Statedef 502]
type = A
movetype = A
physics = N
anim = 41
velset = -1,-5
ctrl = 0

[State 1215,Gravity]
type = Gravity
trigger1 = 1

[State 1215,ChangeState]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 20
value = 52

;----------------------------------------------------------------------------
[Statedef 505]
type = A
movetype = H
physics = N
anim = 505
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
Trigger1 = AnimElem = 6
value = -100

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 511

[State 501,velset]
type = velset
trigger1 = time>= 37
x = -3
y = -6
[State 501,velset]
type = velset
trigger1 = time>= 41
y = -3
[State 501,velset]
type = velset
trigger1 = time>= 45
y = -1
[State 501,velset]
type = velset
trigger1 = time>= 47
y = 1
[State 501,velset]
type = velset
trigger1 = time>= 49
y = 3
[State 501,velset]
type = velset
trigger1 = time>= 53
y = 6
[State 501,velset]
type = velset
trigger1 = time>= 55
x = 0
y = 0

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 501,velset]
type = velset
trigger1 = animtime = 0
x = -1
y = -10

[State 1335,SelfState]
type = SelfState
trigger1 = animtime = 0
;trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100

;===========================================
[Statedef 510]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 55 && P2statetype != A && statetype != A && P2stateno != 50 && P2stateno != 51  && P2statetype != L  && P2movetype != H 
;trigger1 = command = "holdfwd" && command = "b"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 511
p2stateno = 515
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 225

;---------------------------------------------------------------------------------------------------------------------------------------
[Statedef 511]
type = S
movetype = A
physics = N
anim = 530
velset = 0, 0
ctrl = 0

[State 501,playsnd]
type = playsnd
trigger1 = animelem = 1
value = 10,1

[State 501,playsnd]
type = playsnd
trigger1 = time = 95
value = 5,1

[State 1220,EnvShake]
type = EnvShake
trigger1 = time = 95
time = 28

[State 1220,velset]
type = statetypeset
trigger1 = time >= 74
type = A

[State 1220,velset]
type = velset
trigger1 = time >= 75
y = -10
[State 1220,velset]
type = velset
trigger1 = time >= 78
y = -5
[State 1220,velset]
type = velset
trigger1 = time >= 81
y = -3
[State 1220,velset]
type = velset
trigger1 = time >= 84
y = -1

[State 1220,velset]
type = velset
trigger1 = time >= 85
y = 1
[State 1220,velset]
type = velset
trigger1 = time >= 88
y = 3
[State 1220,velset]
type = velset
trigger1 = time >= 91
y = 8
[State 1220,velset]
type = velset
trigger1 = time >= 95
y = 10
[State 1220,velset]
type = velset
trigger1 = time >= 96
y = 0

[State 1220,velset]
type = Posset
trigger1 = time >= 96
y = 0

[State 501,coner]
type = velset
trigger1 = time = 0 && BackEdgeDist < 50
x = 60
[State 501,coner]
type = velset
trigger1 = time = 1
x = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 40,0
time = 3

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = 30,-60
time = 10

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 5
pos = 30,-60
time = 6

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 6
pos = -40,-120
time = 20

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 7
pos = -80,-100
time = 8

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 8
pos = -100,-80
time = 4

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 9
pos = -100,0
time = 4

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0
;trigger1 = Vel Y > 0 && Pos Y >= 30
value = 0
ctrl = 1

;----------------------------------------------------------------------------
[Statedef 515]
type = A
movetype = H
physics = N
anim = 531
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
Trigger1 = AnimElem = 6
value = -100

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 531

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 1220,velset]
type = velset
trigger1 = time >= 75
y = -10
[State 1220,velset]
type = velset
trigger1 = time >= 78
y = -5
[State 1220,velset]
type = velset
trigger1 = time >= 81
y = -3
[State 1220,velset]
type = velset
trigger1 = time >= 84
y = -1

[State 1220,velset]
type = velset
trigger1 = time >= 85
y = 1
[State 1220,velset]
type = velset
trigger1 = time >= 88
y = 3
[State 1220,velset]
type = velset
trigger1 = time >= 91
y = 8
[State 1220,velset]
type = velset
trigger1 = time >= 95
y = 10
[State 1220,velset]
type = velset
trigger1 = time >= 96
y = 0

[State 501,velset]
type = velset
trigger1 = animtime = 0
x = 5
y = -10

[State 1335,SelfState]
type = SelfState
trigger1 = animtime = 0
;trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100

;===========================================
[Statedef 520]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
;trigger1 = command = "holdfwd" && command = "z"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 521
p2stateno = 525
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 210

;-------------------------------------------------------------------
[Statedef 521]
type = S
movetype = A
physics = S
anim = 521
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 20,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 70,-80
time = 245
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 12
pos = 70,0
time = 1

[State 911, 1]
type = Playsnd
Trigger1 = time = 35
trigger2 = time = 85
trigger3 = time = 135
trigger4 = time = 185
trigger5 = time = 235
value = 10,1

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = 1

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 0
ctrl = 1

;-------------------------------------------------------------------
[Statedef 525]
type = A
movetype = H
physics = N
anim = 525
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
Trigger1 = time = 35
trigger2 = time = 85
trigger3 = time = 135
trigger4 = time = 185
trigger5 = time = 235
value = -30

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 525

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 526
ctrl = 0

[Statedef 526]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 910, 0]
type = ChangeAnim
Trigger1 = Time = 0 
value = 43

[State 910, 0]
type = Nothitby
Trigger1 = Time >= 0 
value = SCA

[State 910, 0]
type = velset
Trigger1 = Time >= 0 
x = -3
y  = -5
[State 910, 0]
type = velset
Trigger1 = Time >= 5
y  = - 3
[State 910, 0]
type = velset
Trigger1 = Time >= 10
y  = -1
[State 910, 0]
type = velset
Trigger1 = Time >= 15
y  = 0
[State 910, 0]
type = velset
Trigger1 = Time >= 20
y  = 4
[State 910, 0]
type = velset
Trigger1 = Time >= 25
y  = 8
[State 910, 0]
type = velset
Trigger1 = Time >= 30
y  = 12

[State 1215,ChangeState]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 527

[Statedef 527]
type = A
movetype = H
physics = N
anim = 0
velset = 0, 0
ctrl = 0

[State 910, 0]
type = Posset
Trigger1 = time = 0
y = 0

[State 1335,SelfState]
type = SelfState
trigger1 = time = 1
value = 0
ctrl = 1

;===========================================
[Statedef 560]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
;trigger1 = command = "holdfwd" && command = "c"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 561
p2stateno = 565
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 230

;-------------------------------------------------------------------
[Statedef 561]
type = S
movetype = A
physics = S
anim = 561
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 20,0
time = 2
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 70,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 50,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = 60,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 5
pos = 50,-80
time = 170
[State 1310,TargetBind]
type = TargetBind
trigger1 = time = 213
pos = 50,0
time = 1

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = 1

[State 1215,ChangeState]
type = explod
trigger1 = time = 15 || time = 65 || time = 115 || time = 165
anim = 81
ID = 81
sprpriority = 2
postype = P1
pos = 60,25
bindtime = -1
supermove = 1
ownpal = 1
removetime = 27

[State 911, 1]
type = Playsnd
trigger1 = time = 15 || time = 65 || time = 115 || time = 165
value = 0,10

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 0
ctrl = 1

;-------------------------------------------------------------------
[Statedef 565]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
trigger1 = time = 15 || time = 65 || time = 115 || time = 165
value = -40

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 565

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 526
ctrl = 0

;===========================================
[Statedef 570]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
;trigger1 = command = "holddown" && command = "y"
;trigger1 = command = "holddown" && command = "z"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 571
p2stateno = 575
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 305
[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 310

;-------------------------------------------------------------------
[Statedef 571]
type = S
movetype = A
physics = S
anim = 570
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 50,0
time = 240

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = 1

[State 911, 1]
type = Playsnd
trigger1 = time = 40 || time = 100 || time = 140 || time = 200
value = 0,10

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 0
ctrl = 1

;-------------------------------------------------------------------
[Statedef 575]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
trigger1 = time = 40 || time = 100 || time = 140 || time = 200
value = -40

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 575

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 526
ctrl = 0

;===========================================
[Statedef 580]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
;trigger1 = command = "holddown" && command = "y"
;trigger1 = command = "holddown" && command = "z"
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 571
p2stateno = 575
fall = 1
fall.recover = 0
ground.cornerpush.veloff = -10
guard.cornerpush.veloff = -10

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 310


;air
;AIR THROW
[Statedef 900]
type = A
movetype = A
physics = A
ctrl = 0
anim = 900

[State 900,HitDef]
type = Hitdef
trigger1 = Time = 0
trigger1 = P2StateNo != [150,155]
attr = A, NT
getpower =  0
givepower = 20
hitflag = AF
priority = 4,Miss
numhits = 1
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 910
p2stateno = 920
p2getp1state = 1
hitsound = S800, 0
fall = 1
fall.recover = 0

[State 900,PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 4
value = 800, 2

[State 900,ChangeState]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52


;------------------- ¬Œ÷
[Statedef 910]
type = A
movetype = A
physics = N
anim = 910

[State 805,AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 920,vel]
type = VelSet
trigger1 = time >= 0
x = 0
y = 0

[State 920,vel]
type = VelSet
trigger1 = time >= 11
x = 1
y = 3
[State 920,vel]
type = VelSet
trigger1 = time >= 15
y = 6
[State 920,vel]
type = VelSet
trigger1 = time >= 20
y = 9
[State 920,vel]
type = VelSet
trigger1 = time >= 25
y = 12

[State 910,Gravity]
type = Gravity
trigger1 = time >= 10

[State 910,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = -20,-70
time = 10
[State 910,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 50,-20
time = 4

[State 960,6]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52

;air throw P2 state
[Statedef 920]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 810,AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 920,ChangeAnim2]
type = ChangeAnim2
trigger1 = Time = 0
value = 920

[State 920,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -2

[State 920,vel]
type = VelSet
trigger1 = time >= 11
x = -5
y = 4
[State 920,vel]
type = VelSet
trigger1 = time >= 15
y = 6
[State 920,vel]
type = VelSet
trigger1 = time >= 20
y = 8
[State 920,vel]
type = VelSet
trigger1 = time >= 25
y = 12

[State 920,SelfState]
type = Lifeadd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = - 100

[State 1220,EnvShake]
type = EnvShake
trigger1 = Vel Y > 0 && Pos Y >= 0
time = 28

[State 920,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100


;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

;air
;AIR THROW
[Statedef 950]
type = A
movetype = A
physics = A
ctrl = 0
anim = 900

[State 900,HitDef]
type = Hitdef
trigger1 = Time = 0
trigger1 = P2StateNo != [150,155]
attr = A, NT
getpower =  0
givepower = 20
hitflag = AF
priority = 4,Miss
numhits = 1
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 960
p2stateno = 970
p2getp1state = 1
hitsound = S800, 0
fall = 1
fall.recover = 0

[State 900,PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 4
value = 800, 2

[State 900,ChangeState]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52


;------------------- ¬Œ÷
[Statedef 960]
type = A
movetype = A
physics = N
anim = 910

[State 1310,TargetBind]
type = turn
trigger1 = time = 0
persistent = 0 

[State 805,AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 920,vel]
type = VelSet
trigger1 = time >= 0
x = 0
y = 0

[State 920,vel]
type = VelSet
trigger1 = time >= 11
x = 1
y = 3
[State 920,vel]
type = VelSet
trigger1 = time >= 15
y = 6
[State 920,vel]
type = VelSet
trigger1 = time >= 20
y = 9
[State 920,vel]
type = VelSet
trigger1 = time >= 25
y = 12

[State 910,Gravity]
type = Gravity
trigger1 = time >= 10

[State 910,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = -20,-70
time = 10
[State 910,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 50,-20
time = 4

[State 960,6]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52

;air throw P2 state
[Statedef 970]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = turn
trigger1 = time = 0
persistent = 0 

[State 810,AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 920,ChangeAnim2]
type = ChangeAnim2
trigger1 = Time = 0
value = 920

[State 920,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -2

[State 920,vel]
type = VelSet
trigger1 = time >= 11
x = -5
y = 4
[State 920,vel]
type = VelSet
trigger1 = time >= 15
y = 6
[State 920,vel]
type = VelSet
trigger1 = time >= 20
y = 8
[State 920,vel]
type = VelSet
trigger1 = time >= 25
y = 12

[State 920,SelfState]
type = Lifeadd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = - 100

[State 1220,EnvShake]
type = EnvShake
trigger1 = Vel Y > 0 && Pos Y >= 0
time = 28

[State 920,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100