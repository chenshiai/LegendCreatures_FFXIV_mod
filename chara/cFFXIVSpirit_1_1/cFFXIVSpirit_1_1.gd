extends "../cFFXIVSpirit_1/cFFXIVSpirit_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	attAdd.mgiAtkL += 0.10
	evos = []
	addCdSkill("skill_Horoscope", 25)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Horoscope":
		Utils.draw_efftext("袖内抽卡！", position, "#ffffff")
		for i in range(3):
			drawCard()
			yield(reTimer(0.5), "timeout")