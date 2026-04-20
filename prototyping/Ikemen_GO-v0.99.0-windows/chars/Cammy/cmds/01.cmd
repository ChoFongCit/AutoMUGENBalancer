

















                   
                   
                   


                         
                         
                         
                         
                         














































































































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



[State -1, ジャンプ強パンチ]
type = ChangeState
value = 360
triggerall = roundstate = 2
triggerall = command = "z"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = MoveGuarded
trigger3 = InGuardDist
trigger4 = P2BodyDist Y >= 261


[State -1, 近距離立ち中パンチ]
type = ChangeState
value = 215
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-63*const(size.xscale)),ceil(63*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist


[State -1, しゃがみ弱キック]
type = ChangeState
value = 320
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel != 0

ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist X < 255
trigger3 = InGuardDist
trigger4 = MoveContact || MoveGuarded
trigger5 = P2BodyDist Y >= -396
trigger6 = P2StateType = S


[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X > 352
trigger2 = P2StateType = A
trigger3 = InGuardDist
trigger4 = MoveGuarded
trigger5 = P2BodyDist Y < 26
trigger6 = P2MoveType = H


[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = P2BodyDist X > 111
trigger3 = P2StateType = A
trigger4 = MoveContact


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist X > 623
trigger3 = InGuardDist
trigger4 = MoveGuarded


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X <= 32
trigger2 = P2StateType = C
trigger3 = P2MoveType = I
trigger4 = P2BodyDist Y > -6


[State -1]
type = ChangeState
value = 3000
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "spin1" || Command = "spin2" || Command = "spin3") ||Command = "recovery"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X > 631
trigger2 = P2MoveType = H
trigger3 = InGuardDist
trigger4 = P2StateType = C
trigger5 = P2BodyDist Y <= -179



[State -1, しゃがみ強パンチ]
type = ChangeState
value = 310
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2BodyDist X >= 621
trigger3 = P2BodyDist Y < 465
trigger4 = InGuardDist


[State -1]
type = ChangeState
value = 1200
triggerall = roundstate = 2
triggerall = !NumProj
triggerall = Command = "accel1" || Command = "accel2" || Command = "accel3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2MoveType = H
trigger3 = P2BodyDist X > 578
trigger4 = P2BodyDist Y > -240
trigger5 = P2StateType = S



[State -1, 遠距離立ち弱パンチ]
type = ChangeState
value = 200
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = S
trigger2 = MoveContact || MoveGuarded
trigger3 = P2BodyDist Y > 234
trigger4 = P2BodyDist X > 294
trigger5 = InGuardDist


[State -1, しゃがみ強パンチ]
type = ChangeState
value = 310
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X <= 423
trigger2 = P2MoveType = I
trigger3 = InGuardDist
trigger4 = P2BodyDist Y <= 443
trigger5 = MoveContact
trigger6 = P2StateType = C


[State -1, 斜めジャンプ中パンチ]
type = null
value = 420
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 539
trigger2 = P2BodyDist Y < -110


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = A
trigger2 = P2BodyDist Y >= 524
trigger3 = MoveGuarded


[State -1, 斜めジャンプ中パンチ]
type = null
value = 420
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = MoveContact || MoveGuarded
trigger3 = P2MoveType = A
trigger4 = P2BodyDist X < 136
trigger5 = P2BodyDist Y >= -561
trigger6 = P2StateType = S


[State -1]
type = ChangeState
value = 900
triggerall = roundstate = 2
triggerall = statetype = S
triggerall = P2MoveType != H
triggerall = P2StateNo != [150,155]
triggerall = (p2statetype = S) || (p2statetype = C)
triggerall = p2bodydist X = [-15,ceil(33*const(size.xscale))]
triggerall = command = "holdfwd" || command = "holdback"
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = MoveContact
trigger3 = P2BodyDist Y > -376





[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = MoveContact


[State -1, 近距離立ち中キック]
type = ChangeState
value = 255
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y <= -225
trigger3 = P2BodyDist X > 29
trigger4 = P2MoveType = H
trigger5 = MoveContact
trigger6 = P2StateType = S


[State -1, 遠距離立ち中キック]
type = ChangeState
value = 260
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2StateType = A
trigger3 = P2BodyDist Y > 545
trigger4 = MoveContact


[State -1, ジャンプ弱パンチ]
type = ChangeState
value = 350
triggerall = roundstate = 2
triggerall = command = "x"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2BodyDist Y > 111
trigger3 = P2BodyDist X > 605
trigger4 = P2StateType = C
trigger5 = InGuardDist


[State -1, しゃがみ強キック]
type = ChangeState
value = 330
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < -164
trigger2 = InGuardDist
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = H


[State -1, 近距離立ち弱パンチ]
type = ChangeState
value = 205
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-24*const(size.xscale)),ceil(24*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y <= -21
trigger2 = P2MoveType = H
trigger3 = MoveContact || MoveGuarded
trigger4 = P2BodyDist X <= 131
trigger5 = P2StateType = C


[State -1, ジャンプ強キック]
type = ChangeState
value = 375
triggerall = roundstate = 2
triggerall = command = "c"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 185
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2StateType = A
[State -1, 挑発]
type = null 
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = MoveContact
trigger2 = P2StateType = A
trigger3 = P2BodyDist X > 536
trigger4 = P2MoveType = I
trigger5 = P2BodyDist Y < -410
trigger6 = InGuardDist


[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X <= 339
trigger2 = InGuardDist


[State -1, しゃがみ弱パンチ]
type = ChangeState
value = 300
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel != 0

ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist X <= 277
trigger3 = P2BodyDist Y <= -526


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist
trigger3 = MoveContact
trigger4 = P2BodyDist X >= 576
trigger5 = P2BodyDist Y >= -318


[State -1, 挑発]
type = null 
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2MoveType = H
trigger3 = InGuardDist


[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X > 161
trigger2 = InGuardDist
trigger3 = P2StateType = C


[State -1, 近距離立ち強キック]
type = ChangeState
value = 275
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = MoveContact
trigger3 = P2StateType = C


[State -1]
type = ChangeState
value = 1300
triggerall = roundstate = 2
triggerall = Command = "hooligan1" || Command = "hooligan2" || Command = "hooligan3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = I
trigger5 = P2BodyDist X >= 150



[State -1, 近距離立ち中キック]
type = ChangeState
value = 255
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact


