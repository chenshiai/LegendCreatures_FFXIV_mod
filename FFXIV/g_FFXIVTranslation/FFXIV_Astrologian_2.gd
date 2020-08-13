extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVSpirit_1"
const name_1 = {
	"zh_CN": "占星术士-夜",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "东天之星-夜",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "于里昂热-传奇",
	"en": "",
	"ja": ""
}

const SKILL_CN = """[煞星]：冷却4s，对目标造成{c_mgi}[70%]{/c}的魔法伤害
[抽卡]：冷却20s，随机抽取一张卡施加效果给全部队友，持续20s。此技能开局释放一次，不记入CD
{c_balance}太阳神之衡{/c}[双攻提升20%]；{c_arrow}放浪神之箭{/c}[攻击速度20%]；{c_spear}战争神之枪{/c}[暴击增加20%]；
{c_bole}世界树之干{/c}[物防提升20%]；{c_ewer}河流神之瓶{/c}[冷却缩减20%]；{c_spire}建筑神之塔{/c}[魔防提升20%]。
[阳星相位]：冷却15s，恢复全场友军{c_mgi}[60%]{/c}法强的HP，并附加[黑夜领域]效果
[黑夜学派]：{TPassive}[黑夜领域]可以抵消[治疗量125%]的伤害，持续10秒，无法与学者的[鼓舞]叠加"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """[小奥秘卡]：{TPassive}每次使用[抽卡]后，随机释放以下效果
[王冠之领主]：对攻击目标造成{c_mgi}[100%]{/c}法强的魔法伤害
[王冠之贵妇]：为生命值最低的友方单位恢复{c_mgi}[100%]{/c}法强的HP"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = "[天星交错]：{TPassive}阳星相位现在会附加[持续恢复]的效果"
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
		}
	})