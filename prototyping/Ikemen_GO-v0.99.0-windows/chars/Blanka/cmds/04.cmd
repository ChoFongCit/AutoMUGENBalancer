


[Command]
name = "hyperrolling"
command = ~30$B,F,B,F,x
time = 20
[Command]
name = "hyperrolling"
command = ~30$B,F,B,F,y
time = 20
[Command]
name = "hyperrolling"
command = ~30$B,F,B,F,z
time = 20

[Command]
name = "electric"
command = x, x, x, x
time = 30
[Command]
name = "electric"
command = y, y, y, y
time = 30
[Command]
name = "electric"
command = z, z, z, z
time = 30

[Command]
name = "electric1"
command = x, x, x, x
time = 30
[Command]
name = "electric1"
command = y, y, y, y
time = 30
[Command]
name = "electric1"
command = z, z, z, z
time = 30

[Command]
name = "rolling7"
command = ~30$D, U, a
time = 10
[Command]
name = "rolling8"
command = ~30$D, U, b
time = 10
[Command]
name = "rolling9"
command = ~30$D, U, c
time = 10

[Command]
name = "rolling1"
command = ~30$B,F,x
[Command]
name = "rolling2"
command = ~30$B,F,y
[Command]
name = "rolling3"
command = ~30$B,F,z
[Command]
name = "rolling4"
command = ~30$B,F,a
[Command]
name = "rolling5"
command = ~30$B,F,b
[Command]
name = "rolling6"
command = ~30$B,F,c




[Command]
name = "FF"     
command = F, F
time = 15
[Command]
name = "BB"     
command = B, B
time = 15

[Command]
name = "recovery"
command = x+y
time = 1


[Command]
name = "x"
command = x
time = 1
[Command]
name = "y"
command = y
time = 1
[Command]
name = "z"
command = z
time = 1
[Command]
name = "a"
command = a
time = 1
[Command]
name = "b"
command = b
time = 1
[Command]
name = "c"
command = c
time = 1
[Command]
name = "s"
command = s
time = 1

[Command]
name = "holdp"
command = /$x
time = 1
[Command]
name = "holdp"
command = /$y
time = 1
[Command]
name = "holdp"
command = /$z
time = 1


[Command]
name = "holdfwd"
command = /$F
time = 1
[Command]
name = "holdback"
command = /$B
time = 1
[Command]
name = "holdup" 
command = /$U
time = 1
[Command]
name = "holddown"
command = /$D
time = 1


[Statedef -1]


[State -1, rol]
type = ChangeState
value = 1010
triggerall = AILevel <= 0
triggerall = command = "rolling2" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist Y < -704
trigger3 = InGuardDist


[State -1, close mp]
type = ChangeState
value = 211
triggerall = AILevel <= 0
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist X > 760
trigger3 = MoveContact || MoveGuarded



[State -1, rol]
type = ChangeState
value = 1210
triggerall = AILevel <= 0
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2MoveType = I


[State -1, Air lk]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 155
trigger2 = P2StateType = C
trigger3 = InGuardDist

;Air_mk

[State -1, throw]
type = ChangeState
value = 800
triggerall = AILevel <= 0
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = A



[State -1, close lk]
type = ChangeState
value = 231
triggerall = AILevel <= 0
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -257
trigger2 = P2StateType = S


[State -1, Air sp]
type = ChangeState
value = 620
triggerall = AILevel <= 0
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 976

;Air_lk

[State -1, p]
type = ChangeState
value = 210
triggerall = AILevel <= 0
triggerall = command = "y" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 349
trigger2 = InGuardDist
trigger3 = P2MoveType = I
trigger4 = P2BodyDist X > 381


[State -1, crouch mk]
type = ChangeState
value = 440
triggerall = AILevel <= 0
triggerall = command = "b" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 575
trigger2 = InGuardDist
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = H



