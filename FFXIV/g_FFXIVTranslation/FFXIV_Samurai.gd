extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVAolong_2"
const name_1 = {
	"zh_CN": "武士",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "无双之士",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "无双斋-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[雪/月/花]：{TPassive}攻击力提升10%，攻速提升10%，技能可以产生暴击。每2次攻击随机获得[雪][月][花]印记
[居合术]：每第6次攻击后，第7次攻击将发动[纷乱雪月花]
[纷乱雪月花]：对目标造成[250%][360%][800%]的{TPhyHurt}，印记种类越多伤害越高"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[燕回返]：冷却14s，发动上一次使用的居合术，并且使伤害提高50%"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[照破]：{TPassive}释放[居合术]后累计一层剑压，达到三层后对目标造成[400%]的{TPhyHurt}"
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