extends Item
func init():
	name = "冰霜之心"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 110
	att.maxHp = 200
	att.cd = 0.2
	#att.defR = 0.15
	info = "唯一·冰心:降低2格范围内敌人25%的攻速"
	#effId = "sk_yunShi"
	
func _connect():
	pass
func _upS():
	for cha in masCha.getCellChas(masCha.cell,2,1):
		cha.addBuff(w_bingxin.new())


class w_bingxin extends Buff:
	var n = 0 
	func _init(lv = 1):
		attInit()
		life = lv
		id = "w_kuangbao"
		#isNegetive=true
		att.spd = -0.25
	
	func init():
		pass
	
	func _connect():
		pass
	func _upS():
		pass
	