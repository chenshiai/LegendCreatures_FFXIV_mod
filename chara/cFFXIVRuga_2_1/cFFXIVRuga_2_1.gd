extends "../cFFXIVRuga_2/cFFXIVRuga_2.gd"
const SIXSIDEDSTAR_PW = 4 # 六合星导腿威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_SixSidedStar", 12)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.90


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_SixSidedStar":
		sixSidedStar()


func sixSidedStar():
	var js = hasBuff("b_jiSu")
	var count = 0
	if js != null:
		count = js.life
	FFHurtChara(aiCha, att.atk * (FIGHTGAS_PW + (SIXSIDEDSTAR_PW + count * 0.05)), PHY, SKILL)