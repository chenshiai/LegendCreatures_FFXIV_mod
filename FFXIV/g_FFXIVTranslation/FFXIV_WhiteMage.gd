extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVLarafel_1"
const name_1 = {
	"zh_CN": "白魔法师",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "角尊之白",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "嘉恩·艾·神纳-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[救疗]：冷却9s，为生命最低的友方单位恢复[80%]法强的生命值
[医济]：冷却14s，为全体友方单位恢复[50%]法强的HP，并附加[再生]效果，持续8s
[再生]：冷却18s，为生命最低的友方单位附加再生，每秒恢复[10%]法强的HP，持续10s"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[天赐祝福]：冷却20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却延长至60s
[闪耀]：冷却4s，对目标造成[100%]的{TMgiHurt}"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[法令]：冷却19s，对周围3格内的敌人造成[270%]法强的{TMgiHurt}，同时为范围内的队友恢复[90%]法强的HP"
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