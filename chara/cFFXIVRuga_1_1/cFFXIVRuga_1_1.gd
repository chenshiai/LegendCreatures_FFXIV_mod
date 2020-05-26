extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冠军之剑"
	lv = 3
	evos = []
	addCdSkill("skill_Requiescat", 27)
	addSkillTxt("[安魂祈祷]：冷却时间27s，自身魔法强度提高50点，持续15s")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Requiescat":
		requiescat()

func requiescat():
	addBuff(BUFF_LIST.b_Requiescat.new(15))