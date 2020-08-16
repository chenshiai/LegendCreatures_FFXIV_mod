extends "../cNoveaSoldier/cNoveaSoldier.gd"

var SkillText_2 = "{c_skill}[地面作战强化]{/c}：强化训练，大幅加强在地面的战斗能力。"

func _extInit():
	._extInit()
	chaName = "突击兵"
	lv = 2
	evos = ["cNoveaSoldier_2_1", "cNoveaSoldier_2_2"]
	addSkillTxt(TEXT.format(SkillText_2))
