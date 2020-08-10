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

const SKILL_CN = """[伶牙俐齿]：冷却5s，对目标发动一次额外的普通攻击，并附加5层[流血][中毒]
[贤者的叙事谣]：冷却16s，对目标发动一次额外的普通攻击，并使队伍全员攻击伤害提高{c_base}5%{/c}，持续8s，此效果无法叠加
[大地神的抒情恋歌]：冷却20s，以生命值最少的队员为目标，使其受到的治疗效果提高{c_base}20%{/c}，持续10s"""

const SKILL_EN = """[Iron Jaws]：(5s), Launch an additional Normal-Attack on the target, And add 5 layers [bleeding] [poisoning]
[Mage's Ballad]：(16s), Launch an additional Normal-Attack on the target, And increases ally damage by {c_base}5%{/c} for 8 seconds. This effect cannot be stacked
[Nature's Minne]：(20s), Increases the healing effect of HP's least allies by {c_base}20%{/c}, lasting for 10 seconds"""

const SKILL_JA = """"""


const SKILL_1_CN = """[辉煌箭]：{TPassive}普通攻击有{c_base}20%{/c}的概率触发，对目标造成{c_phy}[350%]{/c}的物理伤害
[行吟]：{TPassive}战斗开始时，为自身和所有队友附加{c_skill}[行吟]{/c}，受到的伤害减少{c_base}10%{/c}
不可与舞者的{c_skill}[防守之桑巴]{/c}、机工士的{c_skill}[策动]{/c}效果叠加"""

const SKILL_1_EN = """[Refulgent Arrow]：Trigger with {c_base}20%{/c} probability in Normal-Attack, causing {c_phy}[350%]{/c} physical damage to the target
[Troubadour]：Reduce damage taken by allies by {c_base}10%{/c}, Cannot be superimposed with {c_skill}[Tactician]{/c} and {c_skill}[Shield Samba]{/c}"""

const SKILL_1_JA = """"""


const SKILL_2_CN = "[绝峰箭]：冷却12s，射出穿透箭对直线上单位造成{c_phy}[400%]{/c}的物理伤害，并赋予5层[流血]"
const SKILL_2_EN = "[Apex Arrow]：(12s), Deals {c_phy}[400%]{/c} physical damage to all enemies in a straight line, And add 5 layers [bleeding]"
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