extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAzysl"
	RepeatId = id
	name = "中亚沙漏"
	att.mgiAtk = 75
	att.def = 45
	att.cd = 0.1
	info = TEXT.format("{c_base}{c_skill}唯一被动——凝滞：{/c}生命值低于40%时，无敌3秒(每回合生效一次){/c}")

var superbolide = true

func _onBattleStart():
	superbolide = true

func _onHurt(atkInfo):
	if Repeat:
		return
	if (masCha.att.hp - atkInfo.hurtVal) <= masCha.att.maxHp * 0.4 and superbolide:
		atkInfo.hurtVal = 0
		STATUS.b_ningzhi.new({"cha": masCha, "dur": 3})
		superbolide = false
