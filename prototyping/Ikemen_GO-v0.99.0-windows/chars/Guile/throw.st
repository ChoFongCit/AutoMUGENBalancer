[StateDef 500];ジュードースルー
Type = S
MoveType = A
Physics = N
Ctrl = 0
VelSet = 0

[State 500]
Type = HitDef
Trigger1 = Time = 0
Attr = S, NT
HitFlag = M-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Ground.Velocity = 3.5*Const(Size.XScale), -3
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 501
P2StateNo = 502
P1Facing = IFelse(Command="holdback", 1, -1)
P2Facing = 1

[State 500]
Type = ChangeState
Trigger1 = Time = 1
Value = IFelse(P2Dist X>(84*Const(Size.XScale)),210,211)

[StateDef 501];ジュードースルー中
Type = S
MoveType = A
Physics = S
Ctrl = 0
VelSet = 0
Anim = 500

[State 501]
Type = Turn
Trigger1 = AnimTime = 0

[State 501]
Type = Width
Trigger1 = AnimElem = 5
Value = 0, Floor(120*Const(Size.XScale))

[State 501]
Type = TargetBind
Trigger1 = Time = 0 || AnimElem = 2 || AnimElem = 3 || AnimElem = 4
ID = 1
Pos = IFelse(Time=0,48,IFelse(AnimElem=2,0,46,IFelse(AnimElem=3,0,51,-58)))*Const(Size.XScale), IFelse(Time=0,0,IFelse(AnimElem=2,0,-81,IFelse(AnimElem=3,0,-91,-54)))
[State 501]
Type = TargetBind
Trigger1 = AnimElem = 5 || AnimElem = 5,1
ID = 1
Pos = IFelse(AnimElem=5,0,-108,-118)*Const(Size.XScale), IFelse(AnimElem=5,0,-40,-50)

[State 501]
Type = ChangeState
Trigger1 = AnimTime = 0
Value = 0
Ctrl = 1

[StateDef 502];ジュードースられる相手
Type = S
MoveType = H
Physics = S
VelSet = 0, 0
SprPriority = -1

[State 502]
Type = ChangeAnim2
Trigger1 = Time = 0
Value = 501 + (Name="SF2'ガイル")

[State 502]
Type = ScreenBound
Trigger1 = AnimElem = 5,<0
Value = 0

[State 502]
Type = ChangeState
Trigger1 = AnimElem = 5,3
Value = 503

[StateDef 503];ジュードースられる相手開放
Type = A
MoveType = H
Physics = N

[State 503]
Type = HitVelSet
Trigger1 = Time = 0 && PrevStateNo != 505
X = 1
Y = 1
[State 503]
Type = VelAdd
Trigger1 = 1
Y = .2

[State 503]
Type = LifeAdd
Trigger1 = ((Vel Y > 0 &&  Pos Y >= 15) || (Life <= Floor(266/(Const(Data.Defence)/100)))) && PrevStateNo != 505
Persistent = 0
Value = IFelse((Life<=Floor(266/(Const(Data.Defence)/100))), -1000, -266)

[State 503]
Type = ChangeState
TriggerAll = FrontEdgeDist < 2 && Time > 0 && PrevStateNo != 505
Trigger1 = Name="SSF2Xリュウ"||Name="SF2'リュウ"||Name="SF2'ケン"||Name="SF2'サガット"||Name="SF2'ガイル"||Name="SF2'春麗"||Name="SF2'ザンギエフ"||(Name="SSF2Xダルシム"&&!Var(10))
Trigger2 = Name="SF2'ベガ"||Name="SF2'ブランカ"
Value = 505

[State 503]
Type = SelfState
Trigger1 = Vel Y > 0 &&  Pos Y >= 20
Value = 5100

[StateDef 505];相手降下中の画面端引っ掛かり
Type = A
MoveType = H
Physics = N

[State 505]
Type = VelSet
Trigger1 = Time = 0
Y = 0

[State 505]
Type = PosFreeze
Trigger1 = 1

[State 505]
Type = NotHitBy
Trigger1 = 1
Value = SCA

