extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVLarafel_2"
const name_1 = {
	"zh_CN": "黑魔法师",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "魔石之黑",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "帕帕力莫-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[玄冰]：冷却4s，对目标及周围一格的敌人造成[150%]的{TMgiHurt}
[灵极冰]：{TPassive}使用[玄冰]后降低[爆炎]的冷却四次，重置[爆炎]的伤害提升阶段
[爆炎]：冷却26s，对目标造成[240%]的{TMgiHurt}
[星极火]：{TPassive}[爆炎]释放后，后续的[爆炎]伤害增加30%，延长[玄冰]的冷却"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[黑魔纹]：冷却50s，开局立即释放一次，加快自身15%的技能冷却，持续30s
[异言]：冷却30s，对目标造成[750%]法强的{TMgiHurt}"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[最好的学生]：{TPassive}提高30%的法强"
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