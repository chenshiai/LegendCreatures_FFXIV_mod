extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "莫雷洛秘典"
	att.mgiAtk = 80
	att.maxHp = 300
	att.mgiPen = 30
	info = TEXT.format("{c_base}对目标造成魔法伤害时，会为该目标施加持续3秒的{c_skill}[重伤]{/c}效果(受到的治疗量减少40%){/c}")


func _onAtkChara(atkInfo):
	if atkInfo.hurtType == MGI:
		STATUS.b_zhongshang.new({
			"cha": atkInfo.hitCha,
			"dur": 3,
		})

	