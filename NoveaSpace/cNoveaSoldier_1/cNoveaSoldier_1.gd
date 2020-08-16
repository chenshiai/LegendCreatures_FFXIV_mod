extends "../cNoveaSoldier/cNoveaSoldier.gd"

var SkillText_1 = "{c_skill}[太空作战强化]{/c}：强化训练，大幅减少在太空中作战的负面效果。"

func _extInit():
	._extInit()
	chaName = "太空兵"
	lv = 2
	evos = ["cNoveaSoldier_1_1", "cNoveaSoldier_1_2"]
	addSkillTxt(TEXT.format(SkillText_1))
