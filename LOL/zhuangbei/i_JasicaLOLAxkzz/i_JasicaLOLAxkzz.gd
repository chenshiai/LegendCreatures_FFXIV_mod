extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAxkzz"
	RepeatId = id
	name = "虚空之杖"
	att.mgiAtk = 80
	att.mgiPen = 15
	info = TEXT.format("""{c_base}{c_skill}唯一被动——溶解：{/c}+40%法术穿透
技能攻击附带{c_mgi}固定法穿值两倍{/c}的真实伤害{/c}""")

func _updataAttInfo():
	if Repeat:
		att.mgiPenL = 0
	else:
		att.mgiPenL = 0.4

func _onAtkChara(atkInfo):
	if atkInfo.atkType == SKILL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.mgiPen * 2, REAL, EFF )