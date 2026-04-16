; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional -- defaults to 15 if omitted)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas.
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   You can combine them:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;   It's recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This matches the way most
;   popular fighting games implement their command detection.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. Defaults to 15
;   if omitted
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
; 
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10
; 
;-| AI |--------------------------------------------------------FIDO A
[Command]
name = "ai"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai1"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai2"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai3"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai4"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai5"
command = x,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai6"
command = x,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai7"
command = x,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai8"
command = y,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai9"
command = y,y,y,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai10"
command =  y,y,F,F,F,y,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai11"
command = F,F,x,z,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai12"
command = a,F,F,F,x,F,F,F,b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai13"
command = b,b,b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai14"
command = F,F,b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai15"
command = F,b,F,F,b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai16"
command = F,F,c,c,c,F,F,F,F,F,F,F,c,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai17"
command = c,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,c,c,F,a+b
time = 1
[Command]
name = "ai18"
command = F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,c,F,F,F,F,F,F,F,c,c,a+b
time = 1
[Command]
name = "ai19"
command = c,F,F,z,F,F,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai20"
command = c,F,F,F,F,b,F,F,F,F,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai21"
command = a,F,F,F,F,F,F,z,F,F,F,F,F,b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai22"
command = b,a,z,x,c,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai23"
command = x,c,x,x,x,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai24"
command = x,x,x,z,z,z,z,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai25"
command = z,z,z,z,z,z,z,z,a,a,a,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai26"
command = a,a,a,a,a,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai27"
command = a,a,a,F,F,F,F,F,a,a,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai28"
command = a+b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1
[Command]
name = "ai29"
command =  z+b,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,a+b
time = 1

;-| Super Motions |--------------------------------------------------------
[Command]
name = "super_01A"
command = ~45$B, F,B, F, a
time = 30
[Command]
name = "super_01A"
command = ~45$B, F,B, F, b
time = 30
[Command]
name = "super_01A"
command = ~45$B, F,B, F, c
time = 30

[Command]
name = "super_02A"
command = ~45$B, F,B, F, x
time = 30
[Command]
name = "super_02A"
command = ~45$B, F,B, F, y
time = 30
[Command]
name = "super_02A"
command = ~45$B, F,B, F, z
time = 30

;--------------------------------------------------------------------------
[Command]
name = "special_01A"
command = ~45$D, U, a
time = 15

[Command]
name = "special_01B"
command = ~45$D, U, b
time = 15

[Command]
name = "special_01C"
command = ~45$D, U, c
time = 15

[Command]
name = "special_02A"
command = ~45$B, F, x
time = 15

[Command]
name = "special_02B"
command = ~45$B, F, y
time = 15

[Command]
name = "special_02C"
command = ~45$B, F, z
time = 15

[Command]
name = "special_03A"
command = ~50$B, F, a
time = 15

[Command]
name = "special_03B"
command = ~50$B, F, b
time = 15

[Command]
name = "special_03C"
command = ~50$B, F, c
time = 15

[Command]
name = "special_04A"
command = ~45$D, U, x
time = 15

[Command]
name = "special_04A"
command = ~45$D, U, y
time = 15

[Command]
name = "special_04A"
command = ~45$D, U, z
time = 15

[Command]
name = "special_07A"
command = ~D,DB,B,x
time = 15

[Command]
name = "special_07B"
command = ~D,DB,B,y
time = 15

[Command]
name = "special_07C"
command = ~D,DB,B,z
time = 15

[Command]
name = "special_08A"
command = ~D,DB,B,a
time = 15

[Command]
name = "special_08B"
command = ~D,DB,B,b
time = 15

[Command]
name = "special_08C"
command = ~D,DB,B,c
time = 15

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "rolling"
command = x+a
time = 1

[Command]
name = "recovery"			;Required (do not remove)
command = x+c
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "throw_01"
command = /$F,y
time = 1

[Command]
name = "throw_01"
command = /$F,z
time = 1

[Command]
name = "special_05A"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "up"
command = U
time = 1

[Command]
name = "down"
command = D
time = 1

[Command]
name = "fwd"
command = F
time = 1

[Command]
name = "back"
command = B
time = 1

[Command]
name = "upback"
command = UB
time = 1

