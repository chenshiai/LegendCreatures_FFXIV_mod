static func getCharaData():
	var name_1 = "舞者"
	var name_2 = "心动之舞"
	var name_3 = "娜休梅拉-传奇"

	var meterage = ""

	var SKILL_TEXT = """[伶俐]：{TPassive}技能可以产生暴击
[闭式舞姿]：{TPassive}战斗开始时，选择物攻最高与魔攻最高的队友作为舞伴，提高他们与自己的攻击力10%
[标准舞步]：冷却23s，对四格内的敌人造成[600%]的{TPhyHurt}，同时舞伴与自己的攻击力再提升10%，持续10s"""

	var SKILL_TEXT_1 = """[剑舞]：冷却13s，对目标及周围2格敌人造成[100%]的{TPhyHurt}
[防守之桑巴]：{TPassive}战斗开始时，为自身和所有队友附加[防守之桑巴]，受到的伤害减少10%
不可与吟游诗人的[行吟]、机工士的[策动]效果叠加"""

	var SKILL_TEXT_2 = """[进攻之探戈]：冷却18s，自身与舞伴的攻击力提高20%，持续8s"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
