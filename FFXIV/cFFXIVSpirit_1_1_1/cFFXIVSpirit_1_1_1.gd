extends "../cFFXIVSpirit_1_1/cFFXIVSpirit_1_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4
	attCoe.mgiAtk = 5
	attCoe.def = 3.5
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))
