extends Item
func init():
	name = "虚空之杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 80
	att.mgiPen = 30
	att.mgiPenL = 0.3
	info = "技能攻击附带魔法穿透值两倍的真实伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")


func run(atkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL:
		masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiPen*2,Chara.HurtType.REAL,Chara.AtkType.EFF )