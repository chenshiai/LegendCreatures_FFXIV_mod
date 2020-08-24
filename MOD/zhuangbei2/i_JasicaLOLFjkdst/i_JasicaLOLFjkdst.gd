extends Item
func init():
	name = "基克的使徒"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 300
	att.cd = 0.15
	info = "唯一·使徒:周围2格范围内的友军增加12%的吸血和20%的攻击速度"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	for cha in masCha.getCellChas(masCha.cell,2,2):
		cha.addBuff(w_shitu.new())

class w_shitu extends Buff:
	func _init(lv = 1):
		attInit()
		#effId = "p_liuXue"
		#life = lv
		#isNegetive=true
	func init():
		pass
	func _connect():
		pass
	func _upS():
		att.suck = 0.12
		att.mgiSuck = 0.12
		att.spd = 0.2