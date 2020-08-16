extends "../cNoveaScientist_2/cNoveaScientist_2.gd"

var SkillText_2_1 = "{c_skill}[强化研究]{/c}：解锁机体研究路线。"

func _extInit():
	._extInit()
	chaName = "机能研究学家"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2_1))
