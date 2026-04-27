; The CMD file.
;-l Ai Motion l------------------------------------------------------------

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,x
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,y
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,z
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,a
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,b
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,c
time = 1

[Command]
name = "cpu"
command = ~D,DB, B,D,DB, B,D,DB, B,D,DB, B,s
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,x
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,y
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,z
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,a
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,b
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,c
time = 1

[Command]
name = "cpu"
command = ~D,DF, F,D,DF, F,D,DF, F,D,DF, F,s
time = 1


;-| Super Motions |--------------------------------------------------------
[Command]
name = "TigerG_x"
command = ~D, DF, F, D, DF, F, x
time = 30

[Command]
name = "TigerG_y"
command = ~D, DF, F, D, DF, F, y
time = 30

[Command]
name = "TigerG_z"
command = ~D, DF, F, D, DF, F, z
time = 30

[Command]
name = "TigerG_x"
command = ~D, DF, F, D, DF, F, /x
time = 30

[Command]
name = "TigerG_y"
command = ~D, DF, F, D, DF, F, /y
time = 30

[Command]
name = "TigerG_z"
command = ~D, DF, F, D, DF, F, /z
time = 30
;-| Special Motions |------------------------------------------------------

[Command]
name = "TigerUpper_x"
command = ~F, D, DF, x
time = 15

[Command]
name = "TigerUpper_y"
command = ~F, D, DF, y
time = 15

[Command]
name = "TigerUpper_z"
command = ~F, D, DF, z
time = 15

[Command]
name = "TigerUpper_x"
command = ~F, D, DF, ~x
time = 15

[Command]
name = "TigerUpper_y"
command = ~F, D, DF, ~y
time = 15

[Command]
name = "TigerUpper_z"
command = ~F, D, DF, ~z
time = 15




[Command]
name = "TigerKnee_a"
command = ~F, D, DF, a
time = 15

[Command]
name = "TigerKnee_b"
command = ~F, D, DF, b
time = 15

[Command]
name = "TigerKnee_c"
command = ~F, D, DF, c
time = 15


[Command]
name = "TigerKnee_a"
command = ~F, D, DF, ~a
time = 15

[Command]
name = "TigerKnee_b"
command = ~F, D, DF, ~b
time = 15

[Command]
name = "TigerKnee_c"
command = ~F, D, DF, ~c
time = 15


[Command]
name = "shot_x"
command = ~D, DF, F, x
time = 10

[Command]
name = "shot_y"
command = ~D, DF, F, y
time = 10

[Command]
name = "shot_z"
command = ~D, DF, F, z
time = 10

[Command]
name = "shot_x"
command = ~D, DF, F, ~x
time = 10

[Command]
name = "shot_y"
command = ~D, DF, F, ~y
time = 10

[Command]
name = "shot_z"
command = ~D, DF, F, ~z
time = 10


[Command]
name = "shot_a"
command = ~D, DF, F, a
time = 10

[Command]
name = "shot_b"
command = ~D, DF, F, b
time = 10

[Command]
name = "shot_c"
command = ~D, DF, F, c
time = 10

[Command]
name = "shot_a"
command = ~D, DF, F, ~a
time = 10

[Command]
name = "shot_b"
command = ~D, DF, F, ~b
time = 10

[Command]
name = "shot_c"
command = ~D, DF, F, ~c
time = 10


[Command]
name = "ZC"
command = /$F, z+c
time = 3

;----------------------------------------------------------

[Command]
name="hold_a"
command=/a
time=1

[Command]
name="hold_b"
command=/b
time=1

[Command]
name="hold_c"
command=/c
time=1

[Command]
name="hold_x"
command=/x
time=1

[Command]
name="hold_y"
command=/y
time=1

[Command]
name="hold_z"
command=/z
time=1

[Command]
name = "fwd_y"
command = /F,y
time = 1

[Command]
name = "fwd_z"
command = /F,z
time = 1

[Command]
name = "back_y"
command = /B,y
time = 1

[Command]
name = "back_z"
command = /B,z
time = 1

[Command]
name = "Nak"
command = a+b+c
time = 1

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
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
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

;-| Hold Dir |--------------------------------------------------------------
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
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]








;---------------------------------------------------------------------------
[State -1, Tiger Genocide]
type = ChangeState
value = ifelse(palno>6,0,ifelse(palno<=6,4100,1))
triggerall = command="TigerG_x" || command="TigerG_y" || command="TigerG_z"
triggerall = numproj = 0
triggerall = command != "holddown"
triggerall = power >= 1000
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 270

