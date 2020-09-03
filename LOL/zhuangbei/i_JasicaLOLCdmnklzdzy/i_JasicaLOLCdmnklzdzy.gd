extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLCdmnklzdzy"
	RepeatId = id
	name = "多米尼克领主的致意"
	att.atk = 50
	att.pen = 20
	info = TEXT.format("""{c_base}{c_skill}唯一被动——最后的轻语：{/c}+35%护甲穿透
普通攻击附带{c_phy}固定物穿值{/c}的真实伤害{/c}""")

func _updataAttInfo():
	if Repeat:
		att.penL = 0
	else:
		att.penL = 0.35

func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.pen, REAL, EFF)


