extends "../cNoveaScientist/cNoveaScientist.gd"

var SkillText_1 = "{c_skill}[武器研究]{/c}：解锁武器研究路线。"

func _extInit():
	._extInit()
	chaName = "武器研究学家"
	lv = 2
	attCoe.atk += 2
	attCoe.mgiAtk += 2
	evos = ["cNoveaScientist_1_1", "cNoveaScientist_1_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1))
