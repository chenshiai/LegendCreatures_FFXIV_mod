static func getCharaData():
	var name_1 = "白魔法师"
	var name_2 = "角尊之白"
	var name_3 = "嘉恩·艾·神纳-传奇"

	var meterage = ""

	var SKILL_TEXT = """[救疗]：冷却9s，为生命最低的友方单位恢复[80%]法强的生命值
[医济]：冷却14s，为全体友方单位恢复[50%]法强的HP，并附加[再生]效果，持续8s
[再生]：冷却18s，为生命最低的友方单位附加再生，每秒恢复[10%]法强的HP，持续10s"""

	var SKILL_TEXT_1 = """[天赐祝福]：冷却20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却延长至60s
[闪耀]：冷却4s，对目标造成[100%]的{TMgiHurt}"""

	var SKILL_TEXT_2 = """[法令]：冷却19s，对周围3格内的敌人造成[270%]法强的{TMgiHurt}，同时为范围内的队友恢复[90%]法强的HP"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
