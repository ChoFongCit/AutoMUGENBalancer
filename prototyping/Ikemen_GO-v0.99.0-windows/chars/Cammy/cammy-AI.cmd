

















                   
                   
                   


                         
                         
                         
                         
                         














































































































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



[State -1]
type = ChangeState
value = 3000
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = power >= 3000
triggerall = (Command = "spin1" || Command = "spin2" || Command = "spin3") ||Command = "recovery"
triggerall = statetype != A
trigger1 = ctrl
trigger2 = StateNo = 200 && ((var(3) = [1,2])|| time < 1)
trigger3 = StateNo = 205 && ((var(3) = [1,2])|| time < 1)
trigger4 = StateNo = 210 && (var(3) = [1,2]) && animelemtime(4)<2
trigger5 = StateNo = 215 && (var(3) = [1,2]) && animelemtime(4)<0
trigger6 = StateNo = 220 && (var(3) = [1,2]) && animelemtime(4)<0
trigger7 = StateNo = 225 && (var(3) = [1,2]) && animelemtime(4)<2
trigger8 = StateNo = 250 && ((var(3) = [1,2])|| time < 1)
trigger9 = StateNo = 255 && ((var(3) = [1,2])|| time < 1)
trigger10 = StateNo = 265 && (var(3) = [1,2]) && animelemtime(4)<2
trigger11 = StateNo = 300 && ((var(3) = [1,2])|| time < 1)
trigger12 = StateNo = 305 && (var(3) = [1,2]) && animelemtime(4)<2
trigger13 = StateNo = 320 && ((var(3) = [1,2])|| time < 1)
trigger14 = StateNo = 325 && (var(3) = [1,2]) && animelemtime(4)<2
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1100
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "cannon1" || Command = "cannon2" || Command = "cannon3"
triggerall = statetype != A
trigger1 = ctrl
trigger2 = StateNo = 200 && ((var(3) = [1,2])|| time < 1)
trigger3 = StateNo = 205 && ((var(3) = [1,2])|| time < 1)
trigger4 = StateNo = 210 && (var(3) = [1,2]) && animelemtime(4)<2
trigger5 = StateNo = 215 && (var(3) = [1,2]) && animelemtime(4)<0
trigger6 = StateNo = 220 && (var(3) = [1,2]) && animelemtime(4)<0
trigger7 = StateNo = 225 && (var(3) = [1,2]) && animelemtime(4)<2
trigger8 = StateNo = 250 && ((var(3) = [1,2])|| time < 1)
trigger9 = StateNo = 255 && ((var(3) = [1,2])|| time < 1)
trigger10 = StateNo = 265 && (var(3) = [1,2]) && animelemtime(4)<2
trigger11 = StateNo = 300 && ((var(3) = [1,2])|| time < 1)
trigger12 = StateNo = 305 && (var(3) = [1,2]) && animelemtime(4)<2
trigger13 = StateNo = 320 && ((var(3) = [1,2])|| time < 1)
trigger14 = StateNo = 325 && (var(3) = [1,2]) && animelemtime(4)<2
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1000
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "spiral1" || Command = "spiral2" || Command = "spiral3"
triggerall = statetype != A
trigger1 = ctrl
trigger2 = StateNo = 200 && ((var(3) = [1,2])|| time < 1)
trigger3 = StateNo = 205 && ((var(3) = [1,2])|| time < 1)
trigger4 = StateNo = 210 && (var(3) = [1,2]) && animelemtime(4)<2
trigger5 = StateNo = 215 && (var(3) = [1,2]) && animelemtime(4)<0
trigger6 = StateNo = 220 && (var(3) = [1,2]) && animelemtime(4)<0
trigger7 = StateNo = 225 && (var(3) = [1,2]) && animelemtime(4)<2
trigger8 = StateNo = 250 && ((var(3) = [1,2])|| time < 1)
trigger9 = StateNo = 255 && ((var(3) = [1,2])|| time < 1)
trigger10 = StateNo = 265 && (var(3) = [1,2]) && animelemtime(4)<2
trigger11 = StateNo = 300 && ((var(3) = [1,2])|| time < 1)
trigger12 = StateNo = 305 && (var(3) = [1,2]) && animelemtime(4)<2
trigger13 = StateNo = 320 && ((var(3) = [1,2])|| time < 1)
trigger14 = StateNo = 325 && (var(3) = [1,2]) && animelemtime(4)<2
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1300
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = Command = "hooligan1" || Command = "hooligan2" || Command = "hooligan3"
triggerall = statetype != A
trigger1 = ctrl
trigger2 = StateNo = 200 && ((var(3) = [1,2])|| time < 1)
trigger3 = StateNo = 205 && ((var(3) = [1,2])|| time < 1)
trigger4 = StateNo = 210 && (var(3) = [1,2]) && animelemtime(4)<2
trigger5 = StateNo = 215 && (var(3) = [1,2]) && animelemtime(4)<0
trigger6 = StateNo = 220 && (var(3) = [1,2]) && animelemtime(4)<0
trigger7 = StateNo = 225 && (var(3) = [1,2]) && animelemtime(4)<2
trigger8 = StateNo = 250 && ((var(3) = [1,2])|| time < 1)
trigger9 = StateNo = 255 && ((var(3) = [1,2])|| time < 1)
trigger10 = StateNo = 265 && (var(3) = [1,2]) && animelemtime(4)<2
trigger11 = StateNo = 300 && ((var(3) = [1,2])|| time < 1)
trigger12 = StateNo = 305 && (var(3) = [1,2]) && animelemtime(4)<2
trigger13 = StateNo = 320 && ((var(3) = [1,2])|| time < 1)
trigger14 = StateNo = 325 && (var(3) = [1,2]) && animelemtime(4)<2
trigger15 = StateNo = 40
ignorehitpause = 0



