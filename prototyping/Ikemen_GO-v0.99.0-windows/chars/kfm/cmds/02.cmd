
































































































































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
trigger1 = P2MoveType = I
trigger2 = MoveContact
trigger3 = P2BodyDist X > 492



[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = AILevel <= 0
triggerall = command = "b"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 787



[State -1, High Kung Fu Blocking Low]
type = ChangeState
value = 1320
triggerall = AILevel <= 0
triggerall = command = "blocking"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = P2MoveType = H
trigger4 = P2BodyDist X > 849
trigger5 = MoveContact || MoveGuarded
trigger6 = P2BodyDist Y < -771



[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 262
trigger2 = P2MoveType = H
trigger3 = P2StateType = S



[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = A



[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 561
trigger2 = P2MoveType = I
trigger3 = InGuardDist
trigger4 = MoveGuarded



[State -1, Combo condition Check]
type = VarSet
var(1) = 1
trigger1 = statetype != A
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = stateno != 440 
trigger2 = movecontact
trigger3 = stateno = 1310 || stateno = 1330 



[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = AILevel <= 0
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 271
trigger2 = P2MoveType = H



[State -1, Fast Kung Fu Upper]
type = ChangeState
value = 1120
triggerall = AILevel <= 0
triggerall = command = "upper_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2StateType = A
trigger3 = P2BodyDist X >= 749



[State -1, Standing Strong Kick]
type = ChangeState
value = 240
triggerall = AILevel <= 0
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = P2BodyDist Y <= 407
trigger3 = P2MoveType = I



[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = AILevel <= 0
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2BodyDist Y > -777
trigger4 = P2BodyDist X > 624



[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = AILevel <= 0
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2BodyDist Y > -777
trigger4 = P2BodyDist X > 624



[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = MoveGuarded
trigger3 = P2StateType = C

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Light Kung Fu Palm]
type = ChangeState
value = 1000
triggerall = AILevel <= 0
triggerall = command = "QCF_x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 86
trigger2 = P2BodyDist Y > 568



[State -1, Fast Kung Fu Blow]
type = ChangeState
value = 1220
triggerall = AILevel <= 0
triggerall = command = "QCB_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = MoveGuarded



[State -1, Smash Kung Fu Upper]
type = ChangeState
value = 3050
triggerall = AILevel <= 0
triggerall = command = "SmashKFUpper"
triggerall = power >= 1000
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y > 905
trigger3 = P2StateType = C
trigger4 = P2BodyDist X <= 361



[State -1, Strong Kung Fu Knee]
type = ChangeState
value = 1060
triggerall = AILevel <= 0
triggerall = command = "FF_b"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= -737
trigger2 = P2BodyDist X > 288
trigger3 = P2MoveType = I
trigger4 = P2StateType = S
trigger5 = InGuardDist
trigger6 = MoveGuarded



[State -1, Light Kung Fu Knee]
type = ChangeState
value = 1050
triggerall = AILevel <= 0
triggerall = command = "FF_a"
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 311
trigger2 = P2BodyDist Y >= -143
trigger3 = P2MoveType = I



[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2BodyDist Y <= 111
trigger3 = InGuardDist
trigger4 = P2BodyDist X > 680
trigger5 = P2StateType = A
trigger6 = P2MoveType = I



[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = AILevel <= 0
triggerall = command = "x"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = H
trigger3 = MoveContact || MoveGuarded
trigger4 = P2StateType = C



[State -1, Light Kung Fu Blow]
type = ChangeState
value = 1200
triggerall = AILevel <= 0
triggerall = command = "QCB_x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 852



[State -1, Kung Fu Throw]
type = ChangeState
value = 800
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 40
trigger2 = P2StateType = A
trigger3 = InGuardDist






[State -1, Far Kung Fu Zankou]
type = ChangeState
value = 1420
triggerall = AILevel <= 0
triggerall = command = "QCF_ab"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = P2StateType = S
trigger2 = P2MoveType = A
trigger3 = P2BodyDist X >= 648



[State -1, High Kung Fu Blocking Low]
type = ChangeState
value = 1320
triggerall = AILevel <= 0
triggerall = command = "blocking"
triggerall = command = "holddown"
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2StateType = S
trigger3 = InGuardDist
trigger4 = MoveContact || MoveGuarded



[State -1, Fast Kung Fu Palm]
type = ChangeState
value = 1020
triggerall = AILevel <= 0
triggerall = command = "QCF_xy"
triggerall = power >= 330
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = A
trigger3 = P2StateType = C
trigger4 = P2BodyDist Y >= 760



[State -1, Strong Kung Fu Zankou]
type = ChangeState
value = 1410
triggerall = AILevel <= 0
triggerall = command = "QCF_b"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -185
trigger2 = P2StateType = S
trigger3 = P2MoveType = H
trigger4 = InGuardDist
trigger5 = P2BodyDist X <= 853
trigger6 = MoveContact




[State -1, Run Back]
type = ChangeState
value = 105
triggerall = AILevel <= 0
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 198
trigger2 = P2MoveType = A
trigger3 = P2BodyDist Y < 353



[State -1, Kung Fu Throw]
type = ChangeState
value = 800
triggerall = AILevel <= 0
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
triggerall = AILevel != 0
trigger1 = P2BodyDist X >= 40
trigger2 = P2StateType = A
trigger3 = InGuardDist






[State -1, Triple Kung Fu Palm]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = command = "TripleKFPalm"
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = H







[State -1, Combo condition Reset]
type = VarSet
var(1) = 0
trigger1 = 1

[State -1, Run Back]
type = ChangeState
value = 105
triggerall = AILevel <= 0
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = InGuardDist
trigger3 = P2MoveType = A
trigger4 = P2StateType = A
trigger5 = P2BodyDist Y > -96
trigger6 = P2BodyDist X < 104



[State -1, Triple Kung Fu Palm]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = command = "TripleKFPalm"
triggerall = power >= 1000
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded







[State -1, High Kung Fu Blocking Low]
type = ChangeState
value = 1340
triggerall = AILevel <= 0
triggerall = command = "blocking"
triggerall = command != "holdup"
triggerall = command != "holddown"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 457
trigger2 = MoveGuarded
trigger3 = P2BodyDist Y >= 460
trigger4 = P2StateType = C
trigger5 = InGuardDist



[State -1, Light Kung Fu Upper]
type = ChangeState
value = 1100
triggerall = AILevel <= 0
triggerall = command = "upper_x"
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 926
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2BodyDist Y <= 837
trigger5 = P2StateType = A



[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 997
trigger2 = MoveGuarded



[State -1, Strong Kung Fu Upper]
type = ChangeState
value = 1110
triggerall = AILevel <= 0
triggerall = command = "upper_y"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= 199
trigger2 = MoveContact
trigger3 = P2BodyDist X < 731
trigger4 = InGuardDist
trigger5 = P2StateType = C



[State -1, Strong Kung Fu Zankou]
type = ChangeState
value = 1410
triggerall = AILevel <= 0
triggerall = command = "QCF_b"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 966
trigger2 = MoveGuarded
trigger3 = InGuardDist




[State -1, Light Kung Fu Zankou]
type = ChangeState
value = 1400
triggerall = AILevel <= 0
triggerall = command = "QCF_a"
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 453



