extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "中亚沙漏"
	att.mgiAtk = 75
	att.def = 45
	att.cd = 0.1
	info = TEXT.format("{c_base}{c_skill}唯一·凝滞：{/c}生命值低于30%时，无敌3秒(每回合生效一次){/c}")

var superbolide = true

func _onBattleStart():
	superbolide = true

func _onHurt(atkInfo):
	if (masCha.att.hp - atkInfo.hurtVal) <= masCha.att.maxHp * 0.3 and superbolide:
		atkInfo.hurtVal = 0
		STATUS.b_ningzhi.new({"cha": masCha, "dur": 3})
		superbolide = false
