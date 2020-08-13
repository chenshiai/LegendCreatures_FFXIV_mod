extends "../cFFXIVSpirit_3_1/cFFXIVSpirit_3_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 5
	attCoe.atk = 5
	attCoe.def = 4.6
	attCoe.mgiDef = 3.9
	attAdd.suck += 0.10
	attAdd.penL += 0.10
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))