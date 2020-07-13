extends "../cFFXIVAolong_1_1/cFFXIVAolong_1_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 9
	attCoe.atk = 4.6
	attCoe.def = 5.9
	attCoe.mgiDef = 6.5
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))


func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != EFF:
		atkInfo.hurtVal *= 1.30