;---------------------------------------------------------------------------
[State -1, Tiger Uppercut]
type = ChangeState
value = 1300
triggerall = command = "TigerUpper_x"
;triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1
trigger8 = stateno = 450
trigger8 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Uppercut]
type = ChangeState
value = 1400
triggerall = command = "TigerUpper_y"
;triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Uppercut]
type = ChangeState
value = ifelse(palno>6,1600,ifelse(palno<=6,1500,1))
triggerall = command = "TigerUpper_z"
;triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Knee]
type = ChangeState
value = 2000
triggerall = command = "TigerKnee_a"
;triggerall = numproj = 0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl || (stateno = 40)
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1
trigger8 = stateno = 450
trigger8 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Knee]
type = ChangeState
value = 2100
triggerall = command = "TigerKnee_b"
;triggerall = numproj = 0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl || (stateno = 40)
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1
trigger8 = stateno = 450
trigger8 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Knee]
type = ChangeState
value = 2200
triggerall = command = "TigerKnee_c"
;triggerall = numproj = 0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl || (stateno = 40)
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 260
trigger6 = movecontact = 1
trigger7 = stateno = 270
trigger7 = movecontact = 1
trigger8 = stateno = 450
trigger8 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1000
triggerall = command = "shot_x"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1010
triggerall = command = "shot_y"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1020
triggerall = command = "shot_z"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1100
triggerall = command = "shot_a"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1110
triggerall = command = "shot_b"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1

;---------------------------------------------------------------------------
[State -1, Tiger Shot]
type = ChangeState
value = 1120
triggerall = command = "shot_c"
triggerall = numproj = 0
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1
trigger5 = stateno = 250
trigger5 = movecontact = 1
trigger6 = stateno = 300
trigger6 = movecontact = 1
trigger7 = stateno = 310
trigger7 = movecontact = 1
trigger8 = stateno = 420
trigger8 = movecontact = 1
trigger9 = stateno = 460
trigger9 = movecontact = 1
trigger10 = stateno = 450
trigger10 = movecontact = 1
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; Throw
[State -1, Throw]
type = ChangeState
value = 800
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 7
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 10
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H
;---------------------------------------------------------------------------
;Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = p2bodydist x >= 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Stand middle Punch
[State -1, Stand middle Punch]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = p2bodydist x >= 25
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 700
trigger3 = movecontact = 1
trigger4 = stateno = 710
trigger4 = movecontact = 1

;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 220
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = p2bodydist x >= 25
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact = 1
trigger3 = stateno = 700
trigger3 = movecontact = 1
trigger4 = stateno = 710
trigger4 = movecontact = 1

;---------------------------------------------------------------------------
;Stand Light Kick
[State -1, Stand Light Kick]
type = ChangeState
value = 250
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Stand middle Kick
[State -1, Stand middle Kick]
type = ChangeState
value = 260
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 250
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1

;---------------------------------------------------------------------------
;Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 270
triggerall = command = "c"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 720
trigger4 = movecontact = 1

;---------------------------------------------------------------------------
;Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl



;---------------------------------------------------------------------------
;Crouching middle Punch
[State -1, Crouching middle Punch]
type = ChangeState
value = 410
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = stateno = 400
trigger2 = movecontact = 1

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 420
triggerall = command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = stateno = 400
trigger2 = movecontact = 1

;---------------------------------------------------------------------------
;Crouching Light Kick
[State -1, Crouching Light Kick]
type = ChangeState
value = 450
triggerall = command = "a"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl


;---------------------------------------------------------------------------
;Crouching middle Kick
[State -1, Crouching middle Kick]
type = ChangeState
value = 460
triggerall = command = "b"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = stateno = 400
trigger2 = movecontact = 1
trigger3 = stateno = 450
trigger3 = movecontact = 1

;---------------------------------------------------------------------------
;Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 470
triggerall = command = "c"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = stateno = 400
trigger2 = movecontact = 1
trigger3 = stateno = 450
trigger3 = movecontact = 1

;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump middle Punch
[State -1, Jump middle Punch]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = command != "holddown"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 620
triggerall = command = "z"
triggerall = command != "holddown"
trigger1 = statetype = A
trigger1 = ctrl



;---------------------------------------------------------------------------
;Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 650
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = vel X != 0
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump middle Kick
[State -1, Jump middle Kick]
type = ChangeState
value = 660
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = A
trigger1 = ctrl



;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 670
triggerall = command = "c"
triggerall = command != "holddown"
trigger1 = statetype = A
trigger1 = ctrl



;=======================================================

