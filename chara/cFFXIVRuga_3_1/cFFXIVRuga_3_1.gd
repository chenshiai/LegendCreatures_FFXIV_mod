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
	addSkillTxt(TEXT.format("""[枪管加热]：{TPassive}自身攻击力提高15%
[钻头]：冷却12s，对目标造成[400%]的{TPhyHurt}
[策动]：{TPassive}战斗开始时，为自身和所有队友附加[策动]，受到的伤害减少10%
不可与吟游诗人的[行吟]、舞者的[防守之桑巴]效果叠加"""))

const DRILL_PW = 4 # 钻头威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	troubadour()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Drill":
		drill()

func drill():
	FFHurtChara(aiCha, att.atk * DRILL_PW, PHY, SKILL)

func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})