extends "../cFFXIVLarafel_2_1/cFFXIVLarafel_2_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4
	attCoe.atk = 3
	attCoe.mgiAtk = 6
	attCoe.def = 3.5
	attCoe.mgiDef = 4.3
	attAdd.mgiAtkL += 0.3
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))
