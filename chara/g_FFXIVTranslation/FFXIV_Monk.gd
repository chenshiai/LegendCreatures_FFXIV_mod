extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVRuga_2"
const name_1 = {
	"zh_CN": "武僧",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "复教之拳",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "莉瑟-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[迅雷疾风]：{TPassive}增加16%的攻击速度，且在攻击时，获得2层[急速]
[斗气]：{TPassive}每攻击有35%概率获得1点斗气，最大5点，满5点后会立即释放[阴阳斗气斩]，不计入冷却
[阴阳斗气斩]：冷却10s，对目标造成[210%]的{TPhyHurt}，消耗斗气提高伤害，每点斗气提高[20%]的倍率，最大[310%]"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[金刚决意]：{TPassive}受到的伤害减少10%
[六合星导腿]：冷却12s，对目标造成[400%]的{TPhyHurt}，自身每层[急速]可以提高[5%]的伤害"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[红莲极意]：{TPassive}复国领袖，提升25%的攻击力"
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