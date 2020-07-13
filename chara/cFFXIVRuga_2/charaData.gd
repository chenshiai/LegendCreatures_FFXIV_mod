static func getCharaData():
	var name_1 = "武僧"
	var name_2 = "复教之拳"
	var name_3 = "莉瑟-传奇"

	var meterage = ""

	var SKILL_TEXT = """[迅雷疾风]：{TPassive}增加16%的攻击速度，且在攻击时，获得2层[急速]
[斗气]：{TPassive}每攻击有35%概率获得1点斗气，最大5点，满5点后会立即释放[阴阳斗气斩]，不计入冷却
[阴阳斗气斩]：冷却10s，对目标造成[210%]的{TPhyHurt}，消耗斗气提高伤害，每点斗气提高[20%]的倍率，最大[310%]"""

	var SKILL_TEXT_1 = """[金刚决意]：{TPassive}受到的伤害减少10%
[六合星导腿]：冷却12s，对目标造成[400%]的{TPhyHurt}，自身每层[急速]可以提高[5%]的伤害"""

	var SKILL_TEXT_2 = """[红莲极意]：{TPassive}复国领袖，提升25%的攻击力"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
