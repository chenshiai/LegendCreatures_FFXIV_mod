static func getCharaData():
	var name_1 = "骑士"
	var name_2 = "冠军之剑"
	var name_3 = "杰林斯-传奇"

	var meterage = ""

	var SKILL_TEXT = """[钢铁信念]：{TPassive}战斗开始后，提高10%的物理防御，受到的伤害减少20%
[深仁厚泽]：冷却15s，为生命最低的友方单位使用治疗魔法，恢复[1200%]法强的生命值
[王权剑]：冷却6s，对目标造成[350%]的{TPhyHurt}"""

	var SKILL_TEXT_1 = """[圣光幕帘]：冷却26s，技能开启后的5s内，若自身有受到治疗，则为周围其他队友附加护盾，可以抵消[骑士最大生命值10%]的伤害，持续10s
[盾阵]：{TPassive}受到攻击时有30%的概率减少15%的伤害。"""

	var SKILL_TEXT_2 = """[神圣领域]：战斗开始时开启无敌，持续10s，之后每70s使用一次"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
