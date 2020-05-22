extends "../cFFXIVHumen_3/cFFXIVHumen_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "心动之舞"
	lv = 3
	evos = []
	addCdSkill("skill_SaberDance", 13)
	addSkillTxt("[剑舞]：冷却时间13s，对目标及周围2格敌人造成[300%]的物理伤害")

const SABERDANCE_PW = 3 # 剑舞威力

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_SaberDance" && aiCha != null: saberDance()

func saberDance():
	var eff = newEff("numHit", Vector2(30, -60))
	eff.setText("剑舞！")
	var chas = getCellChas(aiCha.cell, 2, 1)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atk * SABERDANCE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)