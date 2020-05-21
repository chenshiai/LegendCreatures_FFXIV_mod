extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述

func _extInit():
	._extInit()#保留继承的处理
	chaName = "冠军之剑"
	lv = 3
	evos = []
	addCdSkill("skill_Requiescat", 27)
	addSkillTxt("[安魂祈祷]：冷却时间27s，自身魔法强度提高50点，持续15s")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Requiescat": requiescat()

func requiescat():
	addBuff(b_requiescat.new(15))

class b_requiescat:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_requiescat"
		life = dur
		isNegetive = false
		att.mgiAtk = 50

	func _upS():
		life = clamp(life, 0, 15)
		if life <= 1: life = 0