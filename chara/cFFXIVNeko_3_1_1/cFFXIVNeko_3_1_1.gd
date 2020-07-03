extends "../cFFXIVNeko_3_1/cFFXIVNeko_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "让泰尔-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []
	addCdSkill("skill_ApexArrow", 12)
	addSkillTxt(TEXT.format("[绝峰箭]：冷却12s，射出穿透箭对直线上单位造成[400%]的{TPhyHurt}，并赋予5层[流血]"))

const APEXARROW_PW = 4 # 绝峰箭威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_ApexArrow":
		apexArrow()

func apexArrow():
	if aiCha != null:
		var eff:Eff = newEff("sk_chuanTouJian", sprcPos)
		eff._initFlyPos(position + (aiCha.position - position).normalized() * 1000, 800)
		eff.connect("onInCell", self, "effInCell")

func effInCell(cell):
	var cha = matCha(cell)
	if cha != null and cha.team != team:
		FFHurtChara(cha, att.atk * APEXARROW_PW, PHY, SKILL)
		cha.addBuff(b_liuXue.new(5))