static func getCharaData():
	var name_1 = "赤魔法师"
	var name_2 = "抗争之红"
	var name_3 = "西·如恩·提亚-传奇"

	var meterage = "白魔元：%d / 100	黑魔元：%d / 100"

	var SKILL_TEXT = """[连续咏唱]：{TPassive}攻击型技能会连续释放两次（只触发一次CD效果）
[赤闪雷/赤疾风]：冷却8s，对目标造成{c_mgi}[120%]{/c}法强的魔法伤害，随机获得[黑/白]魔元15点
[魔连攻]：{TPassive}攻击时同时消耗25点黑白魔元，使此次普通攻击造成的伤害提升至{c_mgi}[500%]{/c}"""

	var SKILL_TEXT_1 = """[赤核爆/赤神圣]：{TPassive}使用魔连攻后，立即追加释放一次[赤闪雷/赤疾风]且伤害变为{c_mgi}[230%]{/c}
[倍增]：冷却20s，使当前的黑/白魔元翻倍，且魔法攻击提高10%，持续10s"""

	var SKILL_TEXT_2 = """[抗争之力]：{TPassive}当黑白魔元失衡时（差距大于30），释放[赤疾风/赤闪雷]会使量少的魔元提高10点"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
