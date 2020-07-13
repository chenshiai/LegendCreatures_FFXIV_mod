extends "../cFFXIVAolong_3_1/cFFXIVAolong_3_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_3
	attCoe.atkRan = 2
	attCoe.maxHp = 4.1
	attCoe.atk = 5.2
	attCoe.def = 4
	attCoe.mgiDef = 3.7
	lv = 4
	evos = []
	addCdSkill("skill_ArmorCrush", 16)
	addSkillTxt(FFData.SKILL_TEXT_2)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	yield(reTimer(0.5), "timeout")
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