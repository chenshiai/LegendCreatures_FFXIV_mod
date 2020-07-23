extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVAolong_1"
const name_1 = {
	"zh_CN": "暗黑骑士",
	"en": "DarkKnight",
	"ja": "暗黒騎士"
}
const name_2 = {
	"zh_CN": "深渊之暗",
	"en": "DarkKnight-I",
	"ja": "暗黒騎士-I"
}
const name_3 = {
	"zh_CN": "希德勒格-传奇",
	"en": "DarkKnight-II",
	"ja": "暗黒騎士-II"
}

const SKILL_CN = """[深恶痛绝]：{TPassive}魔法防御提高10%，受到的伤害减少20%
[噬魂斩]：{TPassive}第三次普通攻击造成[110%]的伤害，并恢复自身5%的HP
[血溅]：冷却10s，对目标造成[290%]的{TPhyHurt}"""
const SKILL_EN = """[Grit]：When battle start. Magic defense increased{c_base}(10%){/c}. Reduce damage taken{c_base}(20%){/c}
[Souleater]：When 3rd normal attack. Damage increased to {c_phy}[110%]{/c} and recover HP{c_base}(5%){/c}
[Bloodspiller]：(10s), Cause {c_phy}[290%]{/c} physical damage"""
const SKILL_JA = """[グリットスタンス]：戦闘開始時、魔法防御は{c_base}10%{/c}アップし、受けるダメージは{c_base}20%{/c}減少します
[ソウルイーター]：第三次通常攻撃で{c_phy}[110%]{/c}のダメージを与え、自身の{c_base}5%{/c}のHPを回復する
[ブラッドスピラー]：10s、目標に対して{c_phy}[290%]{/c}の物理的ダメージを与える"""

const SKILL_1_CN = """[至黑之夜]：造成非特效伤害时会累计暗血，达到700点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却12s，使队伍全员受到的{TMgiHurt}减少10%，持续6s"""
const SKILL_1_EN = """[The Blackest Night]：When BlackBlood achieve 700 points, will release the shield{c_base}(20% of maximum HP){/c}
[Dark Missionary]：(12s), Reduce magic damage{c_base}(10%){/c} to all members, lasting 6s"""
const SKILL_1_JA = """[ブラックナイト]：特殊効果でないダメージを与えた場合、暗血が累計されて700ポイントに達した時、一定量のダメージを防ぐバリアを張る。最大HPの{c_base}20%{/c}のダメージを軽減する
[ダークミッショナリー]：12s、自身と周囲のパーティメンバーの被魔法ダメージを{c_base}10％{/c}軽減させる、効果時間：6s"""

const SKILL_2_CN = "[掠影示现]：{TPassive}令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害，自身最大生命值提高"
const SKILL_2_EN = "[Living Shadow]：Self damage increased{c_base}(30%){/c}, maximum HP increased"
const SKILL_2_JA = "[影身具現]：自身と共に戦う「英雄の影身」を具現化する、本体の{c_base}[30%]{/c}の傷つけることをもたらして、自身の最大の生命値は高めます。"

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