extends "../LOLItemBase/LOLItemBase.gd"


func _init():
	id = "i_JasicaLOLChsqgz"
	RepeatId = id
	name = "黑色切割者"
	att.maxHp = 400
	att.atk = 40
	att.cd = 0.20
	info = TEXT.format("{c_base}{c_skill}唯一·切割者：{/c}造成物理伤害时减少目标4%护甲，持续6秒(最多叠加6次，减少24%护甲){/c}")


func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL and !Repeat:
		STATUS.b_qiegezhe.new({
			"cha": atkInfo.hitCha,
			"dur": 6
		})