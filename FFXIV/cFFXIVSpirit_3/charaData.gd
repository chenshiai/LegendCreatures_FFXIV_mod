static func getCharaData():
	var name_1 = "龙骑士"
	var name_2 = "红血之龙"
	var name_3 = "埃斯蒂尼安-传奇"

	var meterage = ""

	var SKILL_TEXT = """[高跳]：冷却11s，跳向生命值最低的敌人并攻击，造成[300%]的{TPhyHurt}(开战使用一次，不触发CD效果)。攻击后回到原位。
[苍天龙血]：{TPassive}[高跳]以及[坠星冲]的威力提高[30%]
[武神枪]：冷却12s，对直线上的敌人造成[400%]的{TPhyHurt}"""

	var SKILL_TEXT_1 = """[坠星冲]：冷却27s，高高跃起，向随机一名敌人猛冲，对落点周围2格的敌人造成[700%]的{TPhyHurt}
[战斗连祷]：战斗开始后，使所有队友暴击率提高10%"""

	var SKILL_TEXT_2 = """[舍弃苍天的龙骑士]：{TPassive}获得10%的物理吸血，10%的护甲穿透"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
