extends "../cFFXIVRuga_3/cFFXIVRuga_3.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Drill", 12)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))

const DRILL_PW = 4 # 钻头威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	troubadour()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Drill":
		drill()

func drill():
	FFHurtChara(aiCha, att.atk * DRILL_PW, PHY, SKILL)

func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})