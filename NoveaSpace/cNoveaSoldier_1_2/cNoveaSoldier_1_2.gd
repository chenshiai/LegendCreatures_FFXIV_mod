extends "../cNoveaSoldier_1/cNoveaSoldier_1.gd"

var SkillText_1_ = "{c_skill}[？？？]{/c}：？？？。"

func _extInit():
	._extInit()
	chaName = "星际步兵"
	lv = 3
	evos = ["cNoveaSoldier_1_1", "cNoveaSoldier_1_2"]
	addSkillTxt(TEXT.format(SkillText_1))
