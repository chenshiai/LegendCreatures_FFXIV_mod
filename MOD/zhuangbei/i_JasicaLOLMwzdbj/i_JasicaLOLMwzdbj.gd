extends Item
func init():
	name = "亡者的板甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 425
	att.def = 60
	info = "每受到8次攻击对下一次普通攻击附加一半物理防御的物理伤害"
	#effId = "sk_yunShi"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
	masCha.connect("onHurtEnd",self,"run1")
	n = 0

var n = 0;
func run(atkInfo):
	if n >= 8 && atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.hitCha,masCha.att.def*0.5,Chara.HurtType.PHY,Chara.AtkType.EFF)
		n = 0
func run1(atkInfo):
	n += 1
	#print(n)