[State -1]
type = ChangeState
value = 1200
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = !NumProj
triggerall = Command = "accel1" || Command = "accel2" || Command = "accel3"
triggerall = statetype != A
trigger1 = ctrl
trigger2 = StateNo = 200 && ((var(3) = [1,2])|| time < 1)
trigger3 = StateNo = 205 && ((var(3) = [1,2])|| time < 1)
trigger4 = StateNo = 210 && (var(3) = [1,2]) && animelemtime(4)<2
trigger5 = StateNo = 215 && (var(3) = [1,2]) && animelemtime(4)<0
trigger6 = StateNo = 220 && (var(3) = [1,2]) && animelemtime(4)<0
trigger7 = StateNo = 225 && (var(3) = [1,2]) && animelemtime(4)<2
trigger8 = StateNo = 250 && ((var(3) = [1,2])|| time < 1)
trigger9 = StateNo = 255 && ((var(3) = [1,2])|| time < 1)
trigger10 = StateNo = 265 && (var(3) = [1,2]) && animelemtime(4)<2
trigger11 = StateNo = 300 && ((var(3) = [1,2])|| time < 1)
trigger12 = StateNo = 305 && (var(3) = [1,2]) && animelemtime(4)<2
trigger13 = StateNo = 320 && ((var(3) = [1,2])|| time < 1)
trigger14 = StateNo = 325 && (var(3) = [1,2]) && animelemtime(4)<2
ignorehitpause = 0



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
trigger1 = Command = "y" || Command = "z" || Command = "b" || Command = "c"
trigger2 = (var(11) = [2,3]) || (var(11) = [5,6])





[State -1, 近距離立ち弱パンチ]
type = ChangeState
value = 205
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-24*const(size.xscale)),ceil(24*const(size.xscale))]
trigger1 = ctrl
trigger1 = statetype = S
trigger1 = command = "x"
trigger2 = ctrl
trigger2 = var(11) = 4
trigger3 = command = "x"
trigger3 = stateno = 205
trigger3 = animelemtime(4) >= 0
ignorehitpause = 0


[State -1, 遠距離立ち弱パンチ]
type = ChangeState
value = 200
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = command = "x"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = command = "x"
trigger2 = stateno = 200
trigger2 = animelemtime(3) >= 0
trigger3 = var(11) = 4
trigger3 = ctrl
trigger4 = command = "x"
trigger4 = stateno = 205
trigger4 = animelemtime(4) >= 0
ignorehitpause = 0


[State -1, 近距離立ち中パンチ]
type = ChangeState
value = 215
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-63*const(size.xscale)),ceil(63*const(size.xscale))]
triggerall = ctrl
trigger1 = command = "y"
trigger1 = statetype = S
trigger2 = var(11) = 5
ignorehitpause = 0


[State -1, 遠距離立ち中パンチ]
type = ChangeState
value = 210
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "y"
trigger1 = statetype = S
trigger2 = var(11) = 5
ignorehitpause = 0


