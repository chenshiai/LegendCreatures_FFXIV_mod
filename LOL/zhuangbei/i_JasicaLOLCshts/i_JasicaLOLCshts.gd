extends "../LOLItemBase/LOLItemBase.gd"


func _init():
	id = "i_JasicaLOLCshts"
	RepeatId = id
	name = "守护天使"
	att.atk = 55
	att.def = 50
	info = TEXT.format("{c_base}{c_skill}唯一被动：{/c}受到致命伤害时，立即回复50%生命。每回合可以使用一次{/c}")

func _onBattleStart():
	if Repeat:
		return
	masCha.addBuff(w_tianshi.new())

class w_tianshi extends Buff:
	func _init():
		id = "w_kuangbao"
	func _connect():
		masCha.connect("onDeath", self, "run")
	func run(atkInfo):
		self.isDel = true
		masCha.isDeath = false
		masCha.plusHp(masCha.att.maxHp * 0.5)