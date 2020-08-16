extends "../cNoveaEngineer_2/cNoveaEngineer_2.gd"

var SkillText_2_1 = TEXT.format("{c_skill}[高级武器专精]{/c}：解锁更高级的武器图纸。")

func _extInit():
	._extInit()
	chaName = "高级武器工程师"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2_1)