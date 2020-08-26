extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMbszx"
	RepeatId = id
	name = "冰霜之心"
	att.def = 110
	att.maxHp = 200
	att.cd = 0.2
	info = TEXT.format("{c_base}{c_skill}唯一光环：{/c}降低2格范围内敌人25%的攻速{/c}")


func _upS():
	for cha in masCha.getCellChas(masCha.cell, 2, 1):
		cha.addBuff(w_bingxin.new())


class w_bingxin extends Buff:
	func _init(lv = 1):
		attInit()
		life = lv
		id = "w_kuangbao"
		att.spd = -0.25