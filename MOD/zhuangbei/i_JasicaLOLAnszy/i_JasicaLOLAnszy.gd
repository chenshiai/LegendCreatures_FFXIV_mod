extends Item
func init():
	name = "纳什之牙"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.5
	att.mgiAtk = 80
	att.cd = 0.2
	info = "普通攻击会造成25+(15%法术强度)的额外魔法伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")


func run(atkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		info = "普通攻击会造成25+(%s)的额外魔法伤害" % (masCha.att.mgiAtk*0.15)
		masCha.hurtChara(atkInfo.hitCha,25+masCha.att.mgiAtk*0.15,Chara.HurtType.MGI,Chara.AtkType.EFF)