extends "../cFFXIVLarafel_1_1/cFFXIVLarafel_1_1.gd"

const ASSIZE_PW = 2.70 # 法令伤害威力
const ASSIZE_HEAL_PW = 0.90 # 法令治疗威力

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.maxHp = 4
	attCoe.mgiAtk = 5
	attCoe.def = 3.5
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []
	addCdSkill("skill_Assize", 19)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_2))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Assize":
		assize()


func assize():
	var allys = getCellChas(self.cell, 3, 2)
	for cha in allys:
		if cha != null:
			cha.plusHp(att.mgiAtk * CUREIII_PW)

	var enmy = getCellChas(self.cell, 3, 1)
	for cha in enmy:
		FFHurtChara(cha, att.mgiAtk * STORNIII_PW, MGI, SKILL)