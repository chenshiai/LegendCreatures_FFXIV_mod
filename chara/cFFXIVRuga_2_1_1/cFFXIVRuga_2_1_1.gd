extends "../cFFXIVRuga_2_1/cFFXIVRuga_2_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4.5
	attCoe.atk = 5
	attCoe.def = 4.5
	attCoe.mgiDef = 4
	attAdd.atkR += 0.25
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))

