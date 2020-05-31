extends "../cFFXIVHumen_3/cFFXIVHumen_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "心动之舞"
	lv = 3
	evos = []
	addCdSkill("skill_SaberDance", 13)
	addSkillTxt("[剑舞]：ÇÐ13s，对目标及周围2格敌人造成[100%]的物理伤害")

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
		if i != null: 
			hurtChara(i, att.atk * SABERDANCE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)