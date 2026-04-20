


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


[State -1, sm]
type = ChangeState
value = 3000
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist X <= 13
trigger3 = P2BodyDist Y > 88
trigger4 = InGuardDist






[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 589
trigger2 = P2BodyDist X > 495
trigger3 = InGuardDist
trigger4 = P2StateType = C
trigger5 = P2MoveType = A



[State -1, close fdmp]
type = ChangeState
value = 270
triggerall = command = "z" 
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 444



[State -1, rol]
type = ChangeState
value = 1000
triggerall = command = "rolling1" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 13
trigger2 = P2StateType = A
trigger3 = InGuardDist


[State -1, crouch lk]
type = ChangeState
value = 430
triggerall = command = "a" && command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y > -386
trigger3 = P2BodyDist X >= 44
trigger4 = MoveContact || MoveGuarded
trigger5 = P2MoveType = A



[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 329
trigger2 = P2StateType = C
trigger3 = P2BodyDist X >= 490
trigger4 = P2MoveType = A


[State -1, p]
type = ChangeState
value = 210
triggerall = command = "y" && command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = MoveContact
trigger4 = P2BodyDist Y >= -470
trigger5 = P2MoveType = A
trigger6 = P2BodyDist X >= 66


[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -395
trigger2 = InGuardDist
trigger3 = MoveContact
trigger4 = P2BodyDist X < 471


[State -1, p]
type = ChangeState
value = 220
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X > 173
trigger3 = P2BodyDist Y > 463
trigger4 = MoveContact || MoveGuarded
trigger5 = InGuardDist
trigger6 = P2MoveType = I


[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = H
trigger3 = MoveGuarded


[State -1, Air sp]
type = ChangeState
value = 620
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2StateType = C
trigger3 = P2BodyDist X > 439
trigger4 = MoveContact
trigger5 = P2BodyDist Y <= -450
trigger6 = InGuardDist

;Air_lk

[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact || MoveGuarded
trigger3 = P2BodyDist X >= 544



[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = A






[State -1, close mp]
type = ChangeState
value = 211
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = InGuardDist
trigger3 = P2StateType = C



[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 367




[State -1, k]
type = ChangeState
value = 230
triggerall = command = "a" && command != "holddown"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = InGuardDist


[State -1, k]
type = ChangeState
value = 240
triggerall = command = "b" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 627
trigger2 = P2BodyDist X >= 61


[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2StateType = A
trigger3 = MoveGuarded
trigger4 = P2BodyDist Y >= -352
trigger5 = P2BodyDist X < 558





[State -1, k]
type = ChangeState
value = 250
triggerall = command = "c" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X <= 424
trigger3 = InGuardDist






[State -1, crouch mp]
type = ChangeState
value = 410
triggerall = command = "y" && command = "holddown"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X < 515




[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -310
trigger2 = InGuardDist
trigger3 = P2MoveType = A



[State -1, throw]
type = ChangeState
value = 800
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2StateType = A
trigger3 = InGuardDist



[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist


[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X > 475
trigger3 = P2StateType = A



[State -1, Air mk]
type = ChangeState
value = 640
triggerall = command = "b"
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist Y > 576
trigger3 = InGuardDist
trigger4 = P2StateType = A

;Air_sk

[State -1, rol]
type = ChangeState
value = 1200
triggerall = command = "rolling7"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 246
trigger2 = InGuardDist
trigger3 = P2BodyDist X > 189
trigger4 = P2StateType = C
trigger5 = MoveContact || MoveGuarded
trigger6 = P2MoveType = H


[State -1, crouch mk]
type = ChangeState
value = 440
triggerall = command = "b" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist Y <= 263
trigger3 = P2BodyDist X < 621
trigger4 = InGuardDist
trigger5 = MoveContact



[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 299
trigger2 = MoveContact
trigger3 = InGuardDist



[State -1, Air sp]
type = ChangeState
value = 621
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist X > 386



[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2StateType = A
trigger3 = InGuardDist
trigger4 = P2MoveType = H



[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -326
trigger2 = P2MoveType = H
trigger3 = P2BodyDist X <= 208


[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = InGuardDist


[State -1, close mk]
type = ChangeState
value = 241
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 59
trigger2 = P2StateType = S
trigger3 = InGuardDist
trigger4 = P2MoveType = H




[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveGuarded
trigger3 = P2BodyDist Y <= 278
trigger4 = P2StateType = A
trigger5 = P2MoveType = H



[State -1, rol]
type = ChangeState
value = 1220
triggerall = command = "rolling9"
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2MoveType = I
trigger3 = InGuardDist
trigger4 = P2StateType = A
trigger5 = P2BodyDist Y >= -217


[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = InGuardDist
trigger3 = P2MoveType = A





[State -1, Air sk]
type = ChangeState
value = 650
triggerall = command = "c"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -591
trigger2 = MoveContact
trigger3 = P2StateType = C

