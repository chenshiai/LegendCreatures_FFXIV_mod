static func getCharaData():
	var name_1 = "召唤师"
	var name_2 = "首席之唤"
	var name_3 = "次优召唤师-传奇"

	var meterage = ""

	var SKILL_TEXT = """[召唤I]：战斗开始时，随机召唤[迦楼罗之灵/伊弗利特之灵/泰坦之灵]与召唤师共同作战
[毁荡]：冷却4s，对目标造成[90%]法强的{TMgiHurt}
[溃烂爆发]：冷却10s，对目标造成[120%]法强的{TMgiHurt}，根据目标当前debuff数量提高伤害，每个提高[30%]威力"""

	var SKILL_TEXT_1 = """[龙神附体]：冷却24s，自身魔法强度提高20%，持续8s
[龙神迸发]：{TPassive}龙神附体时，对目标及周围2格内的敌人造成[700%]法强的{TMgiHurt}"""

	var SKILL_TEXT_2 = """[不死鸟附体]：{TPassive}[龙神迸发]变为[不死鸟迸发]，伤害变为[760%]的同时会给目标附加20层[烧灼]"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
