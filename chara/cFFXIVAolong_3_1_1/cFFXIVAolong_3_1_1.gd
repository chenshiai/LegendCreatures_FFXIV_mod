extends "../cFFXIVAolong_3_1/cFFXIVAolong_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "夕雾-传奇"
	attCoe.atkRan = 2
	attCoe.maxHp = 4.1
	attCoe.atk = 5.2
	attCoe.def = 4
	attCoe.mgiDef = 3.7
	lv = 4
	evos = []
	addCdSkill("skill_ArmorCrush", 16)
	addSkillTxt("[强甲破点突]：冷却16s，削弱目标的15%的双抗，若目标的仇恨不是自己，则数值提高为30%。持续7s")



func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_ArmorCrush":
		if aiCha.aiCha != self:
			aiCha.addBuff(BUFF_LIST.b_ArmorCrush.new(7, 0.3))
		else:
			aiCha.addBuff(BUFF_LIST.b_ArmorCrush.new(7, 0.15))