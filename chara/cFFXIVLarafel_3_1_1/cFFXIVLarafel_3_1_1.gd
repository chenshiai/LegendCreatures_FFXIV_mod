extends "../cFFXIVLarafel_3_1/cFFXIVLarafel_3_1.gd"
const MORGEN_UP = 10

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4
	attCoe.atk = 4
	attCoe.mgiAtk = 5.5
	attCoe.def = 4
	attCoe.mgiDef = 4.3
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder":
		if blackMorgen - whiteMorgan >= 30:
			whiteMorgan += MORGEN_UP
		elif whiteMorgan - blackMorgen >= 30:
			blackMorgen += MORGEN_UP