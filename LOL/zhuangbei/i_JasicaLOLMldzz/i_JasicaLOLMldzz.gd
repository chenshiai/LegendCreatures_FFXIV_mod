extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMldzz"
	RepeatId = id
	name = "兰顿之兆"
	att.maxHp = 400
	att.def = 70
	info = TEXT.format("""{c_base}{c_skill}唯一被动：{/c}减少30%受到的暴击伤害(包括魔法暴击)。
{c_skill}唯一被动——寒铁：{/c}被普通攻击击中时，减少攻击者20%攻击速度，持续2秒。{/c}""")
	
func _onHurt(atkInfo):
	if Repeat:
		return

	if atkInfo.isCri:
		atkInfo.hurtVal *= 0.7

	if atkInfo.atkType == NORMAL:
		STATUS.b_hantie.new({
			"cha": atkInfo.atkCha,
			"dur": 2,
		})

