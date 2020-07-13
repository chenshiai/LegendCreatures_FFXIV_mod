static func getCharaData():
	var name_1 = "战士"
	var name_2 = "纯爱之斧"
	var name_3 = "阿尔伯特-传奇"

	var meterage = ""

	var SKILL_TEXT = """[守护]：{TPassive}受到的伤害减少20%
[战栗]：冷却10s，立即治疗10%的最大生命值。然后最大生命值提高20%，受到的治疗量提高20%，持续10s"""

	var SKILL_TEXT_1 = """[裂石飞环]：冷却4s，下一次普通攻击对目标造成[350%]的{TPhyHurt}
[原初的解放]：冷却16s，获得100%的暴击率提升，持续8s"""

	var SKILL_TEXT_2 = """[地毁人亡]：冷却12s，对周围2格内的敌人造成[180%]的{TPhyHurt}
[死斗]：濒死时开启，使自身生命值不会低于1(除特定攻击外)，持续7s，然后恢复20%的生命值，最多触发一次"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
