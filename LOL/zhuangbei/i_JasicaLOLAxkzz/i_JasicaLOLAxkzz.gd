extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "虚空之杖"
	att.mgiAtk = 80
	att.mgiPen = 15
	att.mgiPenL = 0.3
	info = TEXT.format("{c_base}技能攻击附带{c_mgi}固定法穿值两倍{/c}的真实伤害{/c}")


func _onAtkChara(atkInfo):
	if atkInfo.atkType == SKILL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.mgiPen * 2, REAL, EFF )