[Command]
name = "downback"
command = DB
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

;-| Hold button |--------------------------------------------------------------
[Command]
name = "hold_x"
command = /x
time = 2

[Command]
name = "hold_y"
command = /y
time = 2

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd"				;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback"				;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" 				;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown"				;Required (do not remove)
command = /$D
time = 1

[Command]
name = "block_air"
command = ~$D~
time = 1

[Command]
name = "block_air"
command = ~$F~
time = 1

;---------------------------------------------------------------------------
; 2. State entry
; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]
;AI
[State -1]
type = VarSet
trigger1 = Command = "ai"
trigger2 = Command = "ai1"
trigger3 = Command = "ai2"
trigger4 = Command = "ai3"
trigger5 = Command = "ai4"
trigger6 = Command = "ai5"
trigger7 = Command = "ai6"
trigger8 = Command = "ai7"
trigger9 = Command = "ai8"
trigger10 = Command = "ai9"
trigger11 = Command = "ai10"
trigger12 = Command = "ai11"
trigger13 = Command = "ai12"
trigger14 = Command = "ai13"
trigger15 = Command = "ai14"
trigger16 = Command = "ai15"
trigger17 = Command = "ai16"
trigger18 = Command = "ai17"
trigger19 = Command = "ai18"
trigger20 = Command = "ai19"
trigger21 = Command = "ai20"
trigger22 = Command = "ai21"
trigger23 = Command = "ai22"
trigger24 = Command = "ai23"
trigger25 = Command = "ai24"
trigger26 = Command = "ai25"
trigger27 = Command = "ai26"
trigger28 = Command = "ai27"
trigger29 = Command = "ai28"
trigger30 = Command = "ai29"
ignorehitpause = 1
var(25) = 1

;==========================================================================================
;super
[State -1, 2000]
type = ChangeState
value = 2000
triggerall = command = "super_01A" &&  statetype !=A && power >= 1000
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

[State -1, 2000AI]
type = ChangeState
value = 2000
triggerall = var(25) = 1 &&  statetype !=A && power >= 1000 && random = 50
trigger1 = PrevStateNo != 2000 && ctrl && P2bodydist X = [70,80]  

[State -1, 2000]
type = ChangeState
value = 2100
triggerall = command = "super_02A" &&  statetype !=A && var(14) = 1 && var(25) = 0 && power >= 1000
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;--------------------------------------------------------------------------
;SPECIAL_02_A
[State -1, 1100]
type = ChangeState
value = 1100
triggerall = command = "special_02A" &&  statetype !=A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_02_B
[State -1, 1110]
type = ChangeState
value = 1110
triggerall = command = "special_02B" &&  statetype != A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_02_C
[State -1, 1120]
type = ChangeState
value = 1120
triggerall = command = "special_02C" &&  statetype != A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_02_C AI
[State -1, 1120]
type = ChangeState
value = 1120
triggerall = var(25) = 1 &&  statetype != A && p2movetype != I
trigger1 = ctrl && P2bodydist X >= 200 && PrevStateNo != 1120 && stateno != 1120
trigger1 = random <= 100 
trigger2 = movecontact && stateno = 325 
trigger2 = random <= 100 
trigger3 = life <= 200 && PrevStateNo != 1120 && stateno != 1120 && P2bodydist X >= 200
trigger3 = random <= 200
;--------------------------------------------------------------------------
;SPECIAL_01_A
[State -1, 1000]
type = ChangeState
value = 1000
triggerall = command = "special_01A" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_01_B
[State -1, 1010]
type = ChangeState
value = 1000
triggerall = command = "special_01B" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_01_C
[State -1, 1020]
type = ChangeState
value = 1000
triggerall = command = "special_01C" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_01_C AI
[State -1, 10200]
type = ChangeState
value = 1000
triggerall = var(25) = 1 &&  statetype != A
trigger1 = ctrl && P2bodydist X = [200,220] 
trigger1 = random <= 50 && PrevStateNo != 1000
trigger2 = movecontact && stateno = 325 && random <= 100 

;--------------------------------------------------------------------------
;SPECIAL_03_A
[State -1, 1200]
type = ChangeState
value = 1200
triggerall = command = "special_03A" &&  statetype != A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_03_B
[State -1, 1201]
type = ChangeState
value = 1210
triggerall = command = "special_03B" &&  statetype != A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

