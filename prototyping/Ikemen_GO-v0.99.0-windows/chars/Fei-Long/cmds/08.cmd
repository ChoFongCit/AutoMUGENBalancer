

















                   
                   
                   


                         
                         
                         
                         
                         














































































































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



[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist
trigger3 = P2StateType = S
trigger4 = P2BodyDist Y <= -858


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y > 632
trigger2 = InGuardDist
trigger3 = P2BodyDist X >= 497
trigger4 = P2StateType = C


[State -1, しゃがみ強パンチ]
type = ChangeState
value = 310
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y > -300
trigger2 = P2BodyDist X >= 773


[State -1, しゃがみ弱キック]
type = ChangeState
value = 320
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveGuarded
trigger2 = InGuardDist
trigger3 = P2StateType = C
trigger4 = P2MoveType = A
trigger5 = P2BodyDist Y < -648


[State -1]
type = ChangeState
value = 1200
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "rekku-kyaku1" || Command = "rekku-kyaku2" || Command = "rekku-kyaku3"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X <= 160
trigger2 = P2BodyDist Y < -850
trigger3 = P2MoveType = A
trigger4 = MoveContact
trigger5 = InGuardDist



[State -1, ジャンプ強キック]
type = ChangeState
value = 375
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "c"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact || MoveGuarded
[State -1, 垂直ジャンプ弱キック]
type = ChangeState
value = 365
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist X >= 13


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-54*const(size.xscale)),ceil(54*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = C
trigger2 = MoveContact
trigger3 = P2BodyDist X <= 998
trigger4 = InGuardDist
trigger5 = P2BodyDist Y > 15
trigger6 = P2MoveType = A


[State -1, 遠距離立ち弱パンチ]
type = ChangeState
value = 200
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2StateType = A
trigger3 = P2BodyDist X <= 345
trigger4 = InGuardDist
trigger5 = P2MoveType = A
trigger6 = P2BodyDist Y <= 263


[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = H
trigger2 = P2BodyDist X < 83
trigger3 = P2BodyDist Y <= 100


[State -1, ジャンプ弱パンチ]
type = ChangeState
value = 350
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "x"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 127
trigger2 = P2StateType = S


[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-39*const(size.xscale)),ceil(39*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = A
trigger2 = P2StateType = C


[State -1]
type = ChangeState
value = 1001
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = (Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3") || var(5)
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact || MoveGuarded
trigger2 = P2BodyDist X < 247
trigger3 = InGuardDist
trigger4 = P2BodyDist Y <= 148
trigger5 = P2StateType = A
trigger6 = P2MoveType = H



[State -1, 垂直ジャンプ中キック]
type = ChangeState
value = 370
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "b"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 794
trigger2 = P2BodyDist Y <= -103
trigger3 = P2StateType = S
trigger4 = InGuardDist
trigger5 = P2MoveType = I
trigger6 = MoveContact

;------------------------------------------------------------------------------
[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y > -894
trigger2 = InGuardDist


[State -1, 斜めジャンプ中パンチ]
type = ChangeState
value = 385
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist X > 251


[State -1]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "rekka-shin1" || Command = "rekka-shin2" || Command = "rekka-shin3") ||Command = "recovery"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact



[State -1, 遠撃蹴]
type = ChangeState
value = 510
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = MoveContact || MoveGuarded
trigger3 = P2BodyDist Y >= -808
trigger4 = InGuardDist
trigger5 = P2BodyDist X < 261





[State -1, しゃがみ弱パンチ]
type = ChangeState
value = 300
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2StateType = A
trigger2 = P2MoveType = I
trigger3 = P2BodyDist X <= 680
trigger4 = MoveContact
trigger5 = InGuardDist
trigger6 = P2BodyDist Y <= 708


[State -1, しゃがみ強キック]
type = ChangeState
value = 330
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X >= 775
trigger2 = InGuardDist


[State -1, 近距離立ち強キック]
type = ChangeState
value = 275
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-46*const(size.xscale)),ceil(46*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2BodyDist X <= 506
trigger3 = P2MoveType = I
trigger4 = P2StateType = S
trigger5 = InGuardDist


[State -1, 近距離立ち弱キック]
type = ChangeState
value = 255
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y <= 530
trigger3 = P2MoveType = H
trigger4 = P2BodyDist X > 828


[State -1, 斜めジャンプ中キック]
type = ChangeState
value = 405
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "b"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact
trigger2 = P2StateType = C
trigger3 = P2BodyDist Y <= 50
trigger4 = InGuardDist

;------------------------------------------------------------------------------
[State -1]
type = ChangeState
value = 1100
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "shien-kyaku1" || Command = "shien-kyaku2" || Command = "shien-kyaku3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = InGuardDist
trigger2 = P2BodyDist Y >= -696
trigger3 = P2StateType = C
trigger4 = MoveContact
trigger5 = P2BodyDist X >= 872



[State -1, ジャンプ強パンチ]
type = ChangeState
value = 360
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "z"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 253
trigger2 = MoveGuarded
trigger3 = P2BodyDist Y > 450
trigger4 = P2StateType = C
trigger5 = P2MoveType = H
trigger6 = InGuardDist


[State -1, 斜めジャンプ強パンチ]
type = ChangeState
value = 390
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "z"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveContact || MoveGuarded
trigger2 = InGuardDist
trigger3 = P2BodyDist Y <= -120


[State -1]
type = ChangeState
value = 900
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = statetype = S
triggerall = P2MoveType != H
triggerall = P2StateNo != [150,155]
triggerall = (p2statetype = S) || (p2statetype = C)
triggerall = p2bodydist X = [-15,ceil(33*const(size.xscale))]
triggerall = command = "holdfwd" || command = "holdback"
triggerall = ctrl
triggerall = AILevel != 0
trigger1 = P2MoveType = A
trigger2 = InGuardDist
trigger3 = P2StateType = S
trigger4 = P2BodyDist Y <= -437



[State -1, 挑発]
type = null 
value = 195
triggerall = command = "start"
triggerall = AILevel != 0
trigger1 = P2StateType = C
trigger2 = P2BodyDist X <= 566
trigger3 = P2BodyDist Y > 5
trigger4 = InGuardDist
trigger5 = P2MoveType = H
trigger6 = MoveContact


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = A
trigger2 = P2BodyDist X > 675
trigger3 = InGuardDist
trigger4 = P2BodyDist Y <= 585
trigger5 = P2MoveType = I
trigger6 = MoveContact || MoveGuarded


[State -1, 近距離立ち中パンチ]
type = ChangeState
value = 215
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-36*const(size.xscale)),ceil(36*const(size.xscale))]
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I
trigger2 = InGuardDist


[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < -850
trigger2 = MoveGuarded
trigger3 = P2BodyDist X >= 301
trigger4 = P2MoveType = H


[State -1]
type = ChangeState
value = 1000
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3"
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist Y < -543
trigger3 = InGuardDist



[State -1]
type = ChangeState
value = 1002
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = (Command = "rekka-ken1" || Command = "rekka-ken2" || Command = "rekka-ken3") || var(5)
triggerall = statetype != A
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2StateType = C



[State -1, 斜めジャンプ弱パンチ]
type = ChangeState
value = 380
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "x"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = MoveGuarded
trigger2 = P2BodyDist X > 553
trigger3 = P2BodyDist Y > -18
trigger4 = InGuardDist
trigger5 = P2MoveType = H


[State -1, 遠距離立ち強キック]
type = ChangeState
value = 270
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist Y < 95



[State -1, 斜めジャンプ弱キック]
type = ChangeState
value = 400
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Vel X
triggerall = command = "a"
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2MoveType = I


[State -1, 近距離立ち弱パンチ]
type = ChangeState
value = 205
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-48*const(size.xscale)),ceil(48*const(size.xscale))]
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X <= 138
trigger2 = P2BodyDist Y >= -590
trigger3 = P2StateType = A


[State -1, 遠距離立ち中キック]
type = ChangeState
value = 260
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
triggerall = AILevel != 0
ignorehitpause = 0
trigger1 = P2BodyDist X < 372
trigger2 = P2StateType = S


[State -1, 直下落踵]
type = ChangeState
value = 500
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown" && command != "holdup"
triggerall = command = "holdfwd" || command = "holdback"
triggerall = statetype != A
triggerall = ctrl
triggerall = statetype = S
triggerall = AILevel != 0
trigger1 = MoveGuarded
trigger2 = P2StateType = A
trigger3 = P2BodyDist Y <= 342

