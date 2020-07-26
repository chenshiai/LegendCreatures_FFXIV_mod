extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVSpirit_3"
const name_1 = {
	"zh_CN": "龙骑士",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "红血之龙",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "埃斯蒂尼安-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[高跳]：冷却11s，跳向生命值最低的敌人并攻击，造成[300%]的{TPhyHurt}(开战使用一次，不触发CD效果)。攻击后回到原位。
[苍天龙血]：{TPassive}[高跳]以及[坠星冲]的威力提高[30%]
[武神枪]：冷却12s，对直线上的敌人造成[400%]的{TPhyHurt}"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[坠星冲]：冷却27s，高高跃起，向随机一名敌人猛冲，对落点周围2格的敌人造成[700%]的{TPhyHurt}
[战斗连祷]：战斗开始后，使所有队友暴击率提高10%"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[舍弃苍天的龙骑士]：{TPassive}获得10%的物理吸血，10%的护甲穿透"
const SKILL_2_EN = ""
const SKILL_2_JA = ""


func _init():
	addTr({
		"%s-name_1" % [baseName]: name_1,
		"%s-name_2" % [baseName]: name_2,
		"%s-name_3" % [baseName]: name_3,
		"%s-skill_text" % [baseName]: {
			"zh_CN": SKILL_CN,
			"en": SKILL_EN,
			"ja": SKILL_JA
		},
		"%s-skill_text_1" % [baseName]: {
			"zh_CN": SKILL_1_CN,
			"en": SKILL_1_EN,
			"ja": SKILL_1_JA
		},
		"%s-skill_text_2" % [baseName]: {
			"zh_CN": SKILL_2_CN,
			"en": SKILL_2_EN,
			"ja": SKILL_2_JA
		},
	})