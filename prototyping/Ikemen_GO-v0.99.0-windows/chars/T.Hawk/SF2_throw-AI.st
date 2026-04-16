;SF2_thawk

;===========================================
[Statedef 500]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0
anim = 500

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 205

;----------------------------------------------------------------------------
[Statedef 501]
type = S
movetype = A
physics = S
anim = 501
velset = 0, 0
ctrl = 0

;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 65,0
time = 10
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 30,-40
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 0,-50
time = 8
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = -40,-70
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 5
pos = 20,-20
time = 2

[State 501,playsnd]
type = playsnd
trigger1 = time = 10
value = 0,2

[State 1200,End]
type = ChangeState
trigger1 = animtime = 0
value = 0
ctrl = 1

;----------------------------------------------------------------------------
[Statedef 505]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 505

[State 501,velset]
type = velset
trigger1 = time>= 30
x = -4
y = -6
[State 501,velset]
type = velset
trigger1 = time>= 35
y = -3.5
[State 501,velset]
type = velset
trigger1 = time>= 40
y = -2
[State 501,velset]
type = velset
trigger1 = time>= 45
y = 1
[State 501,velset]
type = velset
trigger1 = time>= 50
y = 3
[State 501,velset]
type = velset
trigger1 = time>= 55
y = 5
[State 501,velset]
type = velset
trigger1 = time>= 60
y = 7

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 911, 1]
type = LifeAdd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = -100

[State 1335,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100


;===========================================
[Statedef 540]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0
anim = 500

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
attr = S, NT		
getpower = 60
givepower = 20
hitflag = M-			;M-
guardflag = -1			;None
priority = 3,miss
sparkno = -1
p1facing = 1
p2facing = 1
p1stateno = 541
p2stateno = 545
fall = 1
fall.recover = 0

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 205

;----------------------------------------------------------------------------
[Statedef 541]
type = S
movetype = A
physics = S
anim = 501
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = turn
trigger1 = time = 0
persistent = 0 

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 65,0
time = 10
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 2
pos = 30,-40
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 3
pos = 0,-50
time = 8
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 4
pos = -40,-70
time = 4
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 5
pos = 20,-20
time = 2

[State 501,playsnd]
type = playsnd
trigger1 = time = 10
value = 0,2

[State 1200,End]
type = ChangeState
trigger1 = animtime = 0
value = 0
ctrl = 1

;----------------------------------------------------------------------------
[Statedef 545]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

[State 1310,TargetBind]
type = turn
trigger1 = time = 0
persistent = 0 

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 505

[State 501,velset]
type = velset
trigger1 = time>= 30
x = -4
y = -6
[State 501,velset]
type = velset
trigger1 = time>= 35
y = -3.5
[State 501,velset]
type = velset
trigger1 = time>= 40
y = -2
[State 501,velset]
type = velset
trigger1 = time>= 45
y = 1
[State 501,velset]
type = velset
trigger1 = time>= 50
y = 3
[State 501,velset]
type = velset
trigger1 = time>= 55
y = 5
[State 501,velset]
type = velset
trigger1 = time>= 60
y = 7

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 911, 1]
type = LifeAdd
trigger1 = Vel Y > 0 && Pos Y >= 0
value = -100

