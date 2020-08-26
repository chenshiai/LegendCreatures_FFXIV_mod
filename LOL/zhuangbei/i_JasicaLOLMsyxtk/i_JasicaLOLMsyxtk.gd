extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMsyxtk"
	RepeatId = id
	name = "适应性头盔"
	att.maxHp = 450
	att.mgiDef = 55
	att.reHp = 0.1
	att.cd = 0.1
	info = TEXT.format("{c_base}{c_skill}唯一被动：{/c}承受魔法伤害后，携带者获得1%的魔法伤害减免，最大提升至20%，持续4s。{/c}")

var Level = 0 # 当前累计伤害减免
const HOLD = 4 # 持续时间
var nowTime = 0 # 倒计时

func _onHurt(atkInfo):
	if Repeat:
		return
	if atkInfo.hurtType == MGI:
		nowTime = 0
		atkInfo.hurtVal *= 1 - Level
		Level += 0.01
		if Level > 0.2:
			Level = 0.2

func _upS():
	if Repeat:
		return
	
	nowTime += 1
	if nowTime >= HOLD:
		Level = 0
