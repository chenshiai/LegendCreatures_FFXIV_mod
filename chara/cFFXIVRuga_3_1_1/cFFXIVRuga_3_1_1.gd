extends "../cFFXIVRuga_3_1/cFFXIVRuga_3_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	attAdd.cri += 0.2
	lv = 4
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))

func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret":
		yield(reTimer(0.2), "timeout")
		autoturret(false)
		yield(reTimer(0.2), "timeout")
		autoturret(false)

func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == SKILL:
		atkInfo.canCri = true