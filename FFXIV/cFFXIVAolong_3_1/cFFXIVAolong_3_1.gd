extends "../cFFXIVAolong_3/cFFXIVAolong_3.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Assassinate", 26)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	atkInfo.hurtVal *= 1.30


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Assassinate":
		Assassinate = true
		Utils.draw_efftext("活殺自在", position, "#ff99bb")
