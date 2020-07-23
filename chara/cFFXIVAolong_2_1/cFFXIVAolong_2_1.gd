extends "../cFFXIVAolong_2/cFFXIVAolong_2.gd"


func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Tsubame", 14)
	addSkillTxt(FFData.SKILL_TEXT_1)


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Tsubame":
		Utils.draw_efftext("燕回返！", position, "#ffffff")
		setsugekka(beforIaijutsu * 1.5)

