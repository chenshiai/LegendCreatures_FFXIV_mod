extends "../cNoveaSoldier_2/cNoveaSoldier_2.gd"

var SkillText_2_2 = "{c_skill}[？？？]{/c}：？？？"

func _extInit():
	._extInit()
	chaName = "？？？"
	lv = 3
	evos = []
	addSkillTxt(TEXT.format(SkillText_2_2))
