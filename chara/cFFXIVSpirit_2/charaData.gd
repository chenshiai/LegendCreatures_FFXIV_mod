static func getCharaData():
	var name_1 = "占星术士-夜"
	var name_2 = "东天之星-夜"
	var name_3 = "于里昂热-传奇"

	var meterage = ""

	var SKILL_TEXT = """[煞星]：冷却4s，对目标造成[70%]的{TMgiHurt}
[抽卡]：冷却20s，随机抽取一张卡施加效果给全部队友，持续20s。此技能开局释放一次，不记入CD
{c_balance}太阳神之衡{/c}[双攻提升20%]；{c_arrow}放浪神之箭{/c}[攻击速度20%]；{c_spear}战争神之枪{/c}[暴击增加20%]；
{c_bole}世界树之干{/c}[物防提升20%]；{c_ewer}河流神之瓶{/c}[冷却缩减20%]；{c_spire}建筑神之塔{/c}[魔防提升20%]。
[阳星相位]：冷却15s，恢复全场友军[60%]法强的HP，并附加[黑夜领域]效果
[黑夜学派]：{TPassive}[黑夜领域]可以抵消[治疗量125%]的伤害，持续10秒，无法与学者的[鼓舞]叠加"""

	var SKILL_TEXT_1 = """[小奥秘卡]：{TPassive}每次使用[抽卡]后，随机释放以下效果
[王冠之领主]：对攻击目标造成[100%]法强的{TMgiHurt}
[王冠之贵妇]：为生命值最低的友方单位恢复[100%]法强的HP"""

	var SKILL_TEXT_2 = """[天星交错]：{TPassive}阳星相位现在会附加[持续恢复]的效果"""

	return {
		"name_1": name_1,
		"name_2": name_2,
		"name_3": name_3,
		"meterage": meterage,
		"SKILL_TEXT": SKILL_TEXT,
		"SKILL_TEXT_1": SKILL_TEXT_1,
		"SKILL_TEXT_2": SKILL_TEXT_2
	}
