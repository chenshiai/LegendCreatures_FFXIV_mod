static func getCharaData():
	var name_1 = "占星术士-昼"
	var name_2 = "东天之星-昼"
	var name_3 = "蕾薇瓦-传奇"

	var meterage = ""

	var SKILL_TEXT = """[煞星]：冷却4s，对目标造成[70%]的{TMgiHurt}
[抽卡]：冷却20s，随机抽取一张卡施加效果给全部队友，持续20s。此技能开局释放一次，不记入CD
{c_balance}太阳神之衡{/c}[双攻提升20%]；{c_arrow}放浪神之箭{/c}[攻击速度20%]；{c_spear}战争神之枪{/c}[暴击增加20%]；
{c_bole}世界树之干{/c}[物防提升20%]；{c_ewer}河流神之瓶{/c}[冷却缩减20%]；{c_spire}建筑神之塔{/c}[魔防提升20%]。
[阳星相位]：冷却16s，恢复全场友军[60%]法强的HP
[白昼学派]：{TPassive}阳星相位会给目标施加持续恢复效果，每秒恢复[10%]法强的HP，持续5秒"""

	var SKILL_TEXT_1 = """[袖内抽卡]：冷却25s，连续使用三次[抽卡]
[星位合图]：{TPassive}提高10%的法强"""

	var SKILL_TEXT_2 = """[天星交错]：{TPassive}阳星相位现在会附加[黑夜领域]的效果"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
