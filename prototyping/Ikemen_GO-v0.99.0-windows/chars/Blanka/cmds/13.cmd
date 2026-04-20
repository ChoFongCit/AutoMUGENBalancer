


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


[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y > 17
trigger3 = P2BodyDist X <= 617
trigger4 = MoveContact || MoveGuarded
trigger5 = P2StateType = C






[State -1, close mk]
type = ChangeState
value = 241
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -549




[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 269
trigger2 = P2MoveType = H
trigger3 = P2StateType = S
trigger4 = P2BodyDist X > 225
trigger5 = InGuardDist
trigger6 = MoveGuarded



[State -1, throw]
type = ChangeState
value = 800
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > -298
trigger2 = P2MoveType = A
trigger3 = P2BodyDist X > 356
trigger4 = MoveContact || MoveGuarded



[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X <= 282
trigger3 = P2MoveType = I


[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 392





[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 445
trigger2 = P2MoveType = H
trigger3 = P2StateType = S
trigger4 = MoveGuarded
trigger5 = InGuardDist
trigger6 = P2BodyDist X < 431


[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = MoveContact || MoveGuarded
trigger3 = P2BodyDist Y < 602
trigger4 = InGuardDist
trigger5 = P2MoveType = H
trigger6 = P2BodyDist X > 549



[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
triggerall = AILevel != 0
trigger1 = InGuardDist



[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 269
trigger2 = P2MoveType = H
trigger3 = P2StateType = S
trigger4 = P2BodyDist X > 225
trigger5 = InGuardDist
trigger6 = MoveGuarded



[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 392





[State -1, Air sp]
type = ChangeState
value = 621
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y >= 63
trigger3 = P2BodyDist X < 629
trigger4 = MoveGuarded
trigger5 = P2MoveType = A



[State -1, Air sp]
type = ChangeState
value = 620
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2MoveType = A

;Air_lk

[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 164






[State -1, rol]
type = ChangeState
value = 1010
triggerall = command = "rolling2" && statetype != A
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X >= 101
trigger3 = MoveContact


[State -1, k]
type = ChangeState
value = 230
triggerall = command = "a" && command != "holddown"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2MoveType = H
trigger3 = P2BodyDist Y <= -102
trigger4 = InGuardDist
trigger5 = P2BodyDist X > 227
trigger6 = P2StateType = C


[State -1, crouch mp]
type = ChangeState
value = 410
triggerall = command = "y" && command = "holddown"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist Y < -587
trigger3 = P2BodyDist X >= 227
trigger4 = InGuardDist




[State -1, p]
type = ChangeState
value = 220
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -127
trigger2 = MoveGuarded
trigger3 = P2MoveType = H
trigger4 = InGuardDist
trigger5 = P2StateType = C


[State -1, Air lk]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist Y > 640

;Air_mk

[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 273
trigger2 = InGuardDist
trigger3 = P2BodyDist X >= 601
trigger4 = P2StateType = A



[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 164






[State -1, p]
type = ChangeState
value = 220
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 262
trigger2 = P2MoveType = H


[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X <= 282
trigger3 = P2MoveType = I


[State -1, Air sp]
type = ChangeState
value = 621
triggerall = command = "z"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -178
trigger2 = P2MoveType = H
trigger3 = P2BodyDist X <= 523



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
value = 220
triggerall = command = "z" && command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -127
trigger2 = MoveGuarded
trigger3 = P2MoveType = H
trigger4 = InGuardDist
trigger5 = P2StateType = C


[State -1, rol]
type = ChangeState
value = 1000
triggerall = command = "rolling1" && statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2StateType = S
trigger3 = InGuardDist


[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 392





[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X >= 139
trigger3 = InGuardDist
trigger4 = P2BodyDist Y <= 237
trigger5 = P2MoveType = A



[State -1, close mp]
type = ChangeState
value = 211
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 617
trigger2 = P2MoveType = I
trigger3 = InGuardDist
trigger4 = P2StateType = A
trigger5 = P2BodyDist Y >= -525



[State -1, close mp]
type = ChangeState
value = 211
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2StateType = C



[State -1, Air mk]
type = ChangeState
value = 640
triggerall = command = "b"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -516
trigger2 = P2BodyDist X < 19
trigger3 = P2MoveType = A
trigger4 = MoveGuarded
trigger5 = P2StateType = C
trigger6 = InGuardDist

;Air_sk

[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = MoveContact || MoveGuarded
trigger3 = P2BodyDist Y < 602
trigger4 = InGuardDist
trigger5 = P2MoveType = H
trigger6 = P2BodyDist X > 549



[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist Y > 43
trigger3 = P2StateType = S
trigger4 = P2MoveType = A
trigger5 = P2BodyDist X <= 368
trigger6 = InGuardDist



[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2StateType = S
trigger3 = P2MoveType = A
trigger4 = P2BodyDist Y <= 25




[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X <= 282
trigger3 = P2MoveType = I


[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 273
trigger2 = InGuardDist
trigger3 = P2BodyDist X >= 601
trigger4 = P2StateType = A



