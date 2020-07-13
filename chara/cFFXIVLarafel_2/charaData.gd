static func getCharaData():
	var name_1 = "黑魔法师"
	var name_2 = "魔石之黑"
	var name_3 = "帕帕力莫-传奇"

	var meterage = ""

	var SKILL_TEXT = """[玄冰]：冷却4s，对目标及周围一格的敌人造成[150%]的{TMgiHurt}
[灵极冰]：{TPassive}使用[玄冰]后降低[爆炎]的冷却四次，重置[爆炎]的伤害提升阶段
[爆炎]：冷却26s，对目标造成[240%]的{TMgiHurt}
[星极火]：{TPassive}[爆炎]释放后，后续的[爆炎]伤害增加30%，延长[玄冰]的冷却"""

	var SKILL_TEXT_1 = """[黑魔纹]：冷却50s，开局立即释放一次，加快自身15%的技能冷却，持续30s
[异言]：冷却30s，对目标造成[750%]法强的{TMgiHurt}"""

	var SKILL_TEXT_2 = """[最好的学生]：{TPassive}提高30%的法强"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
