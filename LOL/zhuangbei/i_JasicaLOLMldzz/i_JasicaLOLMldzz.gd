extends Item
func init():
	name = "兰顿之兆"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 400
	att.def = 70
	info = "唯一·兰顿:减少30%受到的暴击伤害(包括魔法暴击)"
	info += "\n唯一·寒铁:被普通攻击时,减少攻击者20%攻击速度持续1秒"
	#effId = "sk_yunShi"
	
func _connect():
	masCha.connect("onHurt",self,"run")

func run(atkInfo):
	if atkInfo.isCri:
		atkInfo.hurtVal *= 0.7
	if atkInfo.atkType == Chara.AtkType.NORMAL :
		atkInfo.atkCha.addBuff(w_hantie.new(1))

class w_hantie extends Buff:
	var n = 0 
	func _init(lv = 1):
		attInit()
		life = lv
		id = "w_kuangbao"
		#isNegetive=true
		att.spd = -0.20
	
	func init():
		pass
	
	func _connect():
		pass
	func _upS():
		pass