[State 1335,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 5100


;===========================================
[Statedef 510]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0
anim = 510

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 210

;----------------------------------------------------------------------------
[Statedef 511]
type = S
movetype = A
physics = S
anim = 511
velset = 0, 0
ctrl = 0

;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 30,-125
time = 150
[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 11
pos = 30,0
time = 1

[State 911, 1]
type = PlaySnd
trigger1 = animelem = 3
trigger2 = animelem = 5
trigger3 = animelem = 7
trigger4 = animelem = 9
trigger5 = animelem = 1
value = 0,4
[State 911, 1]
type = PlaySnd
trigger1 = animelem = 3
trigger2 = animelem = 5
trigger3 = animelem = 7
trigger4 = animelem = 9
trigger5 = animelem = 1
value = S2,6

[State 1310,snd]
type = Explod
trigger1 = animelem = 3
trigger2 = animelem = 5
trigger3 = animelem = 7
trigger4 = animelem = 9
trigger5 = animelem = 1
anim = F2
ID = 2
sprpriority = 3
postype = p1
pos = 40,-120
bindtime = -1
supermove = 1
ownpal = 1
removetime = 10

[State 1200,End]
type = ChangeState
trigger1 = animtime = 0
value = 0
ctrl = 1

;----------------------------------------------------------------------------
[Statedef 515]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 515

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 911, 1]
type = velset
Trigger1 = time >= 151
x = -4
y = -5
[State 911, 1]
type = velset
Trigger1 = time >= 155
y = -3
[State 911, 1]
type = velset
Trigger1 = time >= 160
y = -1
[State 911, 1]
type = velset
Trigger1 = time >= 165
y = 2
[State 911, 1]
type = velset
Trigger1 = time >= 170
y = 4
[State 911, 1]
type = velset
Trigger1 = time >= 175
y = 6
[State 911, 1]
type = velset
Trigger1 = time >= 185
y = 8

[State 911, 1]
type = LifeAdd
trigger1 = animelem = 3
trigger2 = animelem = 5
trigger3 = animelem = 7
trigger4 = animelem = 9
trigger5 = animelem = 1
value = -20

[State 910, 0]
type = ChangeAnim
Trigger1 = animtime = 0
value = 41

[State 1335,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52
ctrl = 1

;===========================================
[Statedef 520]
type = S
movetype = A
physics = S
velset = 0, 0
ctrl = 0
anim = 520

[State 1200,HitDef]
type = Hitdef
trigger1 = Time = 0 && P2bodydist X <= 25 && P2statetype != A && P2statetype != L && P2movetype != H && statetype != A && P2stateno != 50 && P2stateno != 51 
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

[State 1200,End]
type = ChangeState
trigger1 = time = 1
value = 210

;----------------------------------------------------------------------------
[Statedef 521]
type = S
movetype = A
physics = S
anim = 521
velset = 0, 0
ctrl = 0

;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

[State 1310,TargetBind]
type = TargetBind
trigger1 = AnimElem = 1
pos = 30,-70
time = 150

[State 911, 1]
type = PlaySnd
trigger1 = animelem = 1
trigger2 = animelem = 4
trigger3 = animelem = 7
trigger4 = animelem = 10
trigger5 = animelem = 13
value = 0,4

[State 911, 1]
type = PlaySnd
trigger1 = animelem = 1
trigger2 = animelem = 4
trigger3 = animelem = 7
trigger4 = animelem = 10
trigger5 = animelem = 13
value = S2,6

[State 1310,snd]
type = Explod
trigger1 = animelem = 1
trigger2 = animelem = 4
trigger3 = animelem = 7
trigger4 = animelem = 10
trigger5 = animelem = 13
anim = F2
ID = 2
sprpriority = 3
postype = p1
pos = 30,-70
bindtime = -1
supermove = 1
ownpal = 1
removetime = 10

[State 1200,End]
type = ChangeState
trigger1 = animtime = 0
value = 0
ctrl = 1

;----------------------------------------------------------------------------
[Statedef 525]
type = A
movetype = H
physics = N
velset = 0, 0
ctrl = 0

;[State 1310,TargetBind]
;type = turn
;trigger1 = time = 0
;persistent = 0 

[State 910, 0]
type = ChangeAnim2
Trigger1 = Time = 0 
value = 525

[State 1215,SprPriority]
type = SprPriority
trigger1 = time >= 0
value = -1

[State 911, 1]
type = velset
Trigger1 = time >= 150
x = -2.5
y = -3
[State 911, 1]
type = velset
Trigger1 = time >= 155
y = -2
[State 911, 1]
type = velset
Trigger1 = time >= 160
y = 0
[State 911, 1]
type = velset
Trigger1 = time >= 165
y = 2
[State 911, 1]
type = velset
Trigger1 = time >= 170
y = 4
[State 911, 1]
type = velset
Trigger1 = time >= 175
y = 6
[State 911, 1]
type = velset
Trigger1 = time >= 185
y = 8

[State 911, 1]
type = LifeAdd
trigger1 = animelem = 1
trigger2 = animelem = 4
trigger3 = animelem = 7
trigger4 = animelem = 10
trigger5 = animelem = 13
value = -20

[State 910, 0]
type = ChangeAnim
Trigger1 = animtime = 0
value = 41

[State 1335,SelfState]
type = SelfState
trigger1 = Vel Y > 0 && Pos Y >= 0
value = 52
ctrl = 1