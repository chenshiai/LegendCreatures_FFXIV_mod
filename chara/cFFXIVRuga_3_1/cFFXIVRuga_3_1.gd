extends "../cFFXIVRuga_3/cFFXIVRuga_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "咆哮之火"
	lv = 3
	attAdd.atkL += 0.15
	evos = []
	addCdSkill("skill_Drill", 12)
	addSkillTxt("[钻头]：冷却12s，对目标造成[400%]的物理伤害")
	addSkillTxt("[枪管加热]：被动，自身攻击力提高15%")

const DRILL_PW = 4 # 钻头威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Drill":
		drill()

func drill():
	if aiCha != null:
		hurtChara(aiCha, att.atk * DRILL_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)