;------------------------------------------------------------
; Light Kick (Air/Moving)
[State -1]
type = ChangeState
value = 680
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = Vel X = 0
trigger1 = statetype = A
trigger1 = ctrl = 1


;---------------------------------------------------------------------------
;Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 700
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Stand middle Punch
[State -1, Stand middle Punch]
type = ChangeState
value = 710
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = p2bodydist x < 25
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1

;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 720
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = p2bodydist x < 25
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 700
trigger2 = movecontact = 1
trigger3 = stateno = 710
trigger3 = movecontact = 1
trigger4 = stateno = 250
trigger4 = movecontact = 1



;---------------------------------------------------------------------------


;---------------------------------------------------------------------------

[State -1]
type = ChangeState
value = 0
triggerall = Var(55) = 1
triggerall = statetype = S
triggerall = P2movetype != A
triggerall = P2bodydist X >= 100
trigger1 = ctrl
triggerall = P2StateNo = 5050  
triggerall = P2StateNo = 5070  
triggerall = P2StateNo = 5100  
triggerall = P2StateNo = 5110  
triggerall = P2StateNo = 5120  
triggerall = P2StateNo = 5160 
triggerall = P2StateNo = 5170  
triggerall = Random >= 900


[State -1]
type = ChangeState
value = 130
triggerall = Var(55) = 1
triggerall = Statetype != A
triggerall = P2Movetype = A 
triggerall = P2statetype != C
triggerall = enemy, NumProj >= 1
trigger1 = Ctrl = 1
triggerall = Random >= 999

[State -1]
type = ChangeState
value = 131
triggerall = Var(55) = 1
triggerall = StateType != A
triggerall = P2Statetype = C
triggerall = P2Movetype = A
triggerall = enemy, NumProj >= 1
trigger1 = Ctrl = 1
triggerall = random >= 999

[State -1]
type = ChangeState
value = 132
triggerall = Var(55) = 1
triggerall = StateType = A
triggerall = P2Movetype = A
triggerall = enemy, NumProj >= 1
trigger1 = Ctrl = 1
triggerall = random >= 999

[State -1]
type = ChangeState
value = 980
triggerall = Var(55) = 1
triggerall = StateType != S
triggerall = StateType != L
triggerall = P2life != 0
triggerall = Alive = 1
triggerall = Random <= 100
triggerall = Pos Y = [-10,0]
trigger1 = stateno = 5050 || stateno = 5071

[State -1]
type = ChangeState
value = 40
triggerall = Var(55) = 1
triggerall = (StateType != A) && (StateType != L)
triggerall = (P2MoveType = A) && (P2StateType != A) && (enemy, NumProj >= 1)
triggerall = StateNo != 40
trigger1 = Ctrl = 1

[State -1]
type = ChangeState
value = 450
triggerall = Var(55) = 1
triggerall = MoveType != H
triggerall = statetype = S
trigger1 = ctrl  = 1
triggerall = P2bodydist X <= 30
triggerall = P2stateno = 5150

[State -1]
type = ChangeState
value = 670
triggerall = Var(55) = 1
triggerall = MoveType != H
triggerall = statetype = A
trigger1 = ctrl  = 1
triggerall = P2bodydist X <= 30


[State -1,]
type = ChangeState
value = 700
triggerall = Var(55) = 1
triggerall = StateType = S
triggerall = (EnemyNear, StateType != A) && (EnemyNear, StateType != C)
triggerall = MoveType != H
triggerall = P2life != 0
trigger1 = EnemyNear, MoveType != H
trigger1 = P2BodyDist X <= 25
trigger1 = Ctrl = 1
triggerall = Random <= 600

[State -1]
type = ChangeState
value = 1000
triggerall = Var(55) = 1
triggerall = statetype = S
trigger1 = P2bodydist X = [100,250]
triggerall = ctrl = 1
triggerall = random <= 300 
triggerall = P2StateNo != 5050  
triggerall = P2StateNo != 5070  
triggerall = P2StateNo != 5100  
triggerall = P2StateNo != 5110  
triggerall = P2StateNo != 5120  
triggerall = P2StateNo != 5160  
triggerall = P2StateNo != 5170 
trigger1 = P2statetype = S

[State -1]
type = ChangeState
value = 1100
triggerall = Var(55) = 1
triggerall = statetype = S
trigger1 = P2bodydist X = [100,250]
triggerall = ctrl = 1
triggerall = random <= 300
;triggerall = P2Movetype != A  
;triggerall = P2StateType != L  
triggerall = P2StateNo != 5050  
triggerall = P2StateNo != 5070  
triggerall = P2StateNo != 5100  
triggerall = P2StateNo != 5110  
triggerall = P2StateNo != 5120  
triggerall = P2StateNo != 5160 
triggerall = P2StateNo != 5170  
trigger1 = P2statetype = S


