extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAnszy"
	RepeatId = id
	name = "纳什之牙"
	att.spd = 0.5
	att.mgiAtk = 80
	info = TEXT.format("""{c_base}{c_skill}唯一被动：{/c}+20%冷却缩减
{c_skill}唯一被动：{/c}普通攻击会造成{c_mgi}25(+15% x 法强){/c}的额外魔法伤害{/c}""")
	
func _connect():
	._connect()
	if Repeat:
		att.cd = 0
	else:
		att.cd = 0.2


func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL and !Repeat:
		masCha.hurtChara(atkInfo.hitCha, 25 + masCha.att.mgiAtk * 0.15, MGI, EFF)