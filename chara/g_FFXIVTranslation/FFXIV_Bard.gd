extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVNeko_3"
const name_1 = {
	"zh_CN": "吟游诗人",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "红叶之诗",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "让尔泰-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[伶牙俐齿]：冷却10s，对目标发动一次额外的普通攻击，并附加5层[流血][中毒]
[贤者的叙事谣]：冷却16s，对目标发动一次额外的普通攻击，并使队伍全员攻击伤害提高5%，持续8s，此效果无法叠加
[大地神的抒情恋歌]：冷却20s，以生命值最少的队员为目标，使其受到的治疗效果提高20%，持续10s"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[辉煌箭]：{TPassive}普通攻击有20%的概率触发，对目标造成」{c_phy}[330%]{/c}的物理伤害
[行吟]：{TPassive}战斗开始时，为自身和所有队友附加[行吟]，受到的伤害减少10%
不可与舞者的[防守之桑巴]、机工士的[策动]效果叠加"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[绝峰箭]：冷却12s，射出穿透箭对直线上单位造成{c_phy}[400%]{/c}的物理伤害，并赋予5层[流血]"
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