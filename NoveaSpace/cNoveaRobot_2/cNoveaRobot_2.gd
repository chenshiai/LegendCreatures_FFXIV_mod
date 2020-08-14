extends "../cNoveaRobot/cNoveaRobot.gd"

var SkillText_2 = "{c_skill}[战斗芯片]{/c}：安装了战斗芯片的机器人，战斗力变得更强了！"

func _extInit():
	._extInit()
	chaName = "OTS-3 作战型"
	lv = 2
	attCoe.maxHp += 4
	attCoe.atk += 4
	attCoe.mgiAtk += 2
	attCoe.def += 2
	attCoe.mgiDef += 2
	evos = ["cNoveaRobot_2_1", "cNoveaRobot_2_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2))
