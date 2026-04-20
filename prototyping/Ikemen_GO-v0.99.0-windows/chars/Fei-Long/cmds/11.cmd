

















                   
                   
                   


                         
                         
                         
                         
                         














































































































[Command]
name = "rekka-shin1"
command = ~D, DF, F, D, DF, F, x
time = 23

[Command]
name = "rekka-shin1"
command = ~D, DF, F, D, DF, F, ~x
time = 23

[Command]
name = "rekka-shin2"
command = ~D, DF, F, D, DF, F, y
time = 23

[Command]
name = "rekka-shin2"
command = ~D, DF, F, D, DF, F, ~y
time = 23

[Command]
name = "rekka-shin3"
command = ~D, DF, F, D, DF, F, z
time = 23

[Command]
name = "rekka-shin3"
command = ~D, DF, F, D, DF, F, ~z
time = 23



[Command]
name = "rekku-kyaku1"
command = ~BD, D, F, UF, a
time = 14

[Command]
name = "rekku-kyaku1"
command = ~BD, D, F, UF, ~a
time = 14

[Command]
name = "rekku-kyaku2"
command = ~BD, D, F, UF, b
time = 14

[Command]
name = "rekku-kyaku2"
command = ~BD, D, F, UF, ~b
time = 14

[Command]
name = "rekku-kyaku3"
command = ~BD, D, F, UF, c
time = 14

[Command]
name = "rekku-kyaku3"
command = ~BD, D, F, UF, ~c
time = 14

[Command]
name = "shien-kyaku1"
command = ~B, D, DB, a
time = 12

[Command]
name = "shien-kyaku"
command = ~B, D, DB, ~a
time = 12

[Command]
name = "shien-kyaku2"
command = ~B, D, DB, b
time = 12

[Command]
name = "shien-kyaku2"
command = ~B, D, DB, ~b
time = 12

[Command]
name = "shien-kyaku3"
command = ~B, D, DB, c
time = 12

[Command]
name = "shien-kyaku3"
command = ~B, D, DB, ~c
time = 12

[Command]
name = "rekka-ken1"
command = ~D, DF, F, x
time = 12

[Command]
name = "rekka-ken1"
command = ~D, DF, F, ~x
time = 12

[Command]
name = "rekka-ken2"
command = ~D, DF, F, y
time = 12

[Command]
name = "rekka-ken2"
command = ~D, DF, F, ~y
time = 12

[Command]
name = "rekka-ken3"
command = ~D, DF, F, z
time = 12

[Command]
name = "rekka-ken3"
command = ~D, DF, F, ~z
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
type = null
triggerall = Command = "x"
triggerall = stateno = 300
trigger1 = var(3) = [1,2]
trigger1 = HitPauseTime = [1,6]
var(11) = 4
ignorehitpause = 1

[State 100]
type = null
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

[State 100]
type = VarSet
trigger1 = time = 2
trigger1 = stateno = [1000,1002]
trigger2 = movetype = H
var(5) = 0

[State 100]
type = VarSet
triggerall = !var(5)
triggerall = Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3"
trigger1 = stateno = 1000
trigger1 = animelemtime(3) >= 2 || HitPauseTime = [1,8]
trigger2 = stateno = 1001
trigger2 = animelemtime(2) > 1 || HitPauseTime = [1,8]
var(5) = ifelse(Command = "rekka-ken1", 1, ifelse(Command = "rekka-ken2", 2, 3))
ignorehitpause = 1



[State -1, 遠撃蹴]
type = ChangeState
value = 510
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2MoveType = I
trigger2 = P2BodyDist Y >= -456
trigger3 = P2StateType = A





[State -1, 垂直ジャンプ弱キック]
type = ChangeState
value = 365
triggerall = roundstate = 2
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 153
trigger2 = P2StateType = A
trigger3 = InGuardDist
trigger4 = MoveGuarded
trigger5 = P2BodyDist X > 27


[State -1, 斜めジャンプ弱パンチ]
type = ChangeState
value = 380
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "x"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < -472


[State -1, 直下落踵]
type = ChangeState
value = 500
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd" || command = "holdback"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 548
trigger2 = P2StateType = S

