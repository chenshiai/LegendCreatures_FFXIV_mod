extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "多米尼克领主的致意"
	att.atk = 50
	att.pen = 20
	att.penL = 0.35
	info = TEXT.format("{c_base}普通攻击附带{c_phy}固定物穿值{/c}的真实伤害{/c}")

func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.pen, REAL, EFF)


