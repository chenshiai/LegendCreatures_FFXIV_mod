extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVAolong_3"
const name_1 = {
	"zh_CN": "忍者",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "化身为影",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "夕雾-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[隐遁]：{TPassive}获得30%的闪避，移动速度提高50
[攻其不备]：冷却15s，对目标造成[300%]的{TPhyHurt}，并目标受到的任何伤害增加20%，持续10s{c_base}
[忍术]：冷却11s，从{ten}/{chi}/{jin}中连续结出两个手印，并根据结印顺序释放以下忍术
[风魔手里剑]：两个相同手印，对魔法强度最高的一名敌人造成{c_phy}[500%]{/c}的{TPhyHurt}
[火遁之术]：{chi}{ten}/{jin}{ten}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[烧灼]
[雷遁之术]：{ten}{chi}/{jin}{chi}对目标造成{c_phy}[480%]{/c}的{TMgiHurt}
[冰遁之术]：{ten}{jin}/{chi}{jin}对目标及周围2格的敌人造成{c_phy}[150%]{/c}的{TMgiHurt}，并附加5层[结霜]{/c}"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """{c_base}[生杀予夺]：冷却26s，强化一次忍术。{TPassive}自身伤害提高30%
[冰晶乱流之术]：[冰遁之术]强化：对目标造成{c_phy}[1200%]{/c}的魔法伤害
[劫火灭却之术]：[火遁之术]强化：对目标及周围2格范围内的敌人造成{c_phy}[700%]{/c}的魔法伤害{/c}"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[强甲破点突]：冷却16s，开局释放一次，削弱目标的15%的双抗，若目标的仇恨不是自己，则数值提高为30%。持续7s"
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