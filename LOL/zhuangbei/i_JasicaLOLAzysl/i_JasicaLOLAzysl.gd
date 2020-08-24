extends Item
func init():
	name = "中亚沙漏"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 75
	att.def = 45
	att.cd = 0.1
	info = "唯一·凝滞:在本回合受到50%生命伤害时无敌3秒(每回合生效一次)"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	masCha.addBuff(w_ningzhi.new())

class w_ningzhi extends Buff:
	var n = 0
	var hp = 0
	var bl = false
	func _init(lv = 1):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onHurt",self,"run")
	func _upS():
		if hp > masCha.att.maxHp*0.5:
			bl = true
			n += 1
			if n > 3:
				bl = false

	func run(atkInfo):
		hp += atkInfo.hurtVal
		if bl:
			atkInfo.hurtVal = 0
	