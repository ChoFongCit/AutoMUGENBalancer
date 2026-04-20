


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
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = MoveGuarded


[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = InGuardDist
trigger3 = MoveContact
trigger4 = P2BodyDist Y <= -336
trigger5 = P2BodyDist X <= 95




[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 290
trigger2 = P2MoveType = I
trigger3 = InGuardDist


[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 32



[State -1, Air lk]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 556
trigger2 = P2MoveType = H

;Air_mk

[State -1, close mp]
type = ChangeState
value = 211
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist X >= 79



[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = MoveGuarded


[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = P2MoveType = A




[State -1, p]
type = ChangeState
value = 210
triggerall = command = "y" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 608
trigger2 = P2BodyDist Y < 75
trigger3 = InGuardDist


[State -1, k]
type = ChangeState
value = 250
triggerall = command = "c" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -135
trigger2 = InGuardDist
trigger3 = P2BodyDist X < 486
trigger4 = P2MoveType = A
trigger5 = P2StateType = C






[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -538
trigger2 = P2BodyDist X < 471
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = H


[State -1, rol]
type = ChangeState
value = 1000
triggerall = command = "rolling1" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = P2BodyDist Y >= -277
trigger4 = P2BodyDist X <= 403
trigger5 = P2MoveType = H


[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X < 50
trigger3 = MoveContact || MoveGuarded



[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = I
trigger3 = P2StateType = A
trigger4 = MoveGuarded



[State -1, rol]
type = ChangeState
value = 1010
triggerall = command = "rolling2" && statetype != A
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X >= 101
trigger3 = MoveContact


[State -1, sm]
type = ChangeState
value = 3000
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist Y < -35
trigger3 = P2StateType = S
trigger4 = P2BodyDist X < 259
trigger5 = MoveContact || MoveGuarded






[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y <= -218



[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = InGuardDist
trigger3 = P2MoveType = H


[State -1, k]
type = ChangeState
value = 240
triggerall = command = "b" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y < 363
trigger3 = MoveContact || MoveGuarded


[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -326
trigger2 = P2MoveType = H
trigger3 = P2BodyDist X <= 208


[State -1, rol]
type = ChangeState
value = 1200
triggerall = command = "rolling7"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2StateType = C
trigger5 = P2BodyDist X < 519
trigger6 = P2BodyDist Y < 428


[State -1, p]
type = ChangeState
value = 220
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = A


[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = MoveContact
trigger3 = InGuardDist
trigger4 = P2BodyDist X > 281
trigger5 = P2BodyDist Y <= 592
trigger6 = P2StateType = A



[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = InGuardDist


[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2MoveType = I
trigger3 = P2BodyDist X <= 424
trigger4 = InGuardDist




[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X > 589
trigger3 = MoveGuarded


[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X <= 275


[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2BodyDist Y >= 580
trigger4 = P2BodyDist X < 486




[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist Y < -289
trigger3 = P2BodyDist X >= 0
trigger4 = MoveContact



[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = MoveContact
trigger3 = P2StateType = C
trigger4 = P2BodyDist Y > -172



[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 20
trigger2 = P2BodyDist X < 556
trigger3 = MoveContact || MoveGuarded



[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2StateType = C
trigger3 = InGuardDist
trigger4 = MoveContact || MoveGuarded
trigger5 = P2BodyDist X <= 380


[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 91


[State -1, crouch mk]
type = ChangeState
value = 440
triggerall = command = "b" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = S



[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist Y > -292
trigger3 = P2StateType = S



[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > -438
trigger2 = P2StateType = A



[State -1, close fdmp]
type = ChangeState
value = 270
triggerall = command = "z" 
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -55
trigger2 = P2BodyDist X < 209
trigger3 = InGuardDist