[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 956
trigger2 = P2BodyDist Y < 762




[State -1, k]
type = ChangeState
value = 240
triggerall = AILevel <= 0
triggerall = command = "b" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -629
trigger2 = P2StateType = C


[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y > 314
trigger3 = P2StateType = C


[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = AILevel <= 0
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X >= 442
trigger3 = P2StateType = S
trigger4 = MoveContact






[State -1, rol]
type = ChangeState
value = 1100
triggerall = AILevel <= 0
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist
trigger3 = P2BodyDist Y < 239
trigger4 = MoveGuarded



[State -1, crouch lk]
type = ChangeState
value = 430
triggerall = AILevel <= 0
triggerall = command = "a" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X < 222
trigger3 = P2BodyDist Y > -315
trigger4 = P2MoveType = H
trigger5 = InGuardDist



[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = AILevel <= 0
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist X < 219



[State -1, close fdmp]
type = ChangeState
value = 270
triggerall = AILevel <= 0
triggerall = command = "z" 
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X >= 138
trigger3 = MoveContact
trigger4 = P2BodyDist Y <= -605
trigger5 = P2MoveType = H
trigger6 = P2StateType = C



[State -1, close lp]
type = ChangeState
value = 201
triggerall = AILevel <= 0
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = A



[State -1, Air mp]
type = ChangeState
value = 610
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist X > 540
trigger3 = InGuardDist
trigger4 = P2BodyDist Y > 556
trigger5 = P2StateType = S
trigger6 = MoveContact || MoveGuarded



[State -1, k]
type = ChangeState
value = 230
triggerall = AILevel <= 0
triggerall = command = "a" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist Y <= 934
trigger3 = MoveGuarded
trigger4 = P2StateType = C
trigger5 = P2BodyDist X >= 960
trigger6 = InGuardDist


[State -1, Air lp]
type = ChangeState
value = 600
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 413



[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2StateType = C
trigger3 = InGuardDist
trigger4 = P2MoveType = H
trigger5 = P2BodyDist X >= 845


[State -1, p]
type = ChangeState
value = 200
triggerall = AILevel <= 0
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = H


[State -1, close mk]
type = ChangeState
value = 241
triggerall = AILevel <= 0
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 573
trigger2 = P2StateType = A
trigger3 = P2BodyDist Y <= 131
trigger4 = P2MoveType = A
trigger5 = InGuardDist
trigger6 = MoveContact || MoveGuarded




[State -1, Air sp]
type = ChangeState
value = 621
triggerall = AILevel <= 0
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 426
trigger2 = P2StateType = S
trigger3 = InGuardDist



[State -1, rol]
type = ChangeState
value = 1220
triggerall = AILevel <= 0
triggerall = command = "rolling9"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 212
trigger2 = P2StateType = A
trigger3 = InGuardDist
trigger4 = MoveContact
trigger5 = P2MoveType = H
trigger6 = P2BodyDist X < 474


[State -1, rol]
type = ChangeState
value = 1200
triggerall = AILevel <= 0
triggerall = command = "rolling7"
triggerall = AILevel != 0
trigger1 = P2MoveType = A


[State -1, rol]
type = ChangeState
value = 1000
triggerall = AILevel <= 0
triggerall = command = "rolling1" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2BodyDist X >= 865
trigger4 = P2BodyDist Y <= 899
trigger5 = P2StateType = C
trigger6 = P2MoveType = A


[State -1, Air mk]
type = ChangeState
value = 640
triggerall = command = "b"
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 894
trigger2 = P2BodyDist Y < -262
trigger3 = P2MoveType = I
trigger4 = InGuardDist
trigger5 = MoveContact || MoveGuarded
trigger6 = P2StateType = S

;Air_sk

[State -1, rol]
type = ChangeState
value = 1020
triggerall = AILevel <= 0
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 598
trigger2 = P2StateType = A
trigger3 = MoveContact || MoveGuarded
trigger4 = InGuardDist


[State -1, Air sk]
type = ChangeState
value = 650
triggerall = command = "c"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 50
trigger2 = P2MoveType = H
trigger3 = MoveGuarded

[State -1, crouch mp]
type = ChangeState
value = 410
triggerall = AILevel <= 0
triggerall = command = "y" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2MoveType = I
trigger3 = MoveContact
trigger4 = P2BodyDist Y > 500




[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = AILevel <= 0
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2StateType = C
trigger3 = P2BodyDist Y < -165





[State -1, sm]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = InGuardDist
trigger3 = P2BodyDist X >= 758






[State -1, k]
type = ChangeState
value = 250
triggerall = AILevel <= 0
triggerall = command = "c" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 431






[State -1, p]
type = ChangeState
value = 220
triggerall = AILevel <= 0
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = H


[State -1, closefmp]
type = ChangeState
value = 260
triggerall = AILevel <= 0
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = C
trigger3 = P2MoveType = A



