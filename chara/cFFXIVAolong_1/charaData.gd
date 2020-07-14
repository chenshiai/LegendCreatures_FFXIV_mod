static func getCharaData():
	var name_1 = "暗黑骑士"
	var name_2 = "深渊之暗"
	var name_3 = "希德勒格-传奇"
	var meterage = "暗血：%d / 700"
	var SKILL_TEXT = """[深恶痛绝]：{TPassive}战斗开始时，魔法防御提高10%，受到的伤害减少20%
[噬魂斩]：{TPassive}第三次普通攻击造成[110%]的伤害，并恢复自身5%的HP
[血溅]：冷却10s，对目标造成[290%]的{TPhyHurt}"""
	var SKILL_TEXT_1 = """[至黑之夜]：造成非特效伤害时会累计暗血，达到700点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却12s，使队伍全员受到的{TMgiHurt}减少10%，持续6s"""
	var SKILL_TEXT_2 = "[掠影示现]：{TPassive}令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害，自身最大生命值提高"

	match TranslationServer.get_locale():
		"en":
			name_1 = "DarkKnight"
			name_2 = "DarkKnight-I"
			name_3 = "DarkKnight-II"
			meterage = "Blackblood：%d / 700"
			SKILL_TEXT = """[Grit]：When battle start. Magic defense increased{c_base}(10%){/c}. Reduce damage taken{c_base}(20%){/c}
[Souleater]：When 3rd normal attack. Damage increased to {c_base}[110%]{/c} and recover HP{c_base}(5%){/c}
[Bloodspiller]：(10s), Cause {c_phy}[290%]{/c} physical damage"""
			SKILL_TEXT_1 = """[The Blackest Night]：When BlackBlood achieve 700 points, will release the shield{c_base}(20% of maximum HP){/c}
[Dark Missionary]：(12s), Reduce magic damage{c_base}(10%){/c} to all members, lasting 6s"""
			SKILL_TEXT_2 = "[Living Shadow]：Self damage increased{c_base}(30%){/c}, maximum HP increased"
		"ja":
			name_1 = "暗黒の騎士"
			name_2 = "暗黒の騎士-I"
			name_3 = "暗黒の騎士-II"
			meterage = "ブラックブラッド: %d / 700"
			SKILL_TEXT = """[グリットスタンス]：戦闘開始時、魔法防御は10%アップし、受けるダメージは20%減少します
[ソウルイーター]：第三次通常攻撃で[110%]のダメージを与え、自身の5%のHPを回復する
[ブラッドスピラー]：10 s冷却し、目標に対して[290%]の物理的ダメージを与える"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
	