[State -1,1210]						
type = ChangeState
value = 1210
triggerall = var(25) = 1 && statetype != A
trigger1 = movecontact && stateno= 325
trigger1 = random <= 200
trigger2 = ctrl && P2bodydist X = [80,120]
trigger2 = random <= 100

;SPECIAL_03_C
[State -1, 1202]
type = ChangeState
value = 1220
triggerall = command = "special_03C" &&  statetype != A
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;--------------------------------------------------------------------------
;SPECIAL_04_A
[State -1, 1300]
type = ChangeState
value = 1300
triggerall = command = "special_04A" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_04_B
[State -1, 1310]
type = ChangeState
value = 1300
triggerall = command = "special_04A" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;SPECIAL_04_C
[State -1, 1320]
type = ChangeState
value = 1300
triggerall = command = "special_04A" &&  statetype != A
trigger1 = ctrl || stateno = 40
trigger2 = movecontact && ( stateno = 200 || stateno = 240 || stateno = 220 || stateno = 260 )
trigger3 = movecontact && ( stateno = 300 || stateno = 305 || stateno = 320 || stateno = 325 )

;--------------------------------------------------------------------------
;SPECIAL_05_A
[State -1, 1700]
type = ChangeState
value = 2700
triggerall = command = "special_07A" &&  statetype != A && var(14) = 1 && var(25) = 0
trigger1 = ctrl 
trigger2 = movecontact && stateno = [200,320]

;SPECIAL_05_B
[State -1, 1710]
type = ChangeState
value = 2710
triggerall = command = "special_07B" &&  statetype != A && var(14) = 1 && var(25) = 0
trigger1 = ctrl 
trigger2 = movecontact && stateno = [200,320]

;SPECIAL_04_C
[State -1, 1720]
type = ChangeState
value = 2720
triggerall = command = "special_07C" &&  statetype != A && var(14) = 1 && var(25) = 0
trigger1 = ctrl
trigger2 = movecontact && stateno = [200,320]

;--------------------------------------------------------------------------
;SPECIAL_06_A
[State -1, 1800]
type = ChangeState
value = 1800
triggerall = command = "special_08A" &&  statetype != A && var(14) = 1 && NumProjID(1800) = 0 
trigger1 = ctrl 
trigger2 = movecontact && stateno = [200,330]

;SPECIAL_06_B
[State -1, 1810]
type = ChangeState
value = 1810
triggerall = command = "special_08B" &&  statetype != A && var(14) = 1 && NumProjID(1800) = 0 
trigger1 = ctrl 
trigger2 = movecontact && stateno = [200,330]

;SPECIAL_06_C
[State -1, 1820]
type = ChangeState
value = 1820
triggerall = command = "special_08C" &&  statetype != A && var(14) = 1 && NumProjID(1800) = 0 
trigger1 = ctrl
trigger2 = movecontact && stateno = [200,330]

;-----------------------------------------------------------------------------------------------------------------------------------
;EX and NORMAL change state
[State -1, 14444]
type = ChangeState
value = 14444
triggerall = var(25) = 0
trigger1 = command = "b" &&  command = "y" && ctrl && statetype != A && var(14) = 0

[State -1, 44444]
type = ChangeState
value = 44444
trigger1 = command = "b" &&  command = "y" && ctrl && statetype != A && var(14) = 1
;=====================================================================
; Basic Throws
[State -1, throw]
type = ChangeState
value = 500
triggerall = statetype = S && ctrl && stateno != 100 
trigger1 = command = "holdfwd" && command = "y" 
trigger1 = p2bodydist X < 35

[State -1, throw]
type = ChangeState
value = 500
triggerall = statetype = S && ctrl && stateno != 100 && P2movetype != I && P2statetype != A
trigger1 = var(25) = 1
trigger1 = p2bodydist X < 35

[State -1, throw]
type = ChangeState
value = 510
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdback" && command = "y" 
trigger1 = p2bodydist X < 35

[State -1, throw]
type = ChangeState
value = 520
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdfwd" && command = "z" 
trigger1 = p2bodydist X < 35

[State -1, throw]
type = ChangeState
value = 530
triggerall = statetype = S && ctrl && stateno != 100
trigger1 = command = "holdback" && command = "z" 
trigger1 = p2bodydist X < 35


