

















                   
                   
                   


                         
                         
                         
                         
                         














































































































[Command]
name = "spin1"
command = ~D, DF, F, D, DF, a
time = 23

[Command]
name = "spin1"
command = ~D, DF, F, D, DF, ~a
time = 23

[Command]
name = "spin2"
command = ~D, DF, F, D, DF, b
time = 23

[Command]
name = "spin2"
command = ~D, DF, F, D, DF, ~b
time = 23

[Command]
name = "spin3"
command = ~D, DF, F, D, DF, c
time = 23

[Command]
name = "spin3"
command = ~D, DF, F, D, DF, ~c
time = 23



[Command]
name = "hooligan1"
command = ~DB, D, DF, F, UF, x
time = 12

[Command]
name = "hooligan1"
command = ~DB, D, DF, F, UF, ~x
time = 12

[Command]
name = "hooligan2"
command = ~DB, D, DF, F, UF, y
time = 12

[Command]
name = "hooligan2"
command = ~DB, D, DF, F, UF, ~y
time = 12

[Command]
name = "hooligan3"
command = ~DB, D, DF, F, UF, z
time = 12

[Command]
name = "hooligan3"
command = ~DB, D, DF, F, UF, ~z
time = 12

[Command]
name = "accel1"
command = ~B, DB, F, x
time = 12

[Command]
name = "accel1"
command = ~B, DB, F, ~x
time = 12

[Command]
name = "accel2"
command = ~B, DB, F, y
time = 12

[Command]
name = "accel2"
command = ~B, DB, F, ~y
time = 12

[Command]
name = "accel3"
command = ~B, DB, F, z
time = 12

[Command]
name = "accel3"
command = ~B, DB, F, ~z
time = 12

[Command]
name = "cannon1"
command = ~F, D, DF, a
time = 12

[Command]
name = "cannon1"
command = ~F, D, DF, ~a
time = 12

[Command]
name = "cannon2"
command = ~F, D, DF, b
time = 12

[Command]
name = "cannon2"
command = ~F, D, DF, ~b
time = 12

[Command]
name = "cannon3"
command = ~F, D, DF, c
time = 12

[Command]
name = "cannon3"
command = ~F, D, DF, ~c
time = 12

[Command]
name = "spiral1"
command = ~D, DF, F, a
time = 12

[Command]
name = "spiral1"
command = ~D, DF, F, ~a
time = 12

[Command]
name = "spiral2"
command = ~D, DF, F, b
time = 12

[Command]
name = "spiral2"
command = ~D, DF, F, ~b
time = 12

[Command]
name = "spiral3"
command = ~D, DF, F, c
time = 12

[Command]
name = "spiral3"
command = ~D, DF, F, ~c
time = 12




[Command]
name = "FF"       
command = F, F
time = 12

[Command]
name = "BB"       
command = B, B
time = 12




[Command]
name = "recovery" 
command = x+a
time = 11

[Command]
name = "y+b"
command = y+b
time = 11

[Command]
name = "z+c"
command = z+c
time = 11

[Command]
name = "x+y"
command = x+y
time = 11

[Command]
name = "x+z"
command = x+z
time = 11

[Command]
name = "y+z"
command = y+z
time = 11

[Command]
name = "a+b"
command = a+b
time = 11

[Command]
name = "a+c"
command = a+c
time = 11

[Command]
name = "b+c"
command = b+c
time = 11




[command]
name = "fwd"
command = F
time = 1

[command]
name = "back"
command = B
time = 1

[command]
name = "up"
command = U
time = 1

[command]
name = "down"
command = D
time=1

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
name = "hold_a"
command = /a
time = 1

[Command]
name = "hold_b"
command = /b
time = 1

[Command]
name = "hold_c"
command = /c
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

[State 100]
type = VarSet
triggerall = time = 2
trigger1 = stateno != 52
var(11) = 0

[State 100]
type = VarSet
triggerall = Command = "x" || Command = "y" || Command = "z"
trigger1 = (stateno = [200,330])
trigger1 = animtime = [ifelse((var(3)=[1,2]),-4,-2),0]
trigger2 = stateno = [350,420]
trigger2 = Pos Y >= -55
var(11) = ifelse(Command = "x", 4, ifelse(Command = "y", 5, 6))
ignorehitpause = 1

[State 100]
type = VarSet
triggerall = Command = "a" || Command = "b" || Command = "c"
trigger1 = (stateno = [200,330])
trigger1 = animtime = [ifelse((var(3)=[1,2]),-4,-2),0]
trigger2 = stateno = [350,420]
trigger2 = Pos Y >= -55
var(11) = ifelse(Command = "a", 1, ifelse(Command = "b", 2, 3))
ignorehitpause = 1

[State 100]
type = VarSet
triggerall = Command = "x"
triggerall = stateno = 300
trigger1 = var(3) = [1,2]
trigger1 = HitPauseTime = [1,6]
var(11) = 4
ignorehitpause = 1

[State 100]
type = VarSet
triggerall = Command = "a"
triggerall = stateno = 320
trigger1 = time > 4
trigger2 = var(3) = [1,2]
trigger2 = HitPauseTime = [1,6]
var(11) = 1
ignorehitpause = 1

[State 100]
type = VarSet
trigger1 = var(11)
trigger1 = Command = "holdback" && Command != "holdup"
trigger1 = InGuardDist
var(11) = 0
ignorehitpause = 1



