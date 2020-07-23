extends "../cFFXIVNeko_3/cFFXIVNeko_3.gd"
const REFULGENT_PW = 3.30 # 辉煌箭威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onBattleStart():
	._onBattleStart()
	troubadour()


func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and sys.rndPer(20):
		refulgent()


func refulgent():
	Utils.draw_efftext("辉煌箭！", position, "#fff000")
	FFHurtChara(aiCha, att.atk * REFULGENT_PW, PHY, SKILL)
