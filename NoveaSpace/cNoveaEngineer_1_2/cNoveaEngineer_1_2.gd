extends "../cNoveaEngineer_1/cNoveaEngineer_1.gd"

var SkillText_1_2 = TEXT.format("{c_skill}[航空建设专精]{/c}：解锁更高级的航空建设图纸，略微降低建设所消耗的资源。")

func _extInit():
	._extInit()
	chaName = "航空建设工程师"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1_2)

