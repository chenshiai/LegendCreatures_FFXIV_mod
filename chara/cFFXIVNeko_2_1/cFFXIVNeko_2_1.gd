extends "../cFFXIVNeko_2/cFFXIVNeko_2.gd"
const ENKINDLEBAHAMUT_PW = 7 # 龙神迸发威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Dreadwyrm", 24)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Dreadwyrm":
		dreadwyrm()
		enkindleBahamut(self.lv)
		SummonChara.skill_lv3()


func dreadwyrm():
	BUFF_LIST.b_Dreadwyrm.new({"cha": self, "dur": 8})


func enkindleBahamut(lv):
	var cell = aiCha.cell
	var chas = getCellChas(cell, 2)
	if lv == 4:
		Utils.draw_effect("phoenix", position, Vector2(40, -40), 15, 2)
	Utils.draw_effect("nuclearExplosion", aiCha.position, Vector2(0, -30), 8, 2)
	yield(reTimer(0.5), "timeout")
	
	for i in chas:
		if i != null:
			if lv == 4:
				FFHurtChara(i, att.mgiAtk * (ENKINDLEBAHAMUT_PW + 0.60), MGI, SKILL)
				i.addBuff(b_shaoZhuo.new(20))
			else:
				FFHurtChara(i, att.mgiAtk * ENKINDLEBAHAMUT_PW, MGI, SKILL)

