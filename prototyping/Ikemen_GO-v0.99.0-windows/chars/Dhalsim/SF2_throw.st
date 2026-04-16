;SF2_Dhalsim
;===========================================
[Statedef 500]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 35 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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
value = 205

;-------------------------------------------------------------------
[Statedef 501]
type = S
movetype = A
physics = S
anim = 500
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 50,0
time = 8
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 50,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 50,0
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = 30,0
time = 168

[State 911, 1]
type = Playsnd
Trigger1 = time = 17
trigger2 = time = 53
trigger3 = time = 89
trigger4 = time = 125
trigger5 = time = 161
value = 10,0

[State 911, 1]
type = Playsnd
Trigger1 = time = 17
trigger2 = time = 53
trigger3 = time = 89
trigger4 = time = 125
trigger5 = time= 161
value = 2,5

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
[Statedef 505]
type = A
movetype = H
physics = N
anim = 505
velset = 0, 0
ctrl = 0

[State 911, 1]
type = LifeAdd
Trigger1 = time = 17
trigger2 = animelem = 53
trigger3 = animelem = 89
trigger4 = animelem = 125
trigger5 = animelem = 161
value = -30

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 505

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 1215,ChangeState]
type = ChangeState
trigger1 = animtime = 0 
value = 507
ctrl = 0

[Statedef 507]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 910, 0]
type = ChangeAnim
Trigger1 = Time = 0 
value = 5040	;43

[State 910, 0]
type = velset
Trigger1 = Time >= 0 
x = -3
y  = -7
[State 910, 0]
type = velset
Trigger1 = Time >= 8
y  = - 4
[State 910, 0]
type = velset
Trigger1 = Time >= 14
y  = -1
[State 910, 0]
type = velset
Trigger1 = Time >= 18
y  = 0
[State 910, 0]
type = velset
Trigger1 = Time >= 23
y  = 4
[State 910, 0]
type = velset
Trigger1 = Time >= 28
y  = 8
[State 910, 0]
type = velset
Trigger1 = Time >= 33
y  = 12

[State 1215,ChangeState]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 509

[Statedef 509]
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
[Statedef 510]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 35 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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
p1stateno = 511
p2stateno = 515
fall = 1
fall.recover = 0
ground.cornerpush.veloff = 0
guard.cornerpush.veloff = 0

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 450

;-------------------------------------------------------------------
[Statedef 511]
type = S
movetype = A
physics = S
anim = 510
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 60,0
time = 15
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 50,0
time = 10
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 0,-80
time = 6
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = -80,-80
time = 1

[State 911, 1]
type = Playsnd
Trigger1 = animelem = 4
value = 10,3

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
[Statedef 515]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 515

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 910, 0]
type = velset
Trigger1 = Time >= 32
x = 4
y  = -4
[State 910, 0]
type = velset
Trigger1 = Time >= 37
x = 3.5
y  = - 2
[State 910, 0]
type = velset
Trigger1 = Time >= 42
y  = -1
[State 910, 0]
type = velset
Trigger1 = Time >= 47
y  = 0
[State 910, 0]
type = velset
Trigger1 = Time >= 52
y  = 1
[State 910, 0]
type = velset
Trigger1 = Time >= 57
y  = 3
[State 910, 0]
type = velset
Trigger1 = Time >= 62
y  = 7

[State 911, 1]
type = LifeAdd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = -150

[State 1335,SelfState]
type = SelfState
trigger1 = animtime = 0
trigger2 = Vel Y > 0 && Pos Y >= 0
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
trigger1 = Time = 0 && P2bodydist X <= 35 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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
ground.cornerpush.veloff = 0
guard.cornerpush.veloff = 0

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 250

;-------------------------------------------------------------------
[Statedef 521]
type = S
movetype = A
physics = S
anim = 510
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = turn
trigger1 = time >= 0
persistent = 0 

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 60,0
time = 15
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 50,0
time = 10
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 0,-80
time = 5
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = -80,-80
time = 1

[State 911, 1]
type = Playsnd
Trigger1 = animelem = 4
value = 10,3

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
ctrl = 0

[State 1310,TargetBind]
type = turn
trigger1 = time >= 0
persistent = 0 

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 515

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 910, 0]
type = velset
Trigger1 = Time >= 33
x = 5
y  = -4
[State 910, 0]
type = velset
Trigger1 = Time >= 37
x = 3.5
y  = - 2
[State 910, 0]
type = velset
Trigger1 = Time >= 42
y  = -1
[State 910, 0]
type = velset
Trigger1 = Time >= 47
y  = 0
[State 910, 0]
type = velset
Trigger1 = Time >= 52
y  = 1
[State 910, 0]
type = velset
Trigger1 = Time >= 57
y  = 3
[State 910, 0]
type = velset
Trigger1 = Time >= 62
y  = 7


[State 911, 1]
type = LifeAdd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = -150

[State 1335,SelfState]
type = SelfState
trigger1 = animtime = 0
trigger2 = Vel Y > 0 && Pos Y >= 0
value = 5100