[State -1, 斜めジャンプ中パンチ]
type = null
value = 420
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 349
trigger2 = P2MoveType = A
trigger3 = MoveContact
trigger4 = InGuardDist
ignorehitpause = 0


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2MoveType = I
trigger3 = P2StateType = S
ignorehitpause = 0


[State -1]
type = ChangeState
value = 3000
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "spin1" || Command = "spin2" || Command = "spin3") ||Command = "recovery"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist X <= 426
ignorehitpause = 0



[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 630
trigger2 = P2BodyDist Y >= 308
trigger3 = P2MoveType = I
trigger4 = MoveContact
trigger5 = P2StateType = C
ignorehitpause = 0


[State -1]
type = ChangeState
value = 3000
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "spin1" || Command = "spin2" || Command = "spin3") ||Command = "recovery"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 115
ignorehitpause = 0



[State -1, 遠距離立ち強キック]
type = ChangeState
value = 270
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -461
trigger2 = InGuardDist
trigger3 = P2MoveType = A
trigger4 = P2StateType = S
trigger5 = MoveContact
ignorehitpause = 0



[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist
trigger3 = MoveGuarded
trigger4 = P2StateType = S
trigger5 = P2BodyDist Y <= -592
ignorehitpause = 0


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= 71
ignorehitpause = 0


[State -1, しゃがみ弱パンチ]
type = ChangeState
value = 300
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = A
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1100
triggerall = roundstate = 2
triggerall = Command = "cannon1" || Command = "cannon2" || Command = "cannon3"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y > -228
trigger3 = P2StateType = A
trigger4 = P2BodyDist X >= 101
trigger5 = P2MoveType = H
trigger6 = MoveContact || MoveGuarded
ignorehitpause = 0



[State -1, ジャンプ弱パンチ]
type = ChangeState
value = 350
triggerall = roundstate = 2
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2StateType = C
ignorehitpause = 0


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2BodyDist X <= 256
trigger5 = P2StateType = S
ignorehitpause = 0


[State -1, 垂直ジャンプ弱キック]
type = ChangeState
value = 365
triggerall = roundstate = 2
triggerall = command = "a"
triggerall = AILevel != 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2StateType = S
ignorehitpause = 0

;------------------------------------------------------------------------------
[State -1, しゃがみ弱キック]
type = ChangeState
value = 320
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= -536
trigger2 = P2MoveType = I
trigger3 = MoveContact
trigger4 = P2BodyDist X > 357
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1000
triggerall = roundstate = 2
triggerall = Command = "spiral1" || Command = "spiral2" || Command = "spiral3"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist Y <= 136
ignorehitpause = 0



[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2MoveType = I
trigger3 = P2StateType = S
ignorehitpause = 0


[State -1]
type = ChangeState
value = 3000
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "spin1" || Command = "spin2" || Command = "spin3") ||Command = "recovery"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y < 115
ignorehitpause = 0



[State -1, 遠距離立ち強キック]
type = ChangeState
value = 270
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist Y >= -461
trigger2 = InGuardDist
trigger3 = P2MoveType = A
trigger4 = P2StateType = S
trigger5 = MoveContact
ignorehitpause = 0



[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact || MoveGuarded
ignorehitpause = 0


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2BodyDist X <= 256
trigger5 = P2StateType = S
ignorehitpause = 0


[State -1, 遠距離立ち強キック]
type = ChangeState
value = 270
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = InGuardDist
trigger3 = MoveGuarded
trigger4 = P2StateType = A
trigger5 = P2BodyDist Y >= -405
trigger6 = P2BodyDist X >= 153
ignorehitpause = 0



[State -1, しゃがみ弱キック]
type = ChangeState
value = 320
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist Y <= -536
trigger2 = P2MoveType = I
trigger3 = MoveContact
trigger4 = P2BodyDist X > 357
ignorehitpause = 0



[State -1, しゃがみ強パンチ]
type = ChangeState
value = 310
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 601
trigger2 = InGuardDist
trigger3 = P2BodyDist Y < 640
ignorehitpause = 0


[State -1]
type = ChangeState
value = 1200
triggerall = roundstate = 2
triggerall = !NumProj
triggerall = Command = "accel1" || Command = "accel2" || Command = "accel3"
triggerall = statetype != A
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 280
ignorehitpause = 0



[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = MoveContact
trigger3 = P2StateType = S
trigger4 = InGuardDist
trigger5 = P2BodyDist X <= 500
trigger6 = P2BodyDist Y > 467
ignorehitpause = 0


[State -1, ジャンプ弱パンチ]
type = ChangeState
value = 350
triggerall = roundstate = 2
triggerall = command = "x"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X <= 481
trigger3 = InGuardDist
trigger4 = P2MoveType = A
trigger5 = MoveGuarded
ignorehitpause = 0


[State -1, 近距離立ち中キック]
type = ChangeState
value = 255
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = InGuardDist
trigger2 = P2MoveType = I
ignorehitpause = 0


[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 29
trigger2 = P2MoveType = A
trigger3 = P2BodyDist X > 460
trigger4 = MoveContact
trigger5 = P2StateType = C
ignorehitpause = 0


[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist Y > 29
trigger2 = P2MoveType = A
trigger3 = P2BodyDist X > 460
trigger4 = MoveContact
trigger5 = P2StateType = C
ignorehitpause = 0


[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 626
trigger2 = InGuardDist
trigger3 = P2BodyDist Y > -383
trigger4 = P2StateType = S
ignorehitpause = 0


[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2BodyDist X <= 271
trigger2 = MoveContact
ignorehitpause = 0


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2MoveType = I
trigger3 = P2StateType = S
ignorehitpause = 0


