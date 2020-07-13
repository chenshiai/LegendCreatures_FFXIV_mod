static func getCharaData():
	var name_1 = "学者"
	var name_2 = "传承之学"
	var name_3 = "阿尔菲诺-传奇"

	var meterage = ""

	var SKILL_TEXT = """[死炎法]：冷却4s，对目标造成[90%]的{TMgiHurt}
[鼓舞激励之策]：冷却10s，为生命最低的友方单位恢复[60%]法强的HP，并为其附加[鼓舞]
[鼓舞]：可以抵消[治疗量125%]的伤害，持续10s，无法与占星术士的[黑夜领域]叠加"""

	var SKILL_TEXT_1 = """[士高气昂之策]：冷却17s，恢复自身和周围4格内队员[50%]法强的HP，并附加[鼓舞]效果
[野战治疗阵]：冷却20s，以自身为中心产生减轻伤害的防护区域
三格内的队友受到的伤害会减轻10%，并获得持续恢复效果，持续10s"""

	var SKILL_TEXT_2 = """[我的梦想，就是拯救世界！]：{TPassive}护盾生成量变为[治疗量的225%]"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