;==========================================================================================
;--------------------------------------------------------------------------
;C LP
[State -1, 300]
type = ChangeState
value = 300
triggerall = command = "x" && command = "holddown" &&  statetype = C
trigger1 = ctrl
trigger2 = stateno = 300 && movecontact
trigger3 = stateno = 300 && time >= 6
;C MP
[State -1, 305]
type = ChangeState
value = 305
triggerall = command = "y" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C HP
[State -1, 310]
type = ChangeState
value = 310
triggerall = command = "z" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C LK
[State -1, 320]
type = ChangeState
value = 320
triggerall = command = "a" && command = "holddown" &&  statetype = C
trigger1 = ctrl

;C MK
[State -1, 325]
type = ChangeState
value = 325
triggerall = command = "b" && command = "holddown" &&  statetype = C
trigger1 = ctrl
;
;AI
;C MK
[State -1, 325]
type = ChangeState
value = 325
triggerall = var(25) = 1 && statetype != A && p2bodydist X <= 45
trigger1 = ctrl
trigger1 = p2statetype != A
trigger1 =  p2movetype != H ;&& p2movetype != I
trigger1 = PrevStateNo != 325
trigger1 = random <= 100

;C HK
[State -1, 330]
type = ChangeState
value = 330
triggerall = command = "c" && command = "holddown" &&  statetype = C && var(25) = 0
trigger1 = ctrl

;=====================================================================================================
;basic PK
;
;
;NEAR STAND LP
[State -1, 200]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 220 || stateno = 260 || stateno = 200 || stateno = 240 )

;NEAR STAND MP
[State -1, 205]
type = ChangeState
value = 205
triggerall = command = "y" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND HP
[State -1, 210]
type = ChangeState
value = 210
triggerall = command = "z" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND LK
[State -1, 220]
type = ChangeState
value = 220
triggerall = command = "a" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl
trigger2 = stateno = 220 && movecontact

;NEAR STAND MK
[State -1, 225]
type = ChangeState
value = 225
triggerall = command = "b" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;NEAR STAND MK
[State -1, 225]
type = ChangeState
value = 225
triggerall = var(25) = 1 && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = p2statetype != A
trigger1 =  p2movetype != H ;&& p2movetype != I
trigger1 = PrevStateNo != 225
trigger1 = ctrl = 1
trigger1 = random <= 100

;NEAR STAND HK
[State -1, 230]
type = ChangeState
value = 230
triggerall = command = "c" && command != "holddown" && p2bodydist X <= 25 && statetype = S
trigger1 = ctrl

;==========================================================================================
;FAR STAND
;FAR STAND LP
[State -1, 240]
type = ChangeState
value = 240
triggerall = command = "x" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 220 || stateno = 260 || stateno = 200 || stateno = 240 )
trigger3 = time >=6 && ( stateno = 200 || stateno = 240 )

;FAR STAND MP
[State -1, 245]
type = ChangeState
value = 245
triggerall = command = "y" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;FAR STAND HP
[State -1, 250]
type = ChangeState
value = 250
triggerall = command = "z" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;FAR STAND LK
[State -1, 260]
type = ChangeState
value = 260
triggerall = command = "a" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl
trigger2 = movecontact && ( stateno = 220 || stateno = 260 )

;FAR STAND MK
[State -1, 265]
type = ChangeState
value = 265
triggerall = command = "b" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl 

;FAR STAND MK
[State -1, 265]
type = ChangeState
value = 265
triggerall = var(25) = 1 && p2bodydist X > 25 && statetype != A ;&& p2movetype != I
trigger1 = ctrl && random <= 50 && P2bodydist X <= 115

;FAR STAND HK
[State -1, 270]
type = ChangeState
value = 270
triggerall = command = "c" && command != "holddown" && p2bodydist X > 25 && statetype = S
trigger1 = ctrl

;FAR STAND HK
[State -1, 270]
type = ChangeState
value = 270
triggerall = var(25) = 1 && p2bodydist X > 25 && statetype = S
trigger1 = p2statetype != A ;&& p2movetype != I
trigger1 = PrevStateNo = 225
trigger1 = ctrl = 1
trigger2 = p2statetype != A ;&& p2movetype != I
trigger2 = p2bodydist X <= 115
trigger2 = random <= 50
trigger2 = ctrl = 1
trigger3 = p2statetype = A ;&& p2movetype != I
trigger3 = p2bodydist X = [70,80] 
trigger3 = p2bodydist Y <= 30
trigger3 = random <= 100
trigger3 = ctrl = 1

