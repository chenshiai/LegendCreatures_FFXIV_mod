extends "../cNoveaSoldier_2/cNoveaSoldier_2.gd"

var SkillText_2_1 = "{c_skill}[？？？]{/c}：？？？"

func _extInit():
	._extInit()
	chaName = "地面突击兵"
	lv = 3
	evos = []
	addSkillTxt(TEXT.format(SkillText_2_1))
