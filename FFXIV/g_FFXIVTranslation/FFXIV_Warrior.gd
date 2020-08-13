extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVHumen_1"
const name_1 = {
	"zh_CN": "战士",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "纯爱之斧",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "阿尔伯特-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[守护]：{TPassive}受到的伤害减少20%
[战栗]：冷却10s，立即治疗10%的最大生命值。然后最大生命值提高20%，受到的治疗量提高20%，持续10s"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[裂石飞环]：冷却4s，下一次普通攻击对目标造成[350%]的{TPhyHurt}
[原初的解放]：冷却16s，获得100%的暴击率提升，持续8s"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = """[地毁人亡]：冷却12s，对周围2格内的敌人造成[180%]的{TPhyHurt}
[死斗]：濒死时开启，使自身生命值不会低于1(除特定攻击外)，持续7s，然后恢复20%的生命值，最多触发一次"""
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