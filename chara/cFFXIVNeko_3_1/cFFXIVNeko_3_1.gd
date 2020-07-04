extends "../cFFXIVNeko_3/cFFXIVNeko_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "红叶之诗"
	lv = 3
	evos = []
	addSkillTxt(TEXT.format("[辉煌箭]：{TPassive}普通攻击有20%的概率触发，对目标造成[330%]的{TPhyHurt}"))
	addSkillTxt(TEXT.format("""[行吟]：{TPassive}战斗开始时，为自身和所有队友附加[行吟]，受到的伤害减少10%
不可与舞者的[防守之桑巴]、机工士的[策动]效果叠加"""))

const REFULGENT_PW = 3.30 # 辉煌箭威力

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

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and sys.rndPer(20):
		refulgent()

func refulgent():
	Utils.draw_efftext("辉煌箭！", position, "#fff000")
	FFHurtChara(aiCha, att.atk * REFULGENT_PW, PHY, SKILL)
