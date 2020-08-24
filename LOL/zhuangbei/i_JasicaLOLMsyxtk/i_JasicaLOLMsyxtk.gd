extends Item
func init():
	name = "适应性头盔"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 450
	att.mgiDef = 55
	att.reHp = 0.1
	info = "受到来自同一个单位的伤害时,使单位所有后续伤害减少30%"
	#effId = "sk_yunShi"
	
func _connect():
	masCha.connect("onHurt",self,"run")
	masCha.connect("onAddItem",self,"run1")
var cha:Chara
func run1(item):
	cha = masCha
func run(atkInfo):
	if cha == atkInfo.atkCha:
		#print("适应性头盔:%s" % atkInfo.hurtVal)
		atkInfo.hurtVal *= 0.7
	cha = atkInfo.atkCha
	#if atkInfo.atkType == Chara.AtkType.SKILL:
	#	masCha.plusHp(masCha.att.maxHp*0.01)

