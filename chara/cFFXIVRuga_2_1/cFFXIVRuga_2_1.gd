extends "../cFFXIVRuga_2/cFFXIVRuga_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "复教之拳"
	lv = 3
	evos = []
	addSkillTxt(TEXT.format("[金刚决意]：{TPassive}受到的伤害减少10%"))
	addCdSkill("skill_SixSidedStar", 12)
	addSkillTxt(TEXT.format("[六合星导腿]：冷却12s，对目标造成[400%]的{TPhyHurt}，自身每层[急速]可以提高[5%]的伤害"))

const SIXSIDEDSTAR_PW = 4 # 六合星导腿威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

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