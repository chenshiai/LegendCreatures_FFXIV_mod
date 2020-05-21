extends "../cFFXIVLarafel_1/cFFXIVLarafel_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "角尊之白"
	lv = 3
	evos = []
	addCdSkill("skill_Benediction", 20)
	addSkillTxt("[天赐祝福]：冷却时间20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却时间延长至60s")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	var sk = getSkill("skill_Benediction")
	sk.cd = 20
	skillStrs[2] = "[天赐祝福]：冷却时间20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却时间延长至60s"

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Benediction": benediction()

func benediction():
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m :
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null:
		cha.plusHp(cha.att.maxHp)
	
	var sk = getSkill("skill_Benediction")
	sk.cd = 60
	skillStrs[2] = "[天赐祝福]：冷却时间60s，为生命最低的友方单位恢复至满血（已经使用过一次）"