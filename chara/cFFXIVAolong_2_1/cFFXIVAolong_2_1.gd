extends "../cFFXIVAolong_2/cFFXIVAolong_2.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "无双之士"
	lv = 3
	evos = []
	addCdSkill("skill_Tsubame", 14)
	addSkillTxt("[燕回返]：冷却时间14s，发动上一次使用的居合术")

func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Tsubame":
		var eff = newEff("numHit", Vector2(-30, -72))
		eff.setText("燕回返！")
		setsugekka(beforIaijutsu)

