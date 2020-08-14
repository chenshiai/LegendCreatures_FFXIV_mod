extends "../cNoveaEngineer_1/cNoveaEngineer_1.gd"

var SkillText_1_1 = TEXT.format("{c_skill}[高级基建专精]{/c}：解锁高级基建建设的图纸，略微降低建设所消耗的资源。")

func _extInit():
	._extInit()
	chaName = "高级基建工程师"
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_1_1)
