extends "../Base/BaseChara.gd"

var SkillText = """{c_skill}[机械构造]{/c}：可以在大多数的极端环境下行动。
受到{c_ele}【电能攻击】{/c}的伤害提高至{c_base}200%{/c}。
受到{c_bul}【实弹攻击】{/c}的伤害降低至{c_base}50%{/c}。
{c_skill}[机器采集]{/c}：开启【机器采集】功能"""

func _extInit():
	._extInit()
	chaName = "机器人"
	lv = 1
	attCoe.atkRan = 1
	attCoe.maxHp = 16
	attCoe.atk = 14
	attCoe.mgiAtk = 4
	attCoe.def = 1
	attCoe.mgiDef = 1
	evos = ["cNoveaRobot_1", "cNoveaRobot_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText))
	