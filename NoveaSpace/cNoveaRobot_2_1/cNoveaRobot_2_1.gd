extends "../cNoveaRobot_2/cNoveaRobot_2.gd"

var SkillText_2_1 = "{c_skill}[防御芯片]{/c}：安装了防御芯片的机器人，防御力变得更强了！受到的所有伤害减少{c_base}20%{/c}"

func _extInit():
	._extInit()
	chaName = "NOVEA-45 防御型"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2_1))
