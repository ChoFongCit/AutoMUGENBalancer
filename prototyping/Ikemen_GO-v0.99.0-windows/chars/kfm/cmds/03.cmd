
































































































































[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s


[Defaults]

command.time = 15



command.buffer.time = 1








[Command]
name = "TripleKFPalm"
command = ~D, DF, F, D, DF, F, x
time = 20

[Command]
name = "TripleKFPalm"   
command = ~D, DF, F, D, DF, F, y
time = 20

[Command]
name = "SmashKFUpper"
command = ~D, DB, B, D, DB, B, x
time = 20

[Command]
name = "SmashKFUpper"   
command = ~D, DB, B, D, DB, B, y
time = 20


[Command]
name = "blocking"
command = $F,x
time = 3

[Command]
name = "blocking" 
command = x,$F
time = 3

[Command]
name = "upper_x"
command = ~F, D, DF, x

[Command]
name = "upper_y"
command = ~F, D, DF, y

[Command]
name = "upper_xy"
command = ~F, D, DF, x+y

[Command]
name = "QCF_x"
command = ~D, DF, F, x

[Command]
name = "QCF_y"
command = ~D, DF, F, y

[Command]
name = "QCF_xy"
command = ~D, DF, F, x+y

[Command]
name = "QCB_x"
command = ~D, DB, B, x

[Command]
name = "QCB_y"
command = ~D, DB, B, y

[Command]
name = "QCB_xy"
command = ~D, DB, B, x+y

[Command]
name = "QCF_a"
command = ~D, DF, F, a

[Command]
name = "QCF_b"
command = ~D, DF, F, b

[Command]
name = "QCF_ab"
command = ~D, DF, F, a+b

[Command]
name = "FF_ab"
command = F, F, a+b

[Command]
name = "FF_a"
command = F, F, a

[Command]
name = "FF_b"
command = F, F, b


[Command]
name = "FF"     
command = F, F
time = 10

[Command]
name = "BB"     
command = B, B
time = 10


[Command]
name = "recovery"
command = x+y
time = 1


[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
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
name = "start"
command = s
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




[State -1, Light Kung Fu Knee]
type = ChangeState
value = 1050
triggerall = AILevel <= 0
triggerall = command = "FF_a"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = H
trigger3 = P2StateType = S
trigger4 = P2BodyDist X > 725



[State -1, Strong Kung Fu Palm]
type = ChangeState
value = 1010
triggerall = AILevel <= 0
triggerall = command = "QCF_y"
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2BodyDist Y > -874



[State -1, Light Kung Fu Blow]
type = ChangeState
value = 1200
triggerall = AILevel <= 0
triggerall = command = "QCB_x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 10
trigger2 = P2BodyDist Y < -147
trigger3 = InGuardDist
trigger4 = P2StateType = A



[State -1, Kung Fu Throw]
type = ChangeState
value = 800
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = A
trigger3 = P2MoveType = H
trigger4 = P2BodyDist Y < 266
trigger5 = MoveContact






[State -1, Run Fwd]
type = ChangeState
value = 100
triggerall = AILevel <= 0
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist X <= 828
trigger3 = P2BodyDist Y < -174
trigger4 = P2StateType = C
trigger5 = MoveGuarded
trigger6 = InGuardDist



[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = AILevel <= 0
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = MoveContact
trigger3 = P2BodyDist Y <= -476



[State -1, Jump Strong Kick]
type = ChangeState
value = 640
triggerall = command = "b"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = InGuardDist
[State -1, Combo condition Reset]
type = VarSet
var(1) = 0
trigger1 = 1

[State -1, Light Kung Fu Zankou]
type = ChangeState
value = 1400
triggerall = AILevel <= 0
triggerall = command = "QCF_a"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = MoveContact
trigger3 = P2BodyDist X < 715
trigger4 = P2MoveType = H



[State -1, Smash Kung Fu Upper]
type = ChangeState
value = 3050
triggerall = AILevel <= 0
triggerall = command = "SmashKFUpper"
triggerall = power >= 1000
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = MoveGuarded
trigger3 = InGuardDist
trigger4 = P2BodyDist Y > -370
trigger5 = P2BodyDist X >= 977



[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = AILevel <= 0
triggerall = command = "a"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2StateType = S
trigger3 = InGuardDist
trigger4 = P2BodyDist X <= 666



[State -1, High Kung Fu Blocking Low]
type = ChangeState
value = 1340
triggerall = AILevel <= 0
triggerall = command = "blocking"
triggerall = command != "holdup"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2MoveType = I



[State -1, Strong Kung Fu Zankou]
type = ChangeState
value = 1410
triggerall = AILevel <= 0
triggerall = command = "QCF_b"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist X > 46
trigger3 = P2StateType = C




[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2StateType = A
trigger3 = P2BodyDist X < 350
trigger4 = MoveContact
trigger5 = InGuardDist



[State -1, Strong Kung Fu Blow]
type = ChangeState
value = 1210
triggerall = AILevel <= 0
triggerall = command = "QCB_y"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < -123
trigger2 = MoveContact || MoveGuarded
trigger3 = P2StateType = S
trigger4 = InGuardDist



[State -1, Fast Kung Fu Knee]
type = ChangeState
value = 1070
triggerall = AILevel <= 0
triggerall = command = "FF_ab"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2StateType = S
trigger3 = P2MoveType = A



[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 583
trigger2 = MoveContact
trigger3 = InGuardDist
trigger4 = P2StateType = S
trigger5 = P2BodyDist X < 51

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Fast Kung Fu Blow]
type = ChangeState
value = 1220
triggerall = AILevel <= 0
triggerall = command = "QCB_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist Y < 184



[State -1, Far Kung Fu Zankou]
type = ChangeState
value = 1420
triggerall = AILevel <= 0
triggerall = command = "QCF_ab"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = P2MoveType = A
trigger3 = MoveContact
trigger4 = InGuardDist
trigger5 = P2BodyDist X >= 770
trigger6 = P2BodyDist Y < 928



[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = AILevel <= 0
triggerall = command = "b"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = I
trigger3 = MoveContact || MoveGuarded
trigger4 = P2BodyDist Y > -6



[State -1, Triple Kung Fu Palm]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = command = "TripleKFPalm"
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2StateType = A
trigger3 = MoveContact
trigger4 = P2BodyDist X <= 395
trigger5 = P2BodyDist Y <= -336







[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 26



[State -1, Strong Kung Fu Upper]
type = ChangeState
value = 1110
triggerall = AILevel <= 0
triggerall = command = "upper_y"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X < 24
trigger3 = MoveGuarded
trigger4 = P2BodyDist Y > -887
trigger5 = P2StateType = C



[State -1, High Kung Fu Blocking Low]
type = ChangeState
value = 1320
triggerall = AILevel <= 0
triggerall = command = "blocking"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X > 17



[State -1, Standing Strong Kick]
type = ChangeState
value = 240
triggerall = AILevel <= 0
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X < 360
trigger3 = P2MoveType = A



[State -1, Fast Kung Fu Palm]
type = ChangeState
value = 1020
triggerall = AILevel <= 0
triggerall = command = "QCF_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist X >= 488
trigger3 = InGuardDist
trigger4 = MoveGuarded



[State -1, Light Kung Fu Upper]
type = ChangeState
value = 1100
triggerall = AILevel <= 0
triggerall = command = "upper_x"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -284
trigger2 = InGuardDist
trigger3 = P2BodyDist X > 910
trigger4 = P2StateType = C



[State -1, Combo condition Check]
type = VarSet
var(1) = 1
trigger1 = statetype != A
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = stateno != 440 
trigger2 = movecontact
trigger3 = stateno = 1310 || stateno = 1330 



[State -1, Strong Kung Fu Knee]
type = ChangeState
value = 1060
triggerall = AILevel <= 0
triggerall = command = "FF_b"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X < 70
trigger3 = P2BodyDist Y <= -16



[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = P2BodyDist Y <= 259
trigger4 = MoveGuarded
trigger5 = P2MoveType = I
trigger6 = P2BodyDist X > 242



[State -1, Run Back]
type = ChangeState
value = 105
triggerall = AILevel <= 0
triggerall = AILevel != 0
trigger1 = P2MoveType = I



[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y > -136
trigger3 = P2BodyDist X >= 644
trigger4 = P2MoveType = H
trigger5 = P2StateType = S

;---------------------------------------------------------------------------
;Jump Light Kick
[State -1, High Kung Fu Blocking High]
type = ChangeState
value = 1300
triggerall = command = "blocking"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > -71
trigger2 = MoveGuarded
trigger3 = P2BodyDist X > 849
trigger4 = P2StateType = A



[State -1, Light Kung Fu Palm]
type = ChangeState
value = 1000
triggerall = AILevel <= 0
triggerall = command = "QCF_x"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2MoveType = H
trigger3 = InGuardDist
trigger4 = P2BodyDist Y > 96
trigger5 = MoveContact || MoveGuarded
trigger6 = P2BodyDist X > 715



[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist Y <= 263



[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = A
trigger3 = P2BodyDist X < 505



[State -1, Fast Kung Fu Upper]
type = ChangeState
value = 1120
triggerall = AILevel <= 0
triggerall = command = "upper_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = P2StateType = S



[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 849



