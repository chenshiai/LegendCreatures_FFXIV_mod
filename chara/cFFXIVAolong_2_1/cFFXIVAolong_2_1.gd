extends "../cFFXIVAolong_2/cFFXIVAolong_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "无双之士"
	lv = 3
	evos = []
	addCdSkill("skill_Tsubame", 14)
	addSkillTxt("[燕回返]：冷却14s，发动上一次使用的居合术")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Tsubame":
		var eff = newEff("numHit", Vector2(-30, -72))
		eff.setText("燕回返！", "#ffffff")
		setsugekka(beforIaijutsu)

