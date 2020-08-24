extends Item


func init():
	name = "守护天使"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 55
	att.def = 50
	info = "唯一·天使:单位受到致命伤害时，回复50%生命每回合可以使用一次"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	masCha.addBuff(w_tianshi.new())
class w_tianshi extends Buff:
	var n = 0 
	func _init(lv = 1):
		attInit()
		#life = lv
		id = "w_kuangbao"
		#isNegetive=true
	
	func init():
		pass
	
	func _connect():
		masCha.connect("onDeath",self,"run")
	func _upS():
		pass
	func run(atkInfo):
		if n < 1:
			n += 1
			masCha.isDeath = false
			masCha.plusHp(masCha.att.maxHp * 0.5)