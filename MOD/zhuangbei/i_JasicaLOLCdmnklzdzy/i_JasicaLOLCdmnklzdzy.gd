extends Item
func init():
	name = "多米尼克领主的致意"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 50
	att.pen = 20
	att.penL = 0.35
	info = "普通攻击附带物理穿透值的真实伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
func run(atkInfo:AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.hitCha,masCha.att.pen,Chara.HurtType.REAL,Chara.AtkType.EFF)


