extends Item
func init():
	name = "振奋铠甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 550
	att.mgiDef = 65
	att.cd = 0.1
	att.reHp = 0.20
	info = "受到技能攻击时回复最大生命的1%"
	info += "\n承受伤害减少15%"
	#effId = "sk_yunShi"
	
func _connect():
	masCha.connect("onHurt",self,"run")

func run(atkInfo):
	atkInfo.hurtVal *= 0.85
	if atkInfo.atkType == Chara.AtkType.SKILL:
		masCha.plusHp(masCha.att.maxHp*0.01)

