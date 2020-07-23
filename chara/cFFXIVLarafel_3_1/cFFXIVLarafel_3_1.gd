extends "../cFFXIVLarafel_3/cFFXIVLarafel_3.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Manafication", 20)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Manafication":
		manafication()


func manafication():
	Utils.draw_efftext("倍增！", position)
	blackMorgen *= 2
	whiteMorgan *= 2
	morgenLimit()
	BUFF_LIST.b_Manafication.new({"cha": self, "dur": 10})