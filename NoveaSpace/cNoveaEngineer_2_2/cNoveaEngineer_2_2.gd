extends "../cNoveaEngineer_2/cNoveaEngineer_2.gd"

var SkillText_2_2 = TEXT.format("{c_skill}[熔炼武器专精]{/c}：解锁熔炼系列的武器图纸，略微降低建设所消耗的资源。")

func _extInit():
	._extInit()
	chaName = "熔炼武器工程师"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2_2)