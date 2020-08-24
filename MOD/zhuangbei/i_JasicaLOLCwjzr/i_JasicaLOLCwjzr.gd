extends Item
func init():
	name = "无尽之刃"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.cri = 0.25
	att.criR = 0.25
	info = "每次暴击附加物理攻击25%的伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")

func run(atkInfo:AtkInfo):
	if atkInfo.isCri :
		masCha.hurtChara(atkInfo.hitCha,masCha.att.atk*0.25,Chara.HurtType.PHY,Chara.AtkType.EFF)
