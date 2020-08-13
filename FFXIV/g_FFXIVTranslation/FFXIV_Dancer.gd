extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVHumen_3"
const name_1 = {
	"zh_CN": "舞者",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "心动之舞",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "娜休梅拉-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[伶俐]：{TPassive}技能可以产生暴击
[闭式舞姿]：{TPassive}战斗开始时，选择物攻最高与魔攻最高的队友作为舞伴，提高他们与自己的攻击力10%
[标准舞步]：冷却23s，对四格内的敌人造成[600%]的{TPhyHurt}，同时舞伴与自己的攻击力再提升10%，持续10s"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[剑舞]：冷却13s，对目标及周围2格敌人造成[100%]的{TPhyHurt}
[防守之桑巴]：{TPassive}战斗开始时，为自身和所有队友附加[防守之桑巴]，受到的伤害减少10%
不可与吟游诗人的[行吟]、机工士的[策动]效果叠加"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[进攻之探戈]：冷却18s，自身与舞伴的攻击力提高20%，持续8s"
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