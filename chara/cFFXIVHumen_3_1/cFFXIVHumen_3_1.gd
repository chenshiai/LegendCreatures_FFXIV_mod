extends "../cFFXIVHumen_3/cFFXIVHumen_3.gd"

func _extInit():
	._extInit()
	chaName = "心动之舞"
	lv = 3
	evos = []
	addCdSkill("skill_SaberDance", 13)
	addSkillTxt(TEXT.format("[剑舞]：冷却13s，对目标及周围2格敌人造成[100%]的{TPhyHurt}"))

const SABERDANCE_PW = 1 # 剑舞威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_SaberDance":
		saberDance()

func saberDance():
	var chas = getCellChas(aiCha.cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * SABERDANCE_PW, PHY, SKILL)