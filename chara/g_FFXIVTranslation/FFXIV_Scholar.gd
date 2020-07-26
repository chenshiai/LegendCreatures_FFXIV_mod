extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVNeko_1"
const name_1 = {
	"zh_CN": "学者",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "传承之学",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "阿尔菲诺-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[死炎法]：冷却4s，对目标造成[90%]的{TMgiHurt}
[鼓舞激励之策]：冷却10s，为生命最低的友方单位恢复[60%]法强的HP，并为其附加[鼓舞]
[鼓舞]：可以抵消[治疗量125%]的伤害，持续10s，无法与占星术士的[黑夜领域]叠加"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[士高气昂之策]：冷却17s，恢复自身和周围4格内队员[50%]法强的HP，并附加[鼓舞]效果
[野战治疗阵]：冷却20s，以自身为中心产生减轻伤害的防护区域
三格内的队友受到的伤害会减轻10%，并获得持续恢复效果，持续10s"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[我的梦想，就是拯救世界！]：{TPassive}护盾生成量变为[治疗量的225%]"
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