extends "../cFFXIVAolong_3/cFFXIVAolong_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "化身为影"
	lv = 3
	evos = []
	addCdSkill("skill_Assassinate", 20)
	addSkillTxt("[生杀予夺]：被动，提高自身伤害20%，第一次使用[忍术]后，之后[忍术]的冷却时间减少5s")

var ninjutsu = false # 是否已经降低忍术的cd？

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	ninjutsu = false

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	atkInfo.hurtVal *= 1.20

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Ninjutsu" && !ninjutsu:
		ninjutsu = true
		var sk = getSkill("skill_Ninjutsu")
		sk.cd = 6