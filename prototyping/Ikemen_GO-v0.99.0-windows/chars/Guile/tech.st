[StateDef 1000];ソニックブーム 弱
Type = U
MoveType = A
Physics = U
Ctrl = 0
VelSet = 0, 0
Anim = 1000
SorPriority = 2

[State 1000]
Type = VelSet
Trigger1 = StateType = A
Y = 0

[State 1000]
Type = PlaySnd
Trigger1 = Time = 0
Value = 10, 0
Channel = 1

[State 1000]
Type = Helper
Trigger1 = AnimElem = 4,2
Name = "Guard_HANTEI"
ID = 1000
Pos = 40, 0
PosType = P1
StateNo = 1008

[State 1000]
Type = Projectile
trigger1 = AnimElem = 4,2 && EnemyNear,StateNo != [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (3+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = MA
Damage = 112, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 13
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1
[State 1000]
Type = Projectile
Trigger1 = AnimElem = 4,2 && EnemyNear,StateNo = [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (3+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = M
Damage = 112, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 13
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1

[State 1000]
Type = ChangeState
Trigger1 = AnimTime = 0
Value = 0 + (StateType=A)*50
Ctrl = 1 - (StateType=A)

[StateDef 1001];ソニックブーム 中
Type = U
MoveType = A
Physics = U
Ctrl = 0
VelSet = 0, 0
Anim = 1000
SorPriority = 2

[State 1001]
Type = VelSet
Trigger1 = StateType = A
Y = 0

[State 1001]
Type = PlaySnd
Trigger1 = Time = 0
Value = 10, 0
Channel = 1

[State 1001]
Type = Helper
Trigger1 = AnimElem = 4,2
Name = "Guard_HANTEI"
ID = 1000
Pos = 40, 0
PosType = P1
StateNo = 1008

[State 1001]
Type = Projectile
trigger1 = AnimElem = 4,2 && EnemyNear,StateNo != [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (4+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = MA
Damage = 119, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 18
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1
[State 1001]
Type = Projectile
trigger1 = AnimElem = 4,2 && EnemyNear,StateNo = [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (4+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = M
Damage = 119, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 18
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1

[State 1001]
Type = ChangeState
Trigger1 = AnimTime = 0
Value = 0 + (StateType=A)*50
Ctrl = 1 - (StateType=A)

[StateDef 1002];ソニックブーム 強
Type = U
MoveType = A
Physics = U
Ctrl = 0
VelSet = 0, 0
Anim = 1000 + (Var(10)=1)*10
SorPriority = 2

[State 1002]
Type = VelSet
Trigger1 = StateType = A
Y = 0

[State 1002]
Type = PlaySnd
Trigger1 = Time = 0
Value = 10, 0
Channel = 1

[State 1002]
Type = Helper
Trigger1 = (AnimElem=4,2&&Var(10)!=1) || (AnimElem=5,2&&Var(10)=1)
Name = "Guard_HANTEI"
ID = 1000
Pos = 40, 0
PosType = P1
StateNo = 1008

[State 1002]
Type = Projectile
trigger1 = ((AnimElem=4,2&&Var(10)!=1) || (AnimElem=5,2&&Var(10)=1)) && EnemyNear,StateNo != [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3 + (Var(10)=1)*10
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (5+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = MA
Damage = 119, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 22
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1
[State 1002]
Type = Projectile
trigger1 = ((AnimElem=4,2&&Var(10)!=1) || (AnimElem=5,2&&Var(10)=1)) && EnemyNear,StateNo = [5020,5099]
ProjAnim = 1001 + (Var(12)=-1)*3
ProjHitAnim = 1002 + (Var(12)=-1)*3
ProjID = 1
OffSet = 0, 0
Velocity = (5+IFelse(Var(11)>=0,Var(11)*2,Var(11)/2))*Const(Size.XScale)
ProjPriority = 1
ProjScale = Const(Size.XScale), 1
Attr = S, SP
GuardFlag = M
HitFlag = M
Damage = 119, 21
GetPower = 0
GivePower = 0
PauseTime = 0, 15
SparkNo = -1
Guard.SparkNo = -1
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air.AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 22
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
YAccel = .25
Fall.YVelocity = -4
P2Facing = 1
ForceStand = 1

[State 1002]
Type = ChangeState
Trigger1 = AnimTime = 0
Value = 0 + (StateType=A)*50
Ctrl = 1 - (StateType=A)

[StateDef 1008];飛び道具 CPUに防御させ易くするヘルパー
Type = S
MoveType = A
Physics = N
Ctrl = 0
Anim = 99

[State 1008]
Type = VelSet
trigger1 = Time = 0
X=(IFelse(Parent,StateNo=1000,3,IFelse(Parent,StateNo=1001,4,5))+IFelse(Parent,Var(11)>=0,Parent,Var(11)*2,Parent,Var(11)/2))*Const(Size.XScale)

[State 1008]
Type = DestroySelf
Trigger1 = FrontEdgeDist < -50 || Parent,ProjContact0 = 1, 1 || Parent,ProjCancelTime(0) = 1

[StateDef 1100];サマーソルトキック 弱
Type = U
MoveType = A
Physics = N
Ctrl = 0
VelSet = 0, 0
Anim = 1100
SorPriority = 2

[State 1100]
Type = NotHitBy
Trigger1 = AnimElem = 5,<=0
Value = SCA

[State 1100]
Type = VelSet
Trigger1 = AnimElem = 2,<2
Y = 0

[State 1100]
Type = VelSet
Trigger1 = AnimElem = 2,1
X = (1.4+IFelse(Var(4)>=0,Var(4)*2,Var(4)/2))*Const(Size.XScale)
Y = -6-IFelse(Var(7)>=0,Var(7)*2,Var(7)/2)
[State 1100]
Type = StateTypeSet
Trigger1 = AnimElem = 2,1
Value = A
[State 1100]
Type = VelAdd
Trigger1 = AnimElem = 2,>1
Y = .3

[State 1100];初代スト２開発中のヒット後に後ろに下がるサマーソルトを再現。
Type = VelSet
Trigger1 = MoveContact && Var(12) = 1
Persistent = 0
X = -Vel X

[State 1100]
Type = PlaySnd
Trigger1 = Time = 0
Value = 0, 9

[State 1100]
Type = HitDef
Trigger1 = (AnimElem=4||AnimElem=7) && !MoveContact
Attr = S, SA
HitFlag = MA
GuardFlag = M
Damage = 203, 49
GetPower = 0
GivePower = 0
PauseTime = 14, 14
SparkNo = S54+TeamSide + (Var(12)=-1)*10
Guard.SparkNo = S54+(TeamSide) + (Var(12)=-1)*10
SparkXY = -20+Floor(P2Dist X)/2, Floor(-38 - (AnimElem=7)*35 + (P2Dist Y/2))
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Up
Ground.Type = Low
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 29
Air.HitTime = 20
Ground.Velocity = -1.5*Const(Size.XScale), -5
Guard.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
P2Facing = 1

[State 1100]
Type = ChangeState
Trigger1 = Vel Y > 0 && Pos Y >= 0
Value = 1103

[StateDef 1101];サマーソルトキック 中
Type = U
MoveType = A
Physics = N
Ctrl = 0
VelSet = 0, 0
Anim = 1101
SorPriority = 2

[State 1101]
Type = NotHitBy
Trigger1 = AnimElem = 5,<=0
Value = SCA

[State 1101]
Type = VelSet
Trigger1 = AnimElem = 2,<1
Y = 0

[State 1101]
Type = VelSet
Trigger1 = AnimElem = 2
X = (1.4+IFelse(Var(4)>=0,Var(4)*2,Var(4)/2))*Const(Size.XScale)
Y = -7-IFelse(Var(7)>=0,Var(7)*2,Var(7)/2)
[State 1101]
Type = StateTypeSet
Trigger1 = AnimElem = 2
Value = A
[State 1101]
Type = VelAdd
Trigger1 = AnimElem = 2,>0
Y = .3

[State 1101];初代スト２開発中のヒット後に後ろに下がるサマーソルトを再現。
Type = VelSet
Trigger1 = MoveContact && Var(12) = 1
Persistent = 0
X = -Vel X

[State 1101]
Type = PlaySnd
Trigger1 = Time = 0
Value = 0, 9

[State 1101]
Type = HitDef
Trigger1 = (AnimElem=4||AnimElem=7) && !MoveContact
Attr = S, SA
HitFlag = MA
GuardFlag = M
Damage = 231, 70
GetPower = 0
GivePower = 0
PauseTime = 14, 14
SparkNo = S54+TeamSide + (Var(12)=-1)*10
Guard.SparkNo = S54+(TeamSide) + (Var(12)=-1)*10
SparkXY = -20+Floor(P2Dist X)/2, Floor(-38 - (AnimElem=7)*35 + (P2Dist Y/2))
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Up
Ground.Type = Low
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 29
Air.HitTime = 20
Ground.Velocity = -1.5*Const(Size.XScale), -5
Guard.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
P2Facing = 1

[State 1101]
Type = ChangeState
Trigger1 = Vel Y > 0 && Pos Y >= 0
Value = 1103

[StateDef 1102];サマーソルトキック 強
Type = U
MoveType = A
Physics = N
Ctrl = 0
VelSet = 0, 0
Anim = 1102
SorPriority = 2

[State 1102]
Type = NotHitBy
Trigger1 = AnimElem = 5,<=0
Value = SCA

[State 1102]
Type = VelSet
Trigger1 = AnimElem = 1,<4
Y = 0

[State 1102]
Type = VelSet
Trigger1 = AnimElem = 1,3
X = (1.4+IFelse(Var(4)>=0,Var(4)*2,Var(4)/2))*Const(Size.XScale)
Y = -8-IFelse(Var(7)>=0,Var(7)*2,Var(7)/2)
[State 1102]
Type = StateTypeSet
Trigger1 = AnimElem = 1,3
Value = A
[State 1102]
Type = VelAdd
Trigger1 = AnimElem = 1,>3
Y = .3

[State 1102];初代スト２開発中のヒット後に後ろに下がるサマーソルトを再現。
Type = VelSet
Trigger1 = MoveContact && Var(12) = 1
Persistent = 0
X = -Vel X

[State 1102]
Type = PlaySnd
Trigger1 = Time = 0
Value = 0, 9

[State 1102]
Type = HitDef
Trigger1 = AnimElem = 4 && Var(10) != 1
Attr = S, SA
HitFlag = MA
GuardFlag = M
Damage = 133, 28
GetPower = 0
GivePower = 0
PauseTime = 14, 14
SparkNo = S54+TeamSide + (Var(12)=-1)*10
Guard.SparkNo = S54+(TeamSide) + (Var(12)=-1)*10
SparkXY = -20+Floor(P2Dist X)/2, -38
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Hard
Air,AnimType = Back
Ground.Type = High
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 29
Air.HitTime = 20
Ground.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Air.Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
P2Facing = 1
[State 1102]
Type = HitDef
Trigger1 = (AnimElem=7&&Var(10)!=1) || ((AnimElem=4||AnimElem=7)&&!MoveContact&&Var(10)=1)
Attr = S, SA
HitFlag = MA
GuardFlag = M
Damage = 154 + (Var(10)=1)*105, 35 + (Var(10)=1)*35
GetPower = 0
GivePower = 0
PauseTime = 14, 14
SparkNo = S54+TeamSide + (Var(12)=-1)*10
Guard.SparkNo = S54+(TeamSide) + (Var(12)=-1)*10
SparkXY = -20+Floor(P2Dist X)/2, Floor(-38 - (AnimElem=7)*35 + (P2Dist Y/2))
HitSound = S0, 3
GuardSound = S0, 0
AnimType = Up
Ground.Type = Low
Ground.SlideTime = 21
Ground.HitTime = 20
Guard.HitTime = 29
Air.HitTime = 20
Ground.Velocity = -1.5*Const(Size.XScale), -5
Guard.Velocity = -9*Const(Size.XScale)
Air.Velocity = -1.5*Const(Size.XScale), -5
Fall = 1
Fall.Recover = 0
Fall.YVelocity = -4
YAccel = .25
P2Facing = 1

[State 1102]
Type = ChangeState
Trigger1 = Vel Y > 0 && Pos Y >= 0
Value = 1103

[StateDef 1103];サマーソルトキック 着地
Type = S
MoveType = A
Physics = S
Ctrl = 0
VelSet = 0, 0

[State 1103]
Type = PosSet
Trigger1 = Time = 0
Y = 0

[State 1103]
Type = ChangeAnim
Trigger1 = (Time=0&&PrevStateNo!=[1101,1102]) || (Time=1&&PrevStateNo=[1101,1102])
Value = 47

[State 1103]
Type = ChangeState
Trigger1 = (Time=3&&PrevStateNo=1100) || (Time=5&&PrevStateNo=1101) || (Time=7&&PrevStateNo=1102) || (Time=6&&PrevStateNo=521) || (Time=9&&PrevStateNo=[1200,1209])
Value = 0
Ctrl = 1