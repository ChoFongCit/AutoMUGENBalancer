[Command]
Name = "waza1_light"
Command = ~60$B, $F, x
[Command]
Name = "waza1_middle"
Command = ~60$B, $F, y
[Command]
Name = "waza1_hard"
Command = ~60$B, $F, z
[Command]
Name = "waza2_light"
Command = ~60$D, $U, a
[Command]
Name = "waza2_middle"
Command = ~60$D, $U, b
[Command]
Name = "waza2_hard"
Command = ~60$D, $U, c

[Command]
Name = "waza1_light2"
Command = ~45$B, $F, x
[Command]
Name = "waza1_middle2"
Command = ~45$B, $F, y
[Command]
Name = "waza1_hard2"
Command = ~45$B, $F, z
[Command]
Name = "waza2_light2"
Command = ~45$D, $U, a
[Command]
Name = "waza2_middle2"
Command = ~45$D, $U, b
[Command]
Name = "waza2_hard2"
Command = ~45$D, $U, c

[Command]
Name = "waza1_light3"
Command = ~10$B, $F, x
[Command]
Name = "waza1_middle3"
Command = ~10$B, $F, y
[Command]
Name = "waza1_hard3"
Command = ~10$B, $F, z
[Command]
Name = "waza2_light3"
Command = ~10$D, $U, a
[Command]
Name = "waza2_middle3"
Command = ~10$D, $U, b
[Command]
Name = "waza2_hard3"
Command = ~10$D, $U, c

[Command]
Name = "o_waza1_fp"
Command = F, ~D, DF, x+y+z
Time = 20
[Command]
Name = "o_waza1_bp"
Command = B, ~D, DB, x+y+z
Time = 20
[Command]
Name = "o_waza1_fk"
Command = F, ~D, DF, a+b+c
Time = 20
[Command]
Name = "o_waza1_bk"
Command = B, ~D, DB, a+b+c
Time = 20

[Command]
Name = "FF"
Command = F, F
[Command]
Name = "BB"
Command = B, B

[Command]
Name = "a"
Command = a
Time = 1
[Command]
Name = "b"
Command = b
Time = 1
[Command]
Name = "c"
Command = c
Time = 1
[Command]
Name = "x"
Command = x
Time = 1
[Command]
Name = "y"
Command = y
Time = 1
[Command]
Name = "z"
Command = z
Time = 1

[Command]
Name = "start"
Command = s
Time = 1

[Command]
Name = "fwd"
Command = F
Time = 1
[Command]
Name = "back"
Command = B
Time = 1
[Command]
Name = "up" 
Command = U
Time = 1
[Command]
Name = "down"
Command = D
Time = 1

[Command]
Name = "holda"
Command = /$a
Time = 1
[Command]
Name = "holdb"
Command = /$b
Time = 1
[Command]
Name = "holdc"
Command = /$c
Time = 1

[Command]
Name = "holdfwd"
Command = /$F
Time = 1
[Command]
Name = "holdback"
Command = /$B
Time = 1
[Command]
Name = "holdup" 
Command = /$U
Time = 1
[Command]
Name = "holddown"
Command = /$D
Time = 1

[Command]
Name = "recovery"
Command = a+b+c+x+y+z+s
Time = 0

[StateDef -1]
[State -1];サマーソルトキック
Type = ChangeState
TriggerAll = (StateType!=A||Var(13)) && (Ctrl||(Var(10)=2&&StateNo=1)||StateNo=40||(Time<2&&StateNo=[200,399])||Var(6)>0||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0)) && Var(30) != 1 && RoundState = 2
Trigger1 = (Command="waza2_light"||Command="waza2_middle"||Command="waza2_hard") && Var(10) = 0
Trigger2 = (Command="waza2_light2"||Command="waza2_middle2"||Command="waza2_hard2") && Var(10) = 1
Trigger3 = (Command="waza2_light3"||Command="waza2_middle3"||Command="waza2_hard3") && Var(12) = -2
Trigger4 = (Command="a"||Command="b"||Command="c") && Command = "holdup" && Var(10) = 2
Value = IFelse(Command="waza2_light"||Command="waza2_light2"||Command="waza2_light3"||Command="a", 1100, IFelse(Command="waza2_middle"||Command="waza2_middle2"||Command="waza2_middle3"||Command="b", 1101, 1102))

[State -1];ソニックブーム
Type = ChangeState
TriggerAll=!NumProjID(1)&&(StateType!=A||Var(13))&&(Ctrl||(Var(10)=2&&StateNo=1)||(Time<2&&StateNo=[200,399])||Var(6)>0||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0))&&((Var(10)=2&&Helper(3000),Var(10)=0)||Var(10)!=2)&&Var(30)!=1&&RoundState=2
Trigger1 = (Command="waza1_light"||Command="waza1_middle"||Command="waza1_hard") && Var(10) = 0
Trigger2 = (Command="waza1_light2"||Command="waza1_middle2"||Command="waza1_hard2") && Var(10) = 1
Trigger3 = (Command="waza1_light3"||Command="waza1_middle3"||Command="waza1_hard3") && Var(12) = -2
Trigger4 = (Command="x"||Command="y"||Command="z") && Command="holdfwd" && Var(10) = 2
Value = IFelse(Command="waza1_light"||Command="waza1_light2"||Command="waza1_light3"||Command="x", 1000, IFelse(Command="waza1_middle"||Command="waza1_middle2"||Command="waza1_middle3"||Command="y", 1001, 1002))

