[StateDef 3000];ポーズヘルパー待機
Type = S
Ctrl = 0
Anim = 99

[State 3000];飛び道具ヒット時のスロー
Type = VarSet
Trigger1 = Parent,ProjHit1 = 1,16 || Var(11) = 40
V = 10
Value = IFelse(Var(11)=40, 0, 1)
[State 3000]
Type = VarSet
Trigger1 = Var(11) = 40
V = 11
Value = 0
[State 3000]
Type = VarAdd
Trigger1 = Var(10)
V = 11
Value = 1
[State 3000]
Type = Pause
Trigger1 = RoundState = 2 && Var(11) = [1,41]
Persistent = 2
Time = 1
MoveTime = 1

[State 3000];気絶値初期化
Type = VarAdd
Trigger1 = Parent,Var(1) > 0
V = 20
Value = 1
[State 3000]
Type = ParentVarSet
Trigger1 = Parent,Var(1) > 0 && Var(20) > 180
V = 1
Value = 0
[State 3000]
Type = VarSet
Trigger1 = Var(20) > 0 && (Var(20)>180||Parent,MoveType=H||Parent,Var(1)<0)
V = 20
Value = 0

[State 3000]
Type = ChangeState
Trigger1 = Parent,Alive && RoundState = 2 && Command = "start" && Parent,Command = "start" && Parent,Var(30) = 2
Value = 3001

[StateDef 3001];ポーズ
Type = S
Ctrl = 0

[State 3001]
Type = PlaySnd
Trigger1 = Time = 0
Value = 0, 17

[State 3001]
Type = AssertSpecial
Trigger1 = 1
Flag = NoFG

[State 3001]
Type = BGPalFX
Trigger1 = 1
Time = 10
Mul = 100,100,100
Add = 70, 70, 70

[State 3001]
Type = PlaySnd
Trigger1 = (Command="up"&&Var(0)>0)||(Command="down"&&Var(0)<7)
Trigger2 = (Command="fwd"&&((Var(0)=0&&!Parent,Var(5))||Var(0)=1||(Var(0)=7&&Parent,Var(13))))
Trigger3 = (Command="back"&&((Var(0)=0&&Parent,Var(5))||Var(0)=1||(Var(0)=7&&!Parent,Var(13))))
Trigger4 = (Command="fwd"&&((Var(0)=2&&Parent,Var(4)<3)||(Var(0)=3&&Parent,Var(7)<3)||(Var(0)=4&&Parent,Var(9)<3)||(Var(0)=5&&Parent,Var(11)<3)||(Var(0)=6&&Parent,Var(12)<3)))
Trigger5 = (Command="back"&&((Var(0)=2&&Parent,Var(4)>-3)||(Var(0)=3&&Parent,Var(7)>-3)||(Var(0)=4&&Parent,Var(9)>-3)||(Var(0)=5&&Parent,Var(11)>-3)||(Var(0)=6&&Parent,Var(12)>-3)))
;Trigger4 = (Command="fwd"&&(Var(0)=[2,6])&&((Parent,Var(4)=[-2,2])||(Parent,Var(7)=[-2,2])||(Parent,Var(9)=[-2,2])||(Parent,Var(11)=[-2,2])||(Parent,Var(12)=[-2,2])))
Value = 0, 18

