static func getCharaData():
	var name_1 = "吟游诗人"
	var name_2 = "红叶之诗"
	var name_3 = "让尔泰-传奇"

	var meterage = ""

	var SKILL_TEXT = """[伶牙俐齿]：冷却5s，对目标发动一次额外的普通攻击，并附加5层[流血][中毒]
[贤者的叙事谣]：冷却16s，对目标发动一次额外的普通攻击，并使队伍全员攻击伤害提高5%，持续8s，此效果无法叠加
[大地神的抒情恋歌]：冷却20s，以生命值最少的队员为目标，使其受到的治疗效果提高20%，持续10s"""

	var SKILL_TEXT_1 = """[辉煌箭]：{TPassive}普通攻击有20%的概率触发，对目标造成[350%]的{TPhyHurt}
[行吟]：{TPassive}战斗开始时，为自身和所有队友附加[行吟]，受到的伤害减少10%
不可与舞者的[防守之桑巴]、机工士的[策动]效果叠加"""

	var SKILL_TEXT_2 = """[绝峰箭]：冷却12s，射出穿透箭对直线上单位造成[400%]的{TPhyHurt}，并赋予5层[流血]"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