[State -1];投げ
Type = ChangeState
Trigger1 = ((StateNo=20&&(Command="y"||Command="z"))||(StateNo=50&&(Command="holdfwd"||Command="holddown"||Command="holdback")&&(Command="b"||Command="c"||Command="y"||Command="z")))&&P2BodyDist X<(38*Const(Size.XScale)) && Var(30) != 1 && RoundState = 2
Value = IFelse(StateNo=20,IFelse(Command="y", 500, 510),IFelse(Command="b",534,IFelse(Command="c",530,IFelse(Command="y",525,520))))

[State -1];アレンジ時特殊攻撃
Type = ChangeState
Trigger1=(((Command="x"&&P2Dist X>(84*Const(Size.XScale)))||(Command="c"&&Command="holdfwd"))||(Command="c"&&P2Dist X<(85*Const(Size.XScale))))&&StateType=S&&(Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver))&&Var(10)=1&Var(30)!=1&RoundState=2
Value = IFelse(Command="x",201,IFelse(Command="holdfwd",IFelse(P2Dist X<(85*Const(Size.XScale)),260,252),253))
[State -1]
Type = ChangeState
Trigger1=((Command="z"&&Command!="holdfwd"&&P2Dist X>(84*Const(Size.XScale)))||(Command="b"&&(Command="holdfwd"||Command="holdback")))&&StateType=S&&(Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver))&&Var(10)=1&Var(30)!=1&RoundState=2
Value = IFelse(Command="z",222,240)
[State -1]
Type = ChangeState
Trigger1=((Command="a"&&Command="holdback")||(Command="c"&&Command="holdback"))&&StateType=S&&(Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver))&&Var(10)=1&Var(30)!=1&RoundState=2
Value = IFelse(Command="a",242,251)

[State -1];特殊攻撃
Type = ChangeState
Trigger1 = (((Command="b"&&Var(10)=0)||(Command="a"&&Var(10)=1)||(Command="c"&&P2BodyDist X<(66*Const(Size.XScale))))) && (Command="holdfwd"||Command="holdback") && StateType = S && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver))&&Var(30)!=1&&RoundState=2
Value = IFelse(Command="a"||Command="b",270,260)

[State -1];待ちガイル用特殊攻撃
Type = ChangeState
Trigger1 = (Command="b"||Command="c") && (Command="holdfwd"||Command="holdback") && (StateNo=1||(Var(12)=-2&&MoveType=H&&HitShakeOver))&&Var(10)=2&&Var(30)!=1&&RoundState=2
Value = IFelse(Command="b",270,260)

[State -1];立ちパンチ攻撃
Type = ChangeState
Trigger1 = (Command="x"||Command="y"||Command="z") && StateType = S && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="x",200,IFelse(Command="y",210+(P2BodyDist X<(38*Const(Size.XScale))),220+(P2BodyDist X<(60*Const(Size.XScale)))))
[State -1];立ちキック攻撃
Type = ChangeState
Trigger1 = (Command="a"||Command="b"||Command="c") && StateType = S && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="a",230,IFelse(Command="b",240+(P2BodyDist X<(38*Const(Size.XScale))),250+(P2BodyDist X<(38*Const(Size.XScale)))))
[State -1];しゃがみ攻撃
Type = ChangeState
Trigger1 = (Command="x"||Command="y"||Command="z"||Command="a"||Command="b"||Command="c") && StateType = C && (Ctrl||(Var(10)=2&&StateNo=1)||(Var(12)=-2&&MoveType=H&&HitShakeOver)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="x", 300, IFelse(Command="y", 310, IFelse(Command="z", 320, IFelse(Command="a", 330, IFelse(Command="b", 340, 350)))))
[State -1];空中パンチ攻撃
Type = ChangeState
Trigger1 = (Command="x"||Command="y"||Command="z") && StateType = A && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="x",IFelse(Vel X=0,400,401),IFelse(Command="y",IFelse(Vel X=0,410,411),IFelse(Vel X=0,420,421)))
[State -1];空中キック攻撃
Type = ChangeState
Trigger1 = (Command="a"||Command="b"||Command="c") && StateType = A && (Ctrl||(Var(12)=-2&&MoveType=H&&HitShakeOver&&Pos Y<=0)) && Var(30) != 1 && RoundState = 2
Value = IFelse(Command="a",IFelse(Vel X=0,430,431),IFelse(Command="b",IFelse(Vel X=0,440,441),450))
[State -1];同時押しスペシャル
Type = ChangeState
Trigger1 = Command = "a" && AnimElem = 2,>1 && (Command="x"||Command="y"||Command="z"||Command="holdup") && ((StateNo=230&&Command="holddown") || (Command!="holddown"&&StateNo=330)) && RoundState = 2
Value=IFelse(Command="holdup",40,IFelse(Command="holddown",IFelse(Command="x",300,IFelse(Command="y",310,320)),IFelse(Command="x",200,IFelse(P2Dist X<(85*Const(Size.XScale)),IFelse(Command="y",211,221),IFelse(Command="y",210,220)))))
[State -1];弱攻撃連打処理
Type = ChangeState
Trigger1 = (Command="x"&&((StateNo=[200,201])||StateNo=300)&&AnimElem=2,>=0) || (Command = "a" && ((StateNo=230||StateNo=330) && AnimElem = 3,>=0)) && RoundState = 2
Value = IFelse(Command="x", IFelse(Command="holddown"||Var(10)=2, 300, IFelse(P2Dist X>(84*Const(Size.XScale))&&Var(10),201,200)), IFelse(Command="holddown"||Var(10)=2, 330, 230))