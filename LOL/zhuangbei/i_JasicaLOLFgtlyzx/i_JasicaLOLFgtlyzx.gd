extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLFgtlyzx"
	RepeatId = id
	name = "钢铁烈阳之匣"
	att.def = 30
	att.mgiDef = 60
	info = TEXT.format("{c_base}{c_skill}唯一被动：{/c}战斗开始时，为自身及相邻的队友提供一个护盾，最多可以吸收120(+25%自身最大生命值)的伤害，持续5秒{/c}")

func _onBattleStart():
	if Repeat:
		return
	var chas = masCha.getCellChas(masCha.cell, 1, 2)
	for cha in chas:
		STATUS.b_xuedun.new({
			"cha": cha,
			"dur": 5,
			"HD": (masCha.att.maxHp * 0.25 + 120)
		})

