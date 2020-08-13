static func getCharaData():
	var name_1 = "绝枪战士"
	var name_2 = "守约之刃"
	var name_3 = "桑克瑞德-传奇"

	var meterage = ""

	var SKILL_TEXT = """[王室亲卫]：{TPassive}受到的伤害减少20%
[弓形冲波]：冷却9s，对周围2格的敌人造成[260%]的{TPhyHurt}，并附加4层[烧灼]"""

	var SKILL_TEXT_1 = """[续剑]：{TPassive}攻击速度提高30%，普通攻击会附加35%攻击力的{TMgiHurt}
[超火流星]：{TPassive}生命值低于5%时，8s内免疫任何伤害，生命值降为1点，最多触发一次"""

	var SKILL_TEXT_2 = """[爆破领域]：冷却10s，对目标造成[380%]的{TPhyHurt}"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
