extends "../cFFXIVHumen_3/cFFXIVHumen_3.gd"

func _extInit():
	._extInit()
	chaName = "心动之舞"
	lv = 3
	evos = []
	addCdSkill("skill_SaberDance", 13)
	addSkillTxt(TEXT.format("[剑舞]：冷却13s，对目标及周围2格敌人造成[100%]的{TPhyHurt}"))
	addSkillTxt(TEXT.format("""[防守之桑巴]：{TPassive}战斗开始时，为自身和所有队友附加[防守之桑巴]，受到的伤害减少10%
不可与吟游诗人的[行吟]、机工士的[策动]效果叠加"""))

const SABERDANCE_PW = 1 # 剑舞威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	troubadour()

func troubadour():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Troubadour.new({"cha": cha})

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_SaberDance":
		saberDance()

func saberDance():
	var chas = getCellChas(aiCha.cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * SABERDANCE_PW, PHY, SKILL)