extends "../cNoveaEngineer/cNoveaEngineer.gd"

var SkillText_2 = TEXT.format("{c_skill}[武器专精]{/c}：解锁武器图纸。")

func _extInit():
	._extInit()
	chaName = "武器工程师"
	lv = 2
	evos = ["cNoveaEngineer_2_1", "cNoveaEngineer_2_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2)
