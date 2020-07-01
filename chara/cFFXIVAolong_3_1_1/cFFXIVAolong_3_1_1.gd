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
	addSkillTxt("[强甲破点突]：冷却16s，开局释放一次，削弱目标的15%的双抗，若目标的仇恨不是自己，则数值提高为30%。持续7s")



func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	yield(reTimer(1), "timeout")
	call_deferred("armorCrush")

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_ArmorCrush":
		armorCrush()

func armorCrush():
	if aiCha.aiCha != self:
		BUFF_LIST.b_ArmorCrush.new({"cha": aiCha, "PW": 0.3, "dur": 7})
	else:
		BUFF_LIST.b_ArmorCrush.new({"cha": aiCha, "PW": 0.15, "dur": 7})