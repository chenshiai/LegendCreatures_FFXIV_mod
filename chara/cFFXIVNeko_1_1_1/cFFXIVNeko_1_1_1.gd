extends "../cFFXIVNeko_1_1/cFFXIVNeko_1_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4.3
	attCoe.atk = 3
	attCoe.mgiAtk = 5
	attCoe.def = 4.2
	attCoe.mgiDef = 4.5
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))


func _onBattleStart():
	._onBattleStart()
	shield_pw = 2.25