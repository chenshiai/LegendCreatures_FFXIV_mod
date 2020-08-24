extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "纳什之牙"
	att.spd = 0.5
	att.mgiAtk = 80
	att.cd = 0.2
	info = TEXT.format("{c_base}普通攻击会造成{c_mgi}25(+15% x 法强){/c}的额外魔法伤害{/c}")
	
func _connect():
	._connect()
	info = TEXT.format("{c_base}普通攻击会造成{c_mgi}25(+{1}){/c}}的额外魔法伤害{/c}", {
		1: masCha.att.mgiAtk * 0.15 / 1
	})


func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL:
		masCha.hurtChara(atkInfo.hitCha, 25 + masCha.att.mgiAtk * 0.15, MGI, EFF)