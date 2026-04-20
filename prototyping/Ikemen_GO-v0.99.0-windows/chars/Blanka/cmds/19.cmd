


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


[State -1, close mk]
type = ChangeState
value = 241
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 301
trigger2 = P2BodyDist Y > 228




[State -1, sm]
type = ChangeState
value = 3000
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = P2MoveType = H






[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 610
trigger2 = InGuardDist
trigger3 = P2StateType = A
trigger4 = P2MoveType = A
trigger5 = MoveGuarded
trigger6 = P2BodyDist Y < -604





[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = I
trigger3 = P2BodyDist Y < -563
trigger4 = MoveContact
trigger5 = P2StateType = C



[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 240
trigger2 = P2StateType = S
trigger3 = InGuardDist
trigger4 = P2BodyDist X > 524


[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = InGuardDist
trigger3 = P2MoveType = H


[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = P2MoveType = A




[State -1, Air sp]
type = ChangeState
value = 620
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2BodyDist X < 414

;Air_lk

[State -1, k]
type = ChangeState
value = 250
triggerall = command = "c" && command != "holddown"
triggerall = AILevel != 0
trigger1 = MoveContact






[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = InGuardDist
trigger3 = P2MoveType = H


[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = InGuardDist



[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 91


[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 141


[State -1, crouch lk]
type = ChangeState
value = 430
triggerall = command = "a" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 231
trigger2 = InGuardDist
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = I



[State -1, Air sk]
type = ChangeState
value = 650
triggerall = command = "c"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = InGuardDist

[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 63
trigger2 = P2MoveType = A
trigger3 = P2StateType = A
trigger4 = P2BodyDist Y <= -508
trigger5 = InGuardDist
trigger6 = MoveContact || MoveGuarded



[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 607
trigger2 = MoveGuarded


[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2StateType = S
trigger3 = P2BodyDist Y > -330
trigger4 = P2MoveType = I


[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 607
trigger2 = MoveGuarded


[State -1, k]
type = ChangeState
value = 230
triggerall = command = "a" && command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = C
trigger3 = P2MoveType = I


[State -1, rol]
type = ChangeState
value = 1200
triggerall = command = "rolling7"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 98
trigger2 = P2MoveType = A
trigger3 = InGuardDist


[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 448
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = InGuardDist
trigger5 = P2StateType = S


[State -1, Air sk]
type = ChangeState
value = 650
triggerall = command = "c"
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 301
trigger2 = MoveContact
trigger3 = P2MoveType = H
trigger4 = P2BodyDist Y > -589
trigger5 = P2StateType = A

[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2StateType = C
trigger3 = P2MoveType = I




[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X > 51



[State -1, close fdmp]
type = ChangeState
value = 270
triggerall = command = "z" 
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = I
trigger3 = P2StateType = S



[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist



[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = InGuardDist



[State -1, close mk]
type = ChangeState
value = 241
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = A
trigger3 = P2MoveType = H




[State -1, Air lk]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 556
trigger2 = P2MoveType = H

;Air_mk

[State -1, k]
type = ChangeState
value = 240
triggerall = command = "b" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y < 363
trigger3 = MoveContact || MoveGuarded


[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2StateType = S
trigger3 = P2BodyDist Y > -330
trigger4 = P2MoveType = I


[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > -594
trigger2 = P2MoveType = I
trigger3 = P2BodyDist X < 322
trigger4 = InGuardDist






[State -1, rol]
type = ChangeState
value = 1010
triggerall = command = "rolling2" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y >= -36
trigger3 = InGuardDist
trigger4 = P2BodyDist X <= 472
trigger5 = P2StateType = C
trigger6 = MoveGuarded


[State -1, throw]
type = ChangeState
value = 800
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = A
trigger4 = P2BodyDist Y < 452
trigger5 = P2BodyDist X > 427
trigger6 = P2StateType = C



[State -1, rol]
type = ChangeState
value = 1000
triggerall = command = "rolling1" && statetype != A
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2MoveType = I
trigger3 = P2BodyDist Y >= -370
trigger4 = P2BodyDist X <= 188
trigger5 = InGuardDist


[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = InGuardDist
trigger3 = P2MoveType = H


