extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVHumen_2"
const name_1 = {
	"zh_CN": "绝枪战士",
	"en": "Gunbreaker",
	"ja": "ガンブレイカー"
}
const name_2 = {
	"zh_CN": "守约之刃",
	"en": "Gunbreaker-I",
	"ja": "ガンブレイカー-I"
}
const name_3 = {
	"zh_CN": "桑克瑞德-传奇",
	"en": "Gunbreaker-II",
	"ja": "ガンブレイカー-II"
}

const SKILL_CN = """[王室亲卫]：{TPassive}受到的伤害减少20%
[弓形冲波]：冷却9s，对周围2格的敌人造成{c_phy}[260%]{/c}的物理伤害，并附加4层[烧灼]"""
const SKILL_EN = """[Royal Guard]：Reduce damage taken{c_base}(20%){/c}
[Bow Shock]：(10s), Deal {c_phy}[260%]{/c} of physical damage to enemies in 2 spaces around you, and add 4 layers [burn]"""
const SKILL_JA = """[ロイヤルガード]：受けるダメージは{c_base}20%{/c}減少します
[バウショック]：9s、周囲2コマの敵に{c_phy}[260%]{/c}の物理ダメージを与え、さらに4層[焼灼]を加える"""

const SKILL_1_CN = """[续剑]：{TPassive}攻击速度提高30%，普通攻击会附加{c_base}35%{/c}攻击力的魔法伤害
[超火流星]：{TPassive}生命值低于5%时，8s内免疫任何伤害，生命值降为1点，最多触发一次"""
const SKILL_1_EN = """[Continuation]：Attack speed increased{c_base}(30%){/c}. Normal attack will add {c_base}35%{/c} attack power magic damage
[Superbolide]：When HP is lower than {c_base}5%{/c}, you will be immune to any damage within {c_base}8s{/c}, and HP will be reduced to 1, which will trigger once at most"""
const SKILL_1_JA = """[コンティニュエーション]：攻撃速度が{c_base}30%{/c}アップし、通常攻撃には攻撃力{c_base}35%{/c}の魔法ダメージが付加されます
[ボーライド]：死亡に瀕した時、8s内の免疫による任意のダメージは、HPが1ポイントまで下がり、最大一回トリガします"""

const SKILL_2_CN = "[爆破领域]：冷却10s，对目标造成{c_phy}[380%]{/c}的物理伤害"
const SKILL_2_EN = "[Blasting Zone]：(10s), Cause {c_phy}[380%]{/c} physical damage"
const SKILL_2_JA = "[ブラスティングゾーン]：10s、目標に対して{c_phy}[380%]{/c}の物理的ダメージを与える"

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