[State -1, 近距離立ち強パンチ]
type = ChangeState
value = 225
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
trigger1 = command = "z"
trigger1 = statetype = S
trigger2 = var(11) = 6
ignorehitpause = 0


[State -1, 遠距離立ち強パンチ]
type = ChangeState
value = 220
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "z"
trigger1 = statetype = S
trigger2 = var(11) = 6
ignorehitpause = 0


[State -1, 近距離立ち中キック]
type = ChangeState
value = 255
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-13*const(size.xscale)),ceil(13*const(size.xscale))]
triggerall = ctrl
trigger1 = command = "a"
trigger1 = statetype = S
trigger2 = var(11) = 1
ignorehitpause = 0


[State -1, 遠距離立ち弱キック]
type = ChangeState
value = 250
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "a"
trigger1 = statetype = S
trigger2 = var(11) = 1
ignorehitpause = 0


[State -1, 近距離立ち中キック]
type = ChangeState
value = 265
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
trigger1 = command = "b"
trigger1 = statetype = S
trigger2 = var(11) = 2
ignorehitpause = 0


[State -1, 遠距離立ち中キック]
type = ChangeState
value = 260
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "b"
trigger1 = statetype = S
trigger2 = var(11) = 2
ignorehitpause = 0


[State -1, 近距離立ち強キック]
type = ChangeState
value = 275
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = P2BodyDist X = [ceil(-30*const(size.xscale)),ceil(30*const(size.xscale))]
triggerall = ctrl
trigger1 = command = "c"
trigger1 = statetype = S
trigger2 = var(11) = 3
ignorehitpause = 0


[State -1, 遠距離立ち強キック]
type = ChangeState
value = 270
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "c"
trigger1 = statetype = S
trigger2 = var(11) = 3
ignorehitpause = 0



[State -1, 挑発]
type = null 
value = 195
triggerall = command = "start"
trigger1 = statetype != A
trigger1 = ctrl


[State -1, しゃがみ弱パンチ]
type = ChangeState
value = 300
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
trigger1 = command = "x"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = var(11) = 4 || command = "x"
trigger2 = stateno = 300
trigger2 = animelemtime(3) >= 0
trigger3 = command = "x"
trigger3 = stateno = 320
trigger3 = animelemtime(3) >= 0
trigger4 = var(11) = 4
trigger4 = ctrl

ignorehitpause = 0


[State -1, しゃがみ中パンチ]
type = ChangeState
value = 305
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "y"
trigger1 = statetype = C
trigger2 = var(11) = 5
ignorehitpause = 0


[State -1, しゃがみ強パンチ]
type = ChangeState
value = 310
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "z"
trigger1 = statetype = C
trigger2 = var(11) = 6
ignorehitpause = 0


[State -1, しゃがみ弱キック]
type = ChangeState
value = 320
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
trigger1 = command = "a"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = command = "a"
trigger2 = stateno = 300
trigger2 = animelemtime(3) >= 0
trigger3 = var(11) = 1 || command = "a"
trigger3 = stateno = 320
trigger3 = animelemtime(3) >= 0
trigger4 = var(11) = 1
trigger4 = ctrl

ignorehitpause = 0


[State -1, しゃがみ中キック]
type = ChangeState
value = 325
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = statetype = C
trigger1 = command = "b"
trigger2 = var(11) = 2
ignorehitpause = 0


[State -1, しゃがみ強キック]
type = ChangeState
value = 330
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = statetype = C
trigger1 = command = "c"
trigger2 = var(11) = 3
ignorehitpause = 0


[State -1, ジャンプ弱パンチ]
type = ChangeState
value = 350
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0


[State -1, 斜めジャンプ中パンチ]
type = null
value = 420
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "y"
triggerall = Vel X
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0


[State -1, ジャンプ中パンチ]
type = ChangeState
value = 355
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0


[State -1, ジャンプ強パンチ]
type = ChangeState
value = 360
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0


[State -1, 垂直ジャンプ弱キック]
type = ChangeState
value = 365
triggerall = AILevel <= 0
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0

;------------------------------------------------------------------------------
[State -1, 垂直ジャンプ中キック]
type = ChangeState
value = 370
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0

;------------------------------------------------------------------------------
[State -1, ジャンプ強キック]
type = ChangeState
value = 375
triggerall = !var(59)
triggerall = roundstate = 2
triggerall = command = "c"
trigger1 = statetype = A
trigger1 = ctrl
ignorehitpause = 0
