static func getCharaData():
	var name_1 = "机工士"
	var name_2 = "咆哮之火"
	var name_3 = "希尔达-传奇"

	var meterage = ""

	var SKILL_TEXT = """[车式浮空炮塔]：冷却3s，机工士自带的浮空炮塔进行援护射击造成[50%]的{TPhyHurt}
[超载]：{TPassive}浮空炮攻击5次后进入超载，机工士攻击力提升20%，持续8s。
[野火]：冷却17s，开局释放一次。对目标附加野火状态，持续7s，结束后爆炸造成[野火期间的攻击次数 x 200%]的{TPhyHurt}"""

	var SKILL_TEXT_1 = """[钻头]：冷却12s，对目标造成[400%]的{TPhyHurt}
[策动]：{TPassive}战斗开始时，为自身和所有队友附加[策动]，受到的伤害减少10%
不可与吟游诗人的[行吟]、舞者的[防守之桑巴]效果叠加"""

	var SKILL_TEXT_2 = """[整备]：{TPassive}获得30%的暴击率加成，且技能可以产生暴击
[机工士的明天！]：{TPassive}车式浮空炮增加至三个，多出的浮空炮不会累计攻击次数"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
