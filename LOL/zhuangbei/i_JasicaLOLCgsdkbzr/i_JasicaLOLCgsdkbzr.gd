extends "../LOLItemBase/LOLItemBase.gd"


func _init():
	id = "i_JasicaLOLCgsdkbzr"
	RepeatId = id
	name = "鬼索的狂暴之刃"
	att.atk = 35
	att.mgiAtk = 35
	att.spd = 0.25
	att.pen = 15
	att.mgiPen = 15
	info = TEXT.format("""{c_base}{c_skill}唯一被动——狂暴：{/c}普通攻击提供8%攻速，持续5秒(最多6层)。满层时触发{c_skill}鬼索之怒{/c}
{c_skill}鬼索之怒：{/c}每三次普通攻击造成50点真实伤害{/c}""")



func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL and !Repeat:
		STATUS.b_kuangbao.new({"cha": masCha, "dur": 5})


