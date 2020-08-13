extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVRuga_3"
const name_1 = {
	"zh_CN": "机工士",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "咆哮之火",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "希尔达-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[车式浮空炮塔]：冷却3s，机工士自带的浮空炮塔进行援护射击造成[50%]的{TPhyHurt}
[超载]：{TPassive}浮空炮攻击5次后进入超载，机工士攻击力提升20%，持续8s。
[野火]：冷却17s，开局释放一次。对目标附加野火状态，持续7s，结束后爆炸造成[野火期间的攻击次数 x 200%]的{TPhyHurt}"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[钻头]：冷却12s，对目标造成[400%]的{TPhyHurt}
[策动]：{TPassive}战斗开始时，为自身和所有队友附加[策动]，受到的伤害减少10%
不可与吟游诗人的[行吟]、舞者的[防守之桑巴]效果叠加"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = """[整备]：{TPassive}获得20%的暴击率加成，且技能可以产生暴击
[机工士的明天！]：{TPassive}车式浮空炮增加至三个，多出的浮空炮不会累计攻击次数"""
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