[State 505]
Type = PlaySnd
Trigger1 = Time = 0
Value = 0+(Var(10)&&Name="SSF2Xリュウ")*2, 11+(Var(10)&&Name="SSF2Xリュウ")

[State 505]
Type = Explod
Trigger1 = Time = 0 && Name = "SSF2Xリュウ" && Var(10)
Anim = 96-TeamSide
Pos = 0, 0
PosType = P1
SprPriority = -10
OwnPal = 1
Facing = -1
RemoveOnGetHit = 1
Scale = Const(Size.XScale), 1

[State 505]
Type = LifeAdd
Trigger1 = Time = 0 && PrevStateNo != 513
Value = -266

[State 505]
Type = ChangeState
Trigger1 = Time = 12 || (Time = 4 && (Var(10)&&Name="SSF2Xリュウ"))
Value = PrevStateNo

[StateDef 510];ドラゴンスープレックス
Type = S
MoveType = A
Physics = S
Ctrl = 0
VelSet = 0

[State 510]
Type = HitDef
Trigger1 = Time = 0
Attr = S, NT
HitFlag = M-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Ground.Velocity = 1.5*Const(Size.XScale), -5
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 511
P2StateNo = 512
P1Facing = IFelse(Command="holdback", 1, -1)
P2Facing = 1

[State 510]
Type = ChangeState
Trigger1 = Time = 1
Value = IFelse(Var(10)=1&&Command!="holdfwd",222,IFelse(P2Dist X>(84*Const(Size.XScale))||(Var(10)=1&&Command="holdfwd"),220,221))

[StateDef 511];ドラゴンスープレックス中
Type = S
MoveType = A
Physics = S
Ctrl = 0
Anim = 510

[State 511]
Type = Turn
Trigger1 = AnimTime = 0

[State 511]
Type = Width
Trigger1 = AnimElem = 4
Value = 0, Floor(120*Const(Size.XScale))

[State 511]
Type = TargetBind
Trigger1 =  Time = 0 || AnimElem = 2 || AnimElem = 3
ID = 1
Pos = IFelse(Time=0,26,IFelse(AnimElem=2,0,-5,-65))*Const(Size.XScale), IFelse(Time=0,0,IFelse(AnimElem=2,0,-83,-74))
[State 501]
Type = TargetBind
Trigger1 = AnimElem = 4 || AnimElem = 4,13
ID = 1
Pos = IFelse(AnimElem=4,0,-114,-108)*Const(Size.XScale), IFelse(AnimElem=4,0,-10,-29)

[State 511]
Type = Explod
Trigger1 = AnimElem = 4,3
Anim = 54+TeamSide + (Var(12)=-1)*10
Pos = Floor(-128*Const(Size.XScale)), -2
PosType = P1
Facing = -1
SprPriority = 2

[State 511]
Type = EnvShake
Trigger1 = AnimElem = 4,3
Freq = 135
Ampl = -3
Time = 60
Phase = 0

[State 511]
Type = PlaySnd
Trigger1 = AnimElem = 4,3
Value = 0, 11

[State 511]
Type = ChangeState
Trigger1 = AnimTime = 0
Value = 0
Ctrl = 1

[StateDef 512];ドラゴンスープられる相手
Type = S
MoveType = H
Physics = S
VelSet = 0, 0
SprPriority = -1

[State 512]
Type = ChangeAnim2
Trigger1 = Time = 0
Value = 511

[State 512]
Type = Turn
Trigger1 = AnimElem = 2

[State 512]
Type = LifeAdd
Trigger1 = AnimElem = 4,3
Value = -266

[State 502]
Type = ScreenBound
Trigger1 = 1
Value = 0

[State 512]
Type = ChangeState
Trigger1 = AnimElem = 5,2
Value = 513

[StateDef 513];ドラゴンスープられる相手解放
Type = A
MoveType = H
Physics = N

[State 513]
Type = Turn
Trigger1 = Vel Y > 0 &&  Pos Y >= -5

[State 513]
Type = HitVelSet
Trigger1 = Time = 0 && PrevStateNo != 505
X = 1
Y = 1
[State 513]
Type = VelAdd
Trigger1 = 1
Y = .2