;==========================================================================================
;F/B JUMP LIGHT PUNCH
[State -1, 340]
type = ChangeState
value = 340
triggerall = command = "x" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP M PUNCH
[State -1, 345]
type = ChangeState
value = 345
triggerall = command = "y" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP H PUNCH
[State -1, 350]
type = ChangeState
value = 350
triggerall = command = "z" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP LIGHT K
[State -1, 355]
type = ChangeState
value = 355
triggerall = command = "a" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP MK
[State -1, 360]
type = ChangeState
value = 360
triggerall = command = "b" && statetype = A && vel X != 0
trigger1 = ctrl

;F/B JUMP HK
[State -1, 365]
type = ChangeState
value = 365
triggerall = command = "c" && statetype = A && vel X != 0
trigger1 = ctrl


;==========================================================================================
;JUMP LIGHT PUNCH
[State -1, 370]
type = ChangeState
value = 370
triggerall = command = "x" && statetype = A && vel X = 0
trigger1 = ctrl

;JUMP M PUNCH
[State -1, 375]
type = ChangeState
value = 375
triggerall = command = "y" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP H PUNCH
[State -1, 380]
type = ChangeState
value = 380
triggerall = command = "z" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP LIGHT K
[State -1, 385]
type = ChangeState
value = 385
triggerall = command = "a" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP MK
[State -1, 390]
type = ChangeState
value = 390
triggerall = command = "b" && statetype = A && vel X = 0
trigger1 = ctrl

; JUMP HK
[State -1, 395]
type = ChangeState
value = 395
triggerall = command = "c" && statetype = A && vel X = 0
trigger1 = ctrl


;==========================================================================================
[State -1];這是用來控制人物蹲下擋的
type = ChangeState
triggerall = P2stateno != 1301
triggerall = statetype != A && var(25) = 1 && movetype != H
trigger1 = Ctrl
trigger1 = StateType = S
trigger1 = P2StateType = C		;敵方是蹲下
trigger1 = P2MoveType = A		;攻擊而且
trigger1 = P2BodyDist X <= 100		;距離彼近時
;
trigger2 = ctrl = 1
trigger2 = P2MoveType = A;當敵方攻擊時
trigger2 = P2BodyDist X <= 100
trigger2 = PrevStateNo != 151;而之前又不是擋
trigger2 = PrevStateNo != 152
trigger2 = PrevStateNo != 153
value = 120			;就蹲下預備防禦

[State -1];剛與上面的東西相反, 是要人物站起來
type = ChangeState
triggerall = P2stateno != 1301
triggerall = statetype != A && var(25) = 1 
trigger1 = Ctrl
trigger1 = StateType = C
trigger1 = P2StateType = A
trigger1 = P2MoveType = A
trigger1 = P2BodyDist X <= 100
value = 121

[State -1]
type = ChangeState
triggerall = Var(25) = 1 && movetype != H && ctrl = 1
triggerall = statetype != A && ctrl = 1 && P2BodyDist X >= 0
triggerall = PrevStateNo != 151;而之前又不是擋
triggerall = PrevStateNo != 152
triggerall = PrevStateNo != 153
trigger1 = P2name ="ryu"&& (P2stateno=1100||P2stateno=1110||P2stateno=1120||P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger2 = P2name ="ken"&& ( P2stateno=1100||P2stateno=1110||P2stateno=1120 )
trigger3 = P2name ="chunli"&&(P2stateno=1200||P2stateno=1201||P2stateno=1202)
trigger4 = P2name ="guile"&&(P2stateno=1000||P2stateno=1010||stateno=1020)
trigger5 = P2name ="dhalsim"&&(P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger6 = P2name ="deejay"&&(P2stateno=1000||P2stateno=1010||P2stateno=1020)
trigger7 = P2name ="sagat"&&(P2stateno=1100||P2stateno=1110||P2stateno=1120||P2stateno=1000||P2stateno=1010||P2stateno=1020)
value = 120						;就進入擋格的 state






