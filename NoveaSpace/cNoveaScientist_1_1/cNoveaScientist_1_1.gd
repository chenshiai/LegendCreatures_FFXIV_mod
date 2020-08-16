extends "../cNoveaScientist_1/cNoveaScientist_1.gd"

var SkillText_1_1 = "{c_skill}[构造专精]{/c}：解锁构造体研究路线。"

func _extInit():
	._extInit()
	chaName = "构造体研究学家"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1_1))
