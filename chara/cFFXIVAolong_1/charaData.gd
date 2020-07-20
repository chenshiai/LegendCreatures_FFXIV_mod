static func getCharaData():
	var locale = TranslationServer.get_locale()
	var name_1 = {
		"zh_CN": "暗黑骑士",
		"en": "DarkKnight",
		"ja": "暗黒の騎士"
	}
	var name_2 = {
		"zh_CN": "深渊之暗",
		"en": "DarkKnight-I",
		"ja": "暗黒の騎士-I"
	}
	var name_3 = {
		"zh_CN": "希德勒格-传奇",
		"en": "DarkKnight-II",
		"ja": "暗黒の騎士-II"
	}
	var meterage = {
		"zh_CN": "暗血：%d / 700",
		"en": "Blackblood：%d / 700",
		"ja": "ブラックブラッド: %d / 700"
	}
	var SKILL_CN = """[深恶痛绝]：{TPassive}魔法防御提高10%，受到的伤害减少20%
[噬魂斩]：{TPassive}第三次普通攻击造成[110%]的伤害，并恢复自身5%的HP
[血溅]：冷却10s，对目标造成[290%]的{TPhyHurt}"""
	var SKILL_EN = """[Grit]：When battle start. Magic defense increased{c_base}(10%){/c}. Reduce damage taken{c_base}(20%){/c}
[Souleater]：When 3rd normal attack. Damage increased to {c_base}[110%]{/c} and recover HP{c_base}(5%){/c}
[Bloodspiller]：(10s), Cause {c_phy}[290%]{/c} physical damage"""
	var SKILL_JA = """[グリットスタンス]：戦闘開始時、魔法防御は10%アップし、受けるダメージは20%減少します
[ソウルイーター]：第三次通常攻撃で[110%]のダメージを与え、自身の5%のHPを回復する
[ブラッドスピラー]：10s、目標に対して[290%]の物理的ダメージを与える"""

	var SKILL_1_CN = """[至黑之夜]：造成非特效伤害时会累计暗血，达到700点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却12s，使队伍全员受到的{TMgiHurt}减少10%，持续6s"""
	var SKILL_1_EN = """[The Blackest Night]：When BlackBlood achieve 700 points, will release the shield{c_base}(20% of maximum HP){/c}
[Dark Missionary]：(12s), Reduce magic damage{c_base}(10%){/c} to all members, lasting 6s"""
	var SKILL_1_JA = """[ブラックナイト]：特殊効果でないダメージを与えた場合、暗血が累計されて700ポイントに達した時、最大生命値の20%を吸収するシールドをリリースします。
[ダークミッショナリー]：12s、チーム全員が受ける魔法ダメージを10%低減し、6 s継続する"""

	var SKILL_2_CN = "[掠影示现]：{TPassive}令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害，自身最大生命值提高"
	var SKILL_2_EN = "[Living Shadow]：Self damage increased{c_base}(30%){/c}, maximum HP increased"
	var SKILL_2_JA = "[影身具現]：英雄のかすめ取る影を実体に変えて自身と共に戦うことを譲って、本体と同時に攻撃して、本体の[30%]の傷つけることをもたらして、自身の最大の生命値は高めます。"

	var skill_text = {
		"zh_CN": SKILL_CN,
		"en": SKILL_EN,
		"ja": SKILL_JA
	}

	var skill_text_1 = {
		"zh_CN": SKILL_1_CN,
		"en": SKILL_1_EN,
		"ja": SKILL_1_JA
	}

	var skill_text_2 = {
		"zh_CN": SKILL_2_CN,
		"en": SKILL_2_EN,
		"ja": SKILL_2_JA
	}

	return {
		"name_1": name_1[locale],
		"name_2": name_2[locale],
		"name_3": name_3[locale],
		"meterage": meterage[locale],
		"SKILL_TEXT": skill_text[locale],
		"SKILL_TEXT_1": skill_text_1[locale],
		"SKILL_TEXT_2": skill_text_2[locale]
	}
	