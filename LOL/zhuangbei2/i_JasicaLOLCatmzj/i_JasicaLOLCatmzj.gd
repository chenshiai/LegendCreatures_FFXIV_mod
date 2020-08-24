extends Item
func init():
	name = "阿塔玛之戟"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 45
	att.cri = 0.15
	info = "唯一·阿塔玛:增加相当于你最大生命值1.5%的攻击力(战斗开始时增加)"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	masCha.addBuff(w_atama.new())

class w_atama extends Buff:
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
		att.atk = masCha.att.maxHp*0.015
	