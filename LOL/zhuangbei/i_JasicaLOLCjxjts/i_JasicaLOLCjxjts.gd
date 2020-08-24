extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "巨型九头蛇"
	att.maxHp = 450
	att.atk = 40
	att.reHp = 0.1
	info = TEXT.format("""{c_base}每次攻击对敌人造成{c_phy}20(+1.5%你最大生命值){/c}的物理伤害
并且对敌人周围一格周围敌人造成{c_phy}50(+3%你最大生命值){/c}的物理伤害
穿戴单位变为近战""")
	

func _connect():
	._connect()
	att.atkRan = 1 - masCha.att.atkRan

func _upS():
	if masCha.att.atkRan > 1:
		att.atkRan = 1 - masCha.att.atkRan


func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.maxHp * 0.015 + 20, PHY, EFF)
		for cha in masCha.getCellChas(atkInfo.hitCha.cell, 1, 1):
			if cha != atkInfo.hitCha:
				masCha.hurtChara(cha, masCha.att.maxHp * 0.03 + 50, PHY, EFF)

	