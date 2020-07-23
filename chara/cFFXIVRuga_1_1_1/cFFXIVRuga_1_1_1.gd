extends "../cFFXIVRuga_1_1/cFFXIVRuga_1_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 6
	attCoe.atk = 4.8
	attCoe.def = 6
	attCoe.mgiDef = 4.9
	attAdd.defL += 0.20
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))
	addCdSkill("skill_Superbolide", 70)


func _onBattleStart():
	._onBattleStart()
	BUFF_LIST.b_Superbolide.new({"cha": self, "dur": 10})


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Superbolide":
		BUFF_LIST.b_Superbolide.new({"cha": self, "dur": 10})