[State -1]
type = ChangeState
value = 1300
triggerall = Var(55) = 1
triggerall = statetype = S
trigger1 = ctrl = 1
triggerall = P2Movetype = A 
trigger1 = P2bodydist X <= 70
triggerall = P2life != 0
triggerall = random <= 200
triggerall = P2StateNo != 5050  
triggerall = P2StateNo != 5070  
triggerall = P2StateNo != 5100  
triggerall = P2StateNo != 5110  
triggerall = P2StateNo != 5120  
triggerall = P2StateNo != 5160  
triggerall = P2StateNo != 5170 
triggerall = P2stateno != 5030
triggerall = P2stateno != 5020
triggerall = P2stateno != 5050
triggerall = P2stateno != 5150

[State -1]
type = ChangeState
value = 1400
triggerall = Var(55) = 1
triggerall = statetype = S
trigger1 = ctrl = 1
triggerall = P2bodydist X <= 80
triggerall = P2life != 0
triggerall = random <= 150
triggerall = P2StateNo != 5050  
triggerall = P2StateNo != 5070  
triggerall = P2StateNo != 5100  
triggerall = P2StateNo != 5110  
triggerall = P2StateNo != 5120  
triggerall = P2StateNo != 5160  
triggerall = P2StateNo != 5170 
triggerall = P2stateno != 5030
triggerall = P2stateno != 5020
triggerall = P2stateno != 5050
triggerall = P2stateno != 5150

[State -1]
type = ChangeState
value = 1500
triggerall = Var(55) = 1
triggerall = statetype = S
trigger1 = ctrl = 1
triggerall = P2bodydist X <= 90
triggerall = P2BodyDist Y = [-160,-30]
triggerall = P2life != 0
triggerall = random <= 150
triggerall = P2StateNo != 5050  
triggerall = P2StateNo != 5070  
triggerall = P2StateNo != 5100  
triggerall = P2StateNo != 5110  
triggerall = P2StateNo != 5120  
triggerall = P2StateNo != 5160  
triggerall = P2StateNo != 5170 
triggerall = P2stateno != 5030
triggerall = P2stateno != 5020
triggerall = P2stateno != 5050
triggerall = P2stateno != 5150

[State -1]
type = ChangeState
value = 2000
triggerall = Var(55) = 1
triggerall = statetype = S
triggerall = P2bodydist X = [5,50]
triggerall = random <= 400
triggerall = ctrl
trigger1 = P2dist Y = [-55,0]
trigger1 = Stateno = 720
trigger1 = Movecontact = 1
trigger2 = Stateno = 270
trigger2 = Movecontact = 1

[State -1]
type = ChangeState
value = 2100
triggerall = Var(55) = 1
triggerall = statetype = S
triggerall = P2bodydist X = [5,55]
triggerall = random <= 400
triggerall = ctrl
trigger1 = P2dist Y = [-55,0]
trigger2 = P2movetype = A
trigger1 = Stateno = 720
trigger1 = Movecontact = 1
trigger2 = Stateno = 270
trigger2 = Movecontact = 1

[State -1]
type = ChangeState
value = 2200
triggerall = Var(55) = 1
triggerall = statetype = S
triggerall = P2bodydist X = [5,60]
triggerall = random <= 400
triggerall = ctrl
trigger1 = P2dist Y = [-55,0]
trigger2 = P2movetype = A
trigger1 = Stateno = 720
trigger1 = Movecontact = 1
trigger2 = Stateno = 270
trigger2 = Movecontact = 1

[State -1]
type = ChangeState
value = 4000
triggerall = Var(55) = 1
triggerall = P2statetype = S
triggerall = power >= 1000
triggerall = statetype = S
triggerall = movetype = I
triggerall = P2BodyDist X = [40,90]
trigger1 = Stateno = 720
trigger1 = Movecontact = 1
trigger2 = Stateno = 270
trigger2 = Movecontact = 1

[State -1]
type = ChangeState
value = 800
triggerall = Var(55) = 1
triggerall = P2StateType != A
trigger1 = P2statetype = S
triggerall = P2movetype = I
triggerall = statetype = S
triggerall = movetype = I
triggerall = P2BodyDist X = [0,20]
triggerall = P2stateno != 5030
triggerall = P2stateno != 5020
triggerall = P2stateno != 5050
triggerall = p2stateno != 5000
triggerall = p2stateno != 5001
trigger1 = Random <= 700






