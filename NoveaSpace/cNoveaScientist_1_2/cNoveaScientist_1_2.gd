extends "../cNoveaScientist/cNoveaScientist.gd"

var SkillText_1_2 = "{c_skill}[重火力研究]{/c}：解锁重火力武器研究路线。"

func _extInit():
	._extInit()
	chaName = "重火力研究学家"
	lv = 3
	attCoe.atk += 2
	attCoe.mgiAtk += 2
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText_1_2))
