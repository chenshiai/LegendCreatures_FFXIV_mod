extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAmllmd"
	RepeatId = id
	name = "莫雷洛秘典"
	att.mgiAtk = 80
	att.maxHp = 300
	att.mgiPen = 30
	info = TEXT.format("""{c_base}{c_skill}死亡之触：{/c}+30法术穿透
{c_skill}唯一被动——诅咒打击：{/c}对目标造成魔法伤害时，会为该目标施加持续3秒的{c_skill}[重伤]{/c}效果(受到的治疗量减少40%){/c}""")


func _onAtkChara(atkInfo):
	if Repeat:
		return
	if atkInfo.hurtType == MGI:
		STATUS.b_zhongshang.new({
			"cha": atkInfo.hitCha,
			"dur": 3,
		})

	