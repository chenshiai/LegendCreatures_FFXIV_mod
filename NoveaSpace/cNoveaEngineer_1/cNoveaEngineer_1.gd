extends "../cNoveaEngineer/cNoveaEngineer.gd"

var SkillText_1 = TEXT.format("{c_skill}[基建专精]{/c}：解锁基建建设的图纸。")

func _extInit():
	._extInit()
	chaName = "基建工程师"
	lv = 2
	evos = ["cNoveaEngineer_1_1", "cNoveaEngineer_1_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1)