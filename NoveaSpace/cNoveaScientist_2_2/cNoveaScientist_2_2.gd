extends "../cNoveaScientist_2/cNoveaScientist_2.gd"

var SkillText_2_2 = "{c_skill}[防御专精]{/c}：解锁防护设备研究路线。"

func _extInit():
	._extInit()
	chaName = "安全研究学家"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_2_2))
