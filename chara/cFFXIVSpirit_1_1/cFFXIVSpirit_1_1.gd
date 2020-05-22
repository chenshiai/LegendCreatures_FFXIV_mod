extends "../cFFXIVSpirit_1/cFFXIVSpirit_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "东天之星-昼"
	lv = 3
	attAdd.mgiAtkL += 0.20
	evos = []
	addCdSkill("skill_Horoscope", 25)
	addSkillTxt("[袖内抽卡]：冷却时间25s，连续使用三次[抽卡]")
	addSkillTxt("[星位合图]：被动，提高20%的法强")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Horoscope":
		var eff = newEff("numHit", Vector2(30, -60))
		eff.setText("袖内抽卡！")
		for i in range(3):
			drawCard()
			yield(reTimer(0.5), "timeout")