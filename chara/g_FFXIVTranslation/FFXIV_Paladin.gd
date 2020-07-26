extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVRuga_1"
const name_1 = {
	"zh_CN": "骑士",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "冠军之剑",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "杰林斯-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[钢铁信念]：{TPassive}提高10%的物理防御，受到的伤害减少20%
[深仁厚泽]：冷却15s，为生命最低的友方单位使用治疗魔法，恢复[1200%]法强的生命值
[王权剑]：冷却6s，对目标造成[350%]的{TPhyHurt}"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[圣光幕帘]：冷却26s，技能开启后的5s内，若自身有受到治疗，则为周围其他队友附加护盾，可以抵消[骑士最大生命值10%]的伤害，持续10s
[盾阵]：{TPassive}受到攻击时有30%的概率减少15%的伤害"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[神圣领域]：战斗开始时开启无敌，持续10s，之后每70s使用一次"
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