[State 513]
Type = ChangeState
TriggerAll = BackEdgeDist < 2 && Time > 0 && PrevStateNo != 505
Trigger1 = Name="SSF2Xリュウ"||Name="SF2'リュウ"||Name="SF2'ケン"||Name="SF2'サガット"||Name="SF2'ガイル"||Name="SF2'春麗"||Name="SF2'ザンギエフ"||(Name="SSF2Xダルシム"&&!Var(10))
Trigger2 = Name="SF2'ベガ"||Name="SF2'ブランカ"
Value = 505

[State 513]
Type = SelfState
Trigger1 = Vel Y > 0 &&  Pos Y >= -15
Value = 5100

[StateDef 520];フライングメイヤー
Type = A
MoveType = A
Physics = A
Ctrl = 0

[State 520]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 520 + (Vel X!=0)

[State 520]
Type = HitDef
Trigger1 = Time = 0 && EnemyNear,StateNo != [5020, 5099]
Attr = A, NT
HitFlag = A-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 521
P2StateNo = 522
P1Facing = IFelse(Command="holdback", -1, 1)
P2Facing = 1

[State 520]
Type = ChangeState
Trigger1 = Time = 1
Value = 420 + (Vel X!=0)

[StateDef 521];フライングメイヤー中
Type = A
MoveType = A
Physics = N
Ctrl = 0
Anim = 522

[State 521]
Type = PosFreeze
Trigger1 = Time < 13

[State 521]
Type = Width
Trigger1 = Time = 0
Value = Floor(60*Const(Size.XScale)), 0

[State 521]
Type = VelAdd
Trigger1 = Time > 12 && Pos Y < 0
Y = .29

[State 521]
Type = VelSet
Trigger1 = Pos Y > 0
X = 0
Y = 0
[State 521]
Type = PosSet
Trigger1 = Pos Y > 0
Y = 0

[State 521]
Type = ChangeAnim
Trigger1 = Pos Y = 0 && AnimElem = 4,<3
Persistent = 0
Value = 522
Elem = 4

[State 521]
Type = TargetBind
Trigger1 = AnimElem = 4,<3
ID = 1
Pos = IFelse((AnimElem=2,<0),32,IFelse((AnimElem=3,<0),17,IFelse((AnimElem=4,<0),50,40))), IFelse((AnimElem=2,<0),-87,IFelse((AnimElem=3,<0),-96,IFelse((AnimElem=4,<0),-50,20-(Pos Y>=20)*20)))

[State 521]
Type = TargetState
Trigger1 = AnimElem = 4,>3 || (Pos Y=0&&AnimElem=4,1)
Persistent = 0
ID = 1
Value = 523

[State 521]
Type = ChangeState
Trigger1 = (Pos Y >= 0 && AnimElem = 4,>3) || (Pos Y=0&&AnimElem=4,1)
Value = 1103

[StateDef 522];フライングメイヤられる相手
Type = S
MoveType = H
Physics = N
VelSet = 0, 0
SprPriority = -1

[State 522]
Type = ChangeAnim2
Trigger1 = Time = 0
Value = 523 + (Name="SF2'ガイル")
[State 522]
Type = ChangeAnim2
Trigger1 = Pos Y >= 0
Value = 523 + (Name="SF2'ガイル")
Elem = 4

[State 522]
Type = ScreenBound
Trigger1 = 1
Value = 0

[StateDef 523];フライングメイヤられる相手解放へ
Type = A
MoveType = H
Physics = N
VelSet = 0, 0

[State 523]
Type = VelSet
Trigger1 = Time = 3
X = -3
Y = 7

[State 523]
Type = VelAdd
Trigger1 = Time > 2
Y = .25

[State 523]
Type = LifeAdd
Trigger1 = Life <= Floor(322/(Const(Data.Defence)/100))
Value = -10000

[State 523]
Type = ChangeState
Trigger1 = Vel Y > 0 && Pos Y >= 20
Value = 524

[StateDef 524];フライングメイヤられる相手体力減らして解放
Type = S
MoveType = H
Physics = N

[State 524]
Type = EnvShake
Trigger1 = Time = 0
Freq = 135
Ampl = -3
Time = 60
Phase = 0

[State 524]
Type = VelSet
Trigger1 = Time = 0
Y = 0

[State 524]
Type = LifeAdd
Trigger1 = Time = 0
Value = -322

[State 524]
Type = SelfState
Trigger1 = Time = 1
Value = 5100

[StateDef 525];フライングメイヤー 中パンチ時
Type = A
MoveType = A
Physics = A
Ctrl = 0

[State 525]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 520 + (Vel X!=0)

[State 525]
Type = HitDef
Trigger1 = Time = 0 && EnemyNear,StateNo != [5020, 5099]
Attr = A, NT
HitFlag = A-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 521
P2StateNo = 522
P1Facing = IFelse(Command="holdback", -1, 1)
P2Facing = 1

[State 525]
Type = ChangeState
Trigger1 = Time = 1
Value = 410 + (Vel X!=0)

[StateDef 530];フライングバスタードロップ
Type = A
MoveType = A
Physics = A
Ctrl = 0

[State 530]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 532

[State 530]
Type = HitDef
Trigger1 = Time = 0 && EnemyNear,StateNo != [5020,5099]
Attr = A, NT
HitFlag = A-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 531
P2StateNo = 532
P1Facing = IFelse(Command="holdback", -1, 1)
P2Facing = 1

[State 530]
Type = ChangeState
Trigger1 = Time = 1
Value = 450

[StateDef 531];フライングバスタードロップ中
Type = A
MoveType = A
Physics = N
Ctrl = 0

[State 531]
Type = TargetState
Trigger1 = Time = 0 && PrevStateNo = 531
ID = 1
Value = 533

[State 531]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 533
Elem = 1 + (PrevStateNo=531)

[State 531]
Type = PosFreeze
Trigger1 = Time < 13

[State 531]
Type = VelSet
Trigger1 = (Time = 13 && PrevStateNo != 531) || (Time = 0 && PrevStateNo = 531)
X = IFelse(Time=0||Vel X=0, 0, IFelse(Vel X<0, .2, -.2))
Y = 0
[State 531]
Type = VelAdd
Trigger1 = Time > 13 && PrevStateNo != 531
Y = .29

[State 531]
Type = PosSet
Trigger1 = Time = 0 && PrevStateNo = 531
Y = 0

[State 531]
Type = TargetBind
Trigger1 = PrevStateNo != 531
Pos = IFelse(Time<17, 24, IFelse(Time<22, 27, 18)), IFelse(Time<22, -95, -98)
[State 531]
Type = TargetBind
Trigger1 = PrevStateNo = 531 && (Time=0||Time=13)
Pos = IFelse(Time=0, 12, 23), IFelse(Time=0, -64, -47)

[State 531]
Type = PlaySnd
Trigger1 = Time = 0 && PrevStateNo = 531
Value = 0, 11

[State 531]
Type = Explod
Trigger1 = Time = 3 && PrevStateNo = 531
Anim = 54+TeamSide + (Var(12)=-1)*10
Pos = Floor(20*Const(Size.XScale)), -62
PosType = P1
SprPriority = 2

[State 531]
Type = EnvShake
Trigger1 = Time = 3 && PrevStateNo = 531
Freq = 135
Ampl = -3
Time = 60
Phase = 0

[State 531]
Type = ChangeState
Trigger1 = (Pos Y>=0&&PrevStateNo!=531) || (AnimTime=0&&PrevStateNo=531)
Value = 531 - (PrevStateNo=531)*531
Ctrl = 0 + (PrevStateNo=531)

[StateDef 532];フライングバスタードロップられる相手
Type = S
MoveType = H
Physics = S
VelSet = 0, 0
SprPriority = -1

[State 532]
Type = ChangeAnim2
Trigger1 = Time = 0
Value = 534 + (Name="SF2'ガイル")

[State 532]
Type = Turn
Trigger1 = Time = 17 || AnimElem = 2

[State 532]
Type = Turn
Trigger1 = AnimElem = 2

[State 532]
Type = ScreenBound
Trigger1 = 1
Value = 0

[StateDef 533];フライングバスタードロップられる相手解放
Type = A
MoveType = H
Physics = N
VelSet = 0, 0

[State 533]
Type = ChangeAnim2
Trigger1 = Time = 0
Value = 534 + (Name="SF2'ガイル")
Elem = 3

[State 533]
Type = VelSet
Trigger1 = AnimElem = 4,3
X = -2
Y = -5
[State 533]
Type = VelAdd
Trigger1 = AnimElem = 4,>3
Y = .25

[State 533]
Type = LifeAdd
Trigger1 = Time = 0
Value = -322

[State 533]
Type = SelfState
Trigger1 = Vel Y > 0 && Pos Y >= 20
Value = 5100

[StateDef 534];フライングバスタードロップ 中キック時
Type = A
MoveType = A
Physics = A
Ctrl = 0

[State 534]
Type = ChangeAnim
Trigger1 = Time = 0
Value = 530 + (Vel X!=0)

[State 534]
Type = HitDef
Trigger1 = Time = 0 && EnemyNear,StateNo != [5020,5099]
Attr = A, NT
HitFlag = A-
Priority = 0, Miss
Damage = 0
GetPower = 0
GivePower = 0
NumHits = 0
SparkNo = -1
HitSound = -1
AnimType = Light
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
ID = 1
P1StateNo = 531
P2StateNo = 532
P1Facing = IFelse(Command="holdback", -1, 1)
P2Facing = 1

[State 534]
Type = ChangeState
Trigger1 = Time = 1
Value = 440 + (Vel X!=0)

[StateDef 4000];気絶直前 倒れ
Type = A
MoveType = H
Physics = N
SprPriority = -1

[State 4000]
Type = ChangeAnim
Trigger1 = (Time = 0 && PrevStateNo != 5042) || (Anim=5030&&HitShakeOver)
IgnoreHitPause = 1
Value = IFelse(Time=0, 5030, 5050)

[State 4000]
Type = VelSet
Trigger1 = Time = 0 && PrevStateNo != 5042
X = 0
Y = 0

[State 4000]
Type = NotHitBy
Trigger1 = 1
IgnoreHitPause = 1
Value = SCA

[State 4000]
Type = HitVelSet
Trigger1 = HitShakeOver && PrevStateNo != 5042 && GetHitVar(YVel) < 0
Persistent = 0
X = 1
Y = 1
[State 4000]
Type = VelSet
Trigger1 = HitShakeOver && PrevStateNo != 5042 && GetHitVar(YVel) >= 0
Persistent = 0
X = -2*Const(Size.XScale)
Y = -6
[State 4000]
Type = VelAdd
Trigger1 = HitShakeOver || PrevStateNo = 5042
Y = IFelse(GetHitVar(YAccel)>0, GetHitVar(YAccel), .25)

[State 4000]
Type = ChangeState
Trigger1 = Vel Y > 0 &&  Pos Y >= 0
Value = 5100

[StateDef 4001];気絶中
Type = S
MoveType = I
Physics = S
Anim = 5300

[State 4001]
Type = VarSet
Trigger1 = Time = 0
V = 1
Value = -400
[State 4001]
Type = VarSet
Trigger1 = Time = 0
V = 2
Value = 0
[State 4001]
Type = VarAdd
Trigger1 = 1
V = 2
Value = 1
[State 4001]
Type = VarAdd
Trigger1 = Command = "up" || Command = "down" || Command = "fwd" || Command = "back" || Command = "a" || Command = "b" || Command = "c" || Command = "x" || Command = "y" || Command = "z"
V = 2
Value = 4

[State 4001]
Type = ChangeAnim
Trigger1 = 1
Value = 5300
Elem = IFelse((Var(2)=[0,11])||(Var(2)=[64,73])||(Var(2)=[126,137]),1,IFelse((Var(2)=[28,47])||Var(2)>137,3,IFelse((Var(2)=[74,89])||(Var(2)=[110,125]),6,IFelse((Var(2)=[90,109]),7,2))))

[State 4001]
Type = ChangeState
Trigger1 = (Var(0)=0&&Var(2)>=60) || (Var(0)=1&&Var(2)>=150)
Value = 0
Ctrl = 1