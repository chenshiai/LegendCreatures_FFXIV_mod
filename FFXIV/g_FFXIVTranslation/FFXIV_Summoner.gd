extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVNeko_2"
const name_1 = {
	"zh_CN": "召唤师",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "首席之唤",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "次优召唤师-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[召唤I]：战斗开始时，随机召唤[迦楼罗之灵/伊弗利特之灵/泰坦之灵]与召唤师共同作战
[毁荡]：冷却4s，对目标造成[90%]法强的{TMgiHurt}
[溃烂爆发]：冷却10s，对目标造成[120%]法强的{TMgiHurt}，根据目标当前debuff数量提高伤害，每个提高[30%]威力"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[龙神附体]：冷却24s，自身魔法强度提高20%，持续8s
[龙神迸发]：{TPassive}龙神附体时，对目标及周围2格内的敌人造成[700%]法强的{TMgiHurt}"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[不死鸟附体]：{TPassive}[龙神迸发]变为[不死鸟迸发]，伤害变为[760%]的同时会给目标附加20层[烧灼]"
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