extends "../cFFXIVAolong_3/cFFXIVAolong_3.gd"

#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "化身为影"
	lv = 3
	evos = []
	addCdSkill("skill_Assassinate", 20)
	addSkillTxt("[生杀予夺]：被动，提高自身伤害20%，第一次使用[忍术]后，之后[忍术]的冷却时间减少5s")

func _connect():
	._connect() #保留继承的处理

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != Chara.AtkType.EFF:
		atkInfo.atkVal *= 1.20

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Ninjutsu":
		var sk = getSkill("skill_Ninjutsu")
		sk.nowTime += 5