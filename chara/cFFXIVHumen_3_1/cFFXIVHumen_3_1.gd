extends "../cFFXIVHumen_3/cFFXIVHumen_3.gd"
const SABERDANCE_PW = 1 # 剑舞威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_SaberDance", 13)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onBattleStart():
	._onBattleStart()
	troubadour()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_SaberDance":
		saberDance()


func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})


func saberDance():
	var chas = getCellChas(aiCha.cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * SABERDANCE_PW, PHY, SKILL)