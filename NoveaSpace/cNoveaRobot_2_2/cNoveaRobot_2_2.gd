extends "../cNoveaRobot_2/cNoveaRobot_2.gd"

var SkillText_2_2 = "{c_skill}[歼灭芯片]{/c}：安装了歼灭芯片的机器人，战斗力变得更可怕了！装备武器后，攻击力提高20%，{c_dark}【暗物质攻击】{/c}的武器除外"

func _extInit():
	._extInit()
	chaName = "EA-39 歼灭型"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2_2))
