extends "../cNoveaScientist/cNoveaScientist.gd"

var SkillText_2 = "{c_skill}[设备研究]{/c}：解锁设备研究路线。"

func _extInit():
	._extInit()
	chaName = "设备研究学家"
	lv = 2
	evos = ["cNoveaScientist_2_1", "cNoveaScientist_2_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2))
