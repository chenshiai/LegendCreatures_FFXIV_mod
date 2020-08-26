extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMrydp"
	RepeatId = id
	name = "日炎斗篷"
	att.maxHp = 500
	att.def = 60
	info = TEXT.format("{c_base}{c_skill}唯一被动——献祭：{/c}每秒对周围2格敌对单位造成{c_mgi}[25/40/55/70]{/c}点魔法伤害（伤害根据携带者等级变化）。{/c}")
	
func _upS():
	if Repeat:
		return
	var chas = masCha.getCellChas(masCha.cell, 2, 1)
	for cha in chas:
		masCha.hurtChara(cha, masCha.lv * 15 + 10, MGI, EFF)