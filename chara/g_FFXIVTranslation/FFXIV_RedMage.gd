extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVLarafel_3"
const name_1 = {
	"zh_CN": "赤魔法师",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "抗争之红",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "西·如恩·提亚-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[连续咏唱]：{TPassive}攻击型技能会连续释放两次（只触发一次CD效果）
[赤闪雷/赤疾风]：冷却8s，对目标造成{c_mgi}[120%]{/c}法强的魔法伤害，随机获得[黑/白]魔元15点
[魔连攻]：{TPassive}攻击时同时消耗25点黑白魔元，使此次普通攻击造成的伤害提升至{c_mgi}[500%]{/c}"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[赤核爆/赤神圣]：{TPassive}使用魔连攻后，立即追加释放一次[赤闪雷/赤疾风]且伤害变为[220%]
[倍增]：冷却20s，使当前的黑/白魔元翻倍，且魔法攻击提高10%，持续10s"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[抗争之力]：{TPassive}当黑白魔元失衡时（差距大于30），释放[赤疾风/赤闪雷]会使量少的魔元提高10点"
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