[State 3001]
Type = VarAdd
Trigger1 = (Command="up"&&Var(0)>0)||(Command="down"&&Var(0)<7)
V = 0
Value = IFelse(Command = "down", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Command = "up" || Command = "down"
ID = 3001

[State 3001]
Type = ParentVarSet
Trigger1 = Var(0)=0 && (Command = "fwd" || Command = "back")
V = 5
Value = IFelse(Command = "fwd", 1, 0)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=0 && (Command = "fwd" || Command = "back")
ID = 3002

[State 3001]
Type = ParentVarSet
Trigger1 = Var(0)=1 && (Command = "fwd" || Command = "back")
V = 10
Value = IFelse(Command="fwd", IFelse(Parent,Var(10)=0,1,IFelse(Parent,Var(10)=1,2,0)), IFelse(Parent,Var(10)=0,2,IFelse(Parent,Var(10)=1,0,1)))
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=1 && (Command = "fwd" || Command = "back")
ID = 3003

[State 3001]
Type = Explod
Trigger1 = Time = 0
Anim = 3000
ID = 3000
Pos = 160, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = Time = 0
Anim = 3010
ID = 3000
Pos = 160, 100
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = Time = 0 || Command = "down" || Command = "up"
Anim = 3015
ID = 3001
Pos = 160, 100+Var(0)*14;IFelse(Var(0)=0, 113, 100)
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=0 && (Command = "fwd" || Command = "back"))
Anim = 3011+Parent,Var(5)
ID = 3002
Pos = 160, 100
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];左右移動速度
Type = ParentVarAdd
Trigger1 = Var(0)=2 && ((Command="fwd"&&Parent,Var(4)<3)||(Command="back"&&Parent,Var(4)>-3))
V = 4
Value = IFelse(Command = "fwd", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=2 && (Command = "fwd" || Command = "back")
ID = 3004
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=2 && (Command = "fwd" || Command = "back"))
Anim = 3016
ID = 3004
Pos = 160 + Parent,Var(4)*6, 100
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];上下移動速度
Type = ParentVarAdd
Trigger1 = Var(0)=3 && ((Command="fwd"&&Parent,Var(7)<3)||(Command="back"&&Parent,Var(7)>-3))
V = 7
Value = IFelse(Command = "fwd", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=3 && (Command = "fwd" || Command = "back")
ID = 3005
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=3 && (Command = "fwd" || Command = "back"))
Anim = 3016
ID = 3005
Pos = 160 + Parent,Var(7)*6, 114
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];引力
Type = ParentVarAdd
Trigger1 = Var(0)=4 && ((Command="fwd"&&Parent,Var(9)<3)||(Command="back"&&Parent,Var(9)>-3))
V = 9
Value = IFelse(Command = "fwd", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=4 && (Command = "fwd" || Command = "back")
ID = 3006
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=4 && (Command = "fwd" || Command = "back"))
Anim = 3016
ID = 3006
Pos = 160 + Parent,Var(9)*6, 128
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];波動速度
Type = ParentVarAdd
Trigger1 = Var(0)=5 && ((Command="fwd"&&Parent,Var(11)<3)||(Command="back"&&Parent,Var(11)>-3))
V = 11
Value = IFelse(Command="fwd", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=5 && (Command = "fwd" || Command = "back")
ID = 3007
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=5 && (Command = "fwd" || Command = "back"))
Anim = 3016
ID = 3007
Pos = 160 + Parent,Var(11)*6, 142
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];守備力
Type = ParentVarAdd
Trigger1 = Var(0)=6 && ((Command="fwd"&&Parent,Var(12)<3)||(Command="back"&&Parent,Var(12)>-3))
V = 12
Value = IFelse(Command="fwd", 1, -1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=6 && (Command = "fwd" || Command = "back")
ID = 3008
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=6 && (Command = "fwd" || Command = "back"))
Anim = 3016
ID = 3008
Pos = 160 + Parent,Var(12)*6, 156
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];空中必殺
Type = ParentVarSet
Trigger1 = Var(0)=7 && (Command = "fwd" || Command = "back")
V = 13
Value = IFelse(Command="fwd", 0, 1)
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=7 && (Command = "fwd" || Command = "back")
ID = 3009
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=7 && (Command = "fwd" || Command = "back"))
Anim = 3012-Parent,Var(13)
ID = 3009
Pos = 160, 198
PosType = Left
OwnPal = 1
SprPriority = 101
PauseMoveTime = -1
BindTime = -1

[State 3001];空中可
Type = RemoveExplod
Trigger1 = Var(0)=1 && ((Command="fwd"&&(Parent,Var(10)||!Parent,Var(13))) || (Command="back"&&(!Parent,Var(10)||Parent,Var(13))))
ID = 3003
[State 3001]
Type = RemoveExplod
Trigger1 = Var(0)=7 && ((Command="fwd"&&!Parent,Var(13)) || (Command="back"&&Parent,Var(13)))
ID = 3010
[State 3001]
Type = Explod
Trigger1 = (Time = 0 && Parent,Var(13)) || (Var(0)=7 && Command = "back")
Anim = 3003
ID = 3010
Pos = 160, 83
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = (Time = 0 && Parent,Var(13)) || (Var(0)=7 && Command = "back")
Anim = 3003
ID = 3010
Pos = 160, 70
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1

[State 3001];モード
Type = RemoveExplod
Trigger1 = Var(0)=1 && (Command="fwd"||Command="back")
ID = 3011
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))
Anim = 3013+(Parent,Var(10)=2)+(Parent,Var(10)=1)*4
ID = 3011
Pos = 160, 100
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1

[State 3001];矢印部分
Type = Explod
Trigger1 = (Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))) && Parent,Var(10) != 2
Anim = IFelse(Parent,Facing=1, 3005, 3006)
ID = 3011
Pos = 160, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))
Anim = IFelse(Parent,Facing=1, 3006, 3005)
ID = 3011
Pos = 198 - (Parent,Var(10)=2)*37, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001
Type = Explod
Trigger1 = (Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))) && Parent,Var(10) != 2
Anim = 3001
ID = 3011
Pos = 160, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = (Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))) && Parent,Var(10) != 2
Anim = 3002
ID = 3011
Pos = 160, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))
Anim = 3004
ID = 3011
Pos = 160 - (Parent,Var(10)=2)*37, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1
[State 3001]
Type = Explod
Trigger1 = (Time = 0 || (Var(0)=1 && (Command="fwd"||Command="back"))) && Parent,Var(10) != 2
Anim = 3001
ID = 3011
Pos = 160, 84
PosType = Left
OwnPal = 1
SprPriority = 100
PauseMoveTime = -1
BindTime = -1

[State 3001]
Type = Pause
Trigger1 = 1
Time = 10
MoveTime = 10

[State 3001]
Type = ChangeState
Trigger1 = Time >= 6 && Command = "start"
Value = 3002

[StateDef 3002];ポーズ待機へ
Type = S
Ctrl = 0

[State 3002]
Type = Pause
Trigger1 = Time = 0
Time = 0

[State 3002]
Type = VarSet
Trigger1 = Time = 0
V = 0
Value = 0

[State 3002]
Type = BGPalFX
Trigger1 = Time = 0
Time = 1

[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3000
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3001
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3002
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3003
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3004
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3005
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3006
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3007
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3008
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3009
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3010
[State 3002]
Type = RemoveExplod
Trigger1 = Time = 0
ID = 3011

[State 3002]
Type = ChangeState
Trigger1 = Time = 1
Value = 3000