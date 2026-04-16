;Blanka's CMD file

;-| Super Motions |--------------------------------------------------------
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
;-| Special Motions |------------------------------------------------------
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



;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 15
[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 15
;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1
;-| Dir + Button |---------------------------------------------------------
;-| Single Button |--------------------------------------------------------
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

;-| Hold Dir |-------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1
[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1
[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1
[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1
;---------------------------------------------------------------------------
; 2. State entry
[Statedef -1]

;super move
[State -1, sm]
type = ChangeState
value = 3000
triggerall = power >= 1000
trigger1 = command = "hyperrolling"
trigger1 = statetype != A
trigger1 = ctrl
;trigger2 = command = "bdf_xy"
;trigger2 = (stateno = [200,499])
;trigger2 = MoveHit


;Vrolling1
[State -1, rol]
type = ChangeState
value = 1200
triggerall = command = "rolling7"
trigger1 = stateno = 40

;Vrolling2
[State -1, rol]
type = ChangeState
value = 1210
triggerall = command = "rolling8"
trigger1 = stateno = 40

;Vrolling3
[State -1, rol]
type = ChangeState
value = 1220
triggerall = command = "rolling9"
trigger1 = stateno = 40

;rolling
[State -1, rol]
type = ChangeState
value = 1000
triggerall = command = "rolling1" && statetype != A
trigger1 = ctrl

;rolling
[State -1, rol]
type = ChangeState
value = 1010
triggerall = command = "rolling2" && statetype != A
trigger1 = ctrl

;rolling
[State -1, rol]
type = ChangeState
value = 1020
triggerall = command = "rolling3" && statetype != A
trigger1 = ctrl

;rolling
[State -1, rol]
type = ChangeState
value = 1050
triggerall = command = "rolling4" && statetype != A
trigger1 = ctrl

;rolling
[State -1, rol]
type = ChangeState
value = 1060
triggerall = command = "rolling5" && statetype != A
trigger1 = ctrl

;rolling
[State -1, rol]
type = ChangeState
value = 1070
triggerall = command = "rolling6" && statetype != A
trigger1 = ctrl



;rolling
[State -1, rol]
type = ChangeState
value = 1100
triggerall = command = "electric" && statetype != A
trigger1 = ctrl
;===========================================================================
;z throw

[State -1, throw]
type = ChangeState
value = 800
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
trigger1 = command = "z"
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 5
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H


;close_frontdown_spunch
[State -1, close fdmp]
type = ChangeState
value = 270
triggerall = command = "z" 
trigger1 = command = "holdfwd" 
trigger1 = command = "holddown"
trigger1 = statetype = C && ctrl


;close_front_mpunch
[State -1, closefmp]
type = ChangeState
value = 260
triggerall = command = "y" && command = "holdfwd" && p2bodydist x < 30
trigger1 = statetype = S && ctrl


;close_lpunch
[State -1, close lp]
type = ChangeState
value = 201
triggerall = command = "x" && command != "holddown" && p2bodydist x < 35
trigger1 = statetype = S && ctrl


;close_mpunch
[State -1, close mp]
type = ChangeState
value = 211
triggerall = command = "y" && command != "holddown" && p2bodydist x < 35
trigger1 = statetype = S && ctrl


;close_lkick
[State -1, close lk]
type = ChangeState
value = 231
triggerall = command = "a" && command != "holddown" && p2bodydist x < 35
trigger1 = statetype = S && ctrl

;close_mkick
[State -1, close mk]
type = ChangeState
value = 241
triggerall = command = "b" && command != "holddown" && p2bodydist x < 35
trigger1 = statetype = S && ctrl



;Lpunch
[State -1, p]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
trigger1 = statetype = S && ctrl

;Mpunch
[State -1, p]
type = ChangeState
value = 210
triggerall = command = "y" && command != "holddown"
trigger1 = statetype = S && ctrl

;Spunch
[State -1, p]
type = ChangeState
value = 220
triggerall = command = "z" && command != "holddown"
trigger1 = statetype = S && ctrl

;Lkick
[State -1, k]
type = ChangeState
value = 230
triggerall = command = "a" && command != "holddown"
trigger1 = statetype = S && ctrl

;Mkick
[State -1, k]
type = ChangeState
value = 240
triggerall = command = "b" && command != "holddown"
trigger1 = statetype = S && ctrl

;Skick
[State -1, k]
type = ChangeState
value = 250
triggerall = command = "c" && command != "holddown"
trigger1 = statetype = S && ctrl




;crouch_lpunch

[State -1, crouch lp]
type = ChangeState
value = 400
triggerall = command = "x" && command = "holddown"
trigger1 = statetype = C && ctrl

;crouch_mpunch

[State -1, crouch mp]
type = ChangeState
value = 410
triggerall = command = "y" && command = "holddown"
trigger1 = statetype = C && ctrl


;crouch_spunch

[State -1, crouch sp]
type = ChangeState
value = 420
triggerall = command = "z" && command = "holddown"
trigger1 = statetype = C && ctrl



;crouch_lkick

[State -1, crouch lk]
type = ChangeState
value = 430
triggerall = command = "a" && command = "holddown"
trigger1 = statetype = C && ctrl

;crouch_mkick

[State -1, crouch mk]
type = ChangeState
value = 440
triggerall = command = "b" && command = "holddown"
trigger1 = statetype = C && ctrl

;crouch_skick

[State -1, crouch sk]
type = ChangeState
value = 450
triggerall = command = "c" && command = "holddown"
trigger1 = statetype = C && ctrl




;Air_lp

[State -1, Air lp]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl

;Air_mp

[State -1, Air mp]
type = ChangeState
value = 610
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl

;Air_sp

[State -1, Air sp]
type = ChangeState
value = 621
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl
trigger1 = Vel X !=0

;Air_sp

[State -1, Air sp]
type = ChangeState
value = 620
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl

;Air_lk

[State -1, Air lk]
type = ChangeState
value = 630
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl

;Air_mk

[State -1, Air mk]
type = ChangeState
value = 640
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl

;Air_sk

[State -1, Air sk]
type = ChangeState
value = 650
triggerall = command = "c"
trigger1 = statetype = A
trigger1 = ctrl