[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 240


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-54*const(size.xscale)),ceil(54*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = InGuardDist


[State -1, 直下落踵]
type = ChangeState
value = 500
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd" || command = "holdback"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 548
trigger2 = P2StateType = S

[State -1, 直下落踵]
type = ChangeState
value = 500
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd" || command = "holdback"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2BodyDist X > 178
trigger2 = P2BodyDist Y < 314

[State -1]
type = ChangeState
value = 1001
triggerall = roundstate = 2
triggerall = (Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3") || var(5)
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X >= 198



[State -1, 斜めジャンプ弱キック]
type = ChangeState
value = 400
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = S
trigger2 = MoveGuarded
trigger3 = P2BodyDist X <= 571


[State -1, 斜めジャンプ中キック]
type = ChangeState
value = 405
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "b"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2StateType = S
trigger3 = P2BodyDist X < 252
trigger4 = P2BodyDist Y < 240
trigger5 = InGuardDist

;------------------------------------------------------------------------------
[State -1, 遠距離立ち弱パンチ]
type = ChangeState
value = 200
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2MoveType = A
trigger3 = MoveContact || MoveGuarded
trigger4 = P2StateType = A
trigger5 = P2BodyDist Y <= 144


[State -1, しゃがみ強キック]
type = ChangeState
value = 330
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = A
trigger2 = P2BodyDist Y < 67
trigger3 = P2BodyDist X > 258
trigger4 = MoveContact


[State -1, 斜めジャンプ弱キック]
type = ChangeState
value = 400
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I


[State -1, 垂直ジャンプ中キック]
type = ChangeState
value = 370
triggerall = roundstate = 2
triggerall = command = "b"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveGuarded
trigger2 = InGuardDist
trigger3 = P2BodyDist X <= 304
trigger4 = P2BodyDist Y <= 315
trigger5 = P2MoveType = I
trigger6 = P2StateType = A

;------------------------------------------------------------------------------
[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-54*const(size.xscale)),ceil(54*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2StateType = C
trigger3 = P2BodyDist X > 235


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y >= 201


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-54*const(size.xscale)),ceil(54*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = InGuardDist


[State -1]
type = ChangeState
value = 1100
triggerall = roundstate = 2
triggerall = Command = "shien-kyaku1" || Command = "shien-kyaku2" || Command = "shien-kyaku3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X >= 258
trigger3 = MoveContact || MoveGuarded
trigger4 = P2BodyDist Y < -92
trigger5 = P2StateType = C



[State -1, 斜めジャンプ弱キック]
type = ChangeState
value = 400
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = A
trigger2 = P2BodyDist X < 430
trigger3 = P2MoveType = I


[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-39*const(size.xscale)),ceil(39*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X > 88


[State -1, 近距離立ち弱パンチ]
type = ChangeState
value = 205
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-48*const(size.xscale)),ceil(48*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 153
trigger2 = MoveContact


[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = S


[State -1, 挑発]
type = null 
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = InGuardDist


[State -1, ジャンプ強キック]
type = ChangeState
value = 375
triggerall = roundstate = 2
triggerall = command = "c"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y <= 156
[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2StateType = S
trigger3 = MoveContact


[State -1, 近距離立ち強キック]
type = ChangeState
value = 275
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-46*const(size.xscale)),ceil(46*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = S
trigger2 = P2BodyDist X > 416
trigger3 = InGuardDist


[State -1, 近距離立ち弱パンチ]
type = ChangeState
value = 205
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-48*const(size.xscale)),ceil(48*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y <= 340


[State -1, 直下落踵]
type = ChangeState
value = 500
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd" || command = "holdback"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2BodyDist X < 548
trigger2 = P2StateType = S

[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2BodyDist X <= 534
trigger3 = InGuardDist
trigger4 = P2MoveType = A
trigger5 = P2BodyDist Y >= -504
trigger6 = P2StateType = C


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-54*const(size.xscale)),ceil(54*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = InGuardDist


[State -1]
type = ChangeState
value = 1000
triggerall = roundstate = 2
triggerall = Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = MoveContact
trigger3 = P2BodyDist Y > -438
trigger4 = InGuardDist
trigger5 = P2StateType = A



[State -1, 垂直ジャンプ中キック]
type = ChangeState
value = 370
triggerall = roundstate = 2
triggerall = command = "b"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = MoveContact
trigger3 = P2MoveType = I
trigger4 = P2StateType = S
trigger5 = P2BodyDist X > 459

;------------------------------------------------------------------------------
[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 240


[State -1, 近距離立ち弱キック]
type = ChangeState
value = 255
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y <= 103
trigger2 = MoveContact


[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 162
trigger2 = P2BodyDist Y <= 305
trigger3 = MoveGuarded
trigger4 = P2StateType = C


[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 240


[State -1, 遠距離立ち中キック]
type = ChangeState
value = 260
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact


[State -1, 斜めジャンプ中パンチ]
type = ChangeState
value = 385
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 236
trigger2 = P2BodyDist X < 270
trigger3 = MoveContact || MoveGuarded
trigger4 = P2MoveType = H
trigger5 = InGuardDist


