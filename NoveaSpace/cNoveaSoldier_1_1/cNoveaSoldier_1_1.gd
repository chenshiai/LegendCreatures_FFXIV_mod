extends "../cNoveaSoldier_1/cNoveaSoldier_1.gd"

var SkillText_1_1 = "{c_skill}[前线支援]{/c}：经过训练，该士兵拥有支援作战的能力。（暂未完成）"

func _extInit():
	._extInit()
	chaName = "星际支援兵"
	lv = 3
	attCoe.maxHp -= 2
	attCoe.atk -= 2
	attCoe.mgiAtk += 2
	evos = []
	addSkillTxt(TEXT.format(SkillText_1_1))
