static func getCharaData():
	var name_1 = "忍者"
	var name_2 = "化身为影"
	var name_3 = "夕雾-传奇"

	var meterage = ""

	var SKILL_TEXT = """[隐遁]：{TPassive}获得30%的闪避，移动速度提高50
[攻其不备]：冷却15s，对目标造成[300%]的{TPhyHurt}，并目标受到的任何伤害增加20%，持续10s{c_base}
[忍术]：冷却11s，从{ten}/{chi}/{jin}中连续结出两个手印，并根据结印顺序释放以下忍术
[风魔手里剑]：两个相同手印，对魔法强度最高的一名敌人造成{c_phy}[500%]{/c}的{TPhyHurt}
[火遁之术]：{chi}{ten}/{jin}{ten}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[烧灼]
[雷遁之术]：{ten}{chi}/{jin}{chi}对目标造成{c_phy}[480%]{/c}的{TMgiHurt}
[冰遁之术]：{ten}{jin}/{chi}{jin}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[结霜]{/c}"""

	var SKILL_TEXT_1 = """{c_base}[生杀予夺]：冷却26s，强化一次忍术。{TPassive}自身伤害提高30%
[冰晶乱流之术]：[冰遁之术]强化：对目标造成{c_phy}[1200%]{/c}的魔法伤害
[劫火灭却之术]：[火遁之术]强化：对目标及周围2格范围内的敌人造成{c_phy}[700%]{/c}的魔法伤害{/c}"""

	var SKILL_TEXT_2 = "[强甲破点突]：冷却16s，开局释放一次，削弱目标的15%的双抗，若目标的仇恨不是自己，则数值提高为30%。持续7s"

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}