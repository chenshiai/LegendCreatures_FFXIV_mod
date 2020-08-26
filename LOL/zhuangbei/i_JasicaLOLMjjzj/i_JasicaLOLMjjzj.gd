extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMjjzj"
	RepeatId = id
	name = "荆棘之甲"
	att.def = 80
	att.maxHp = 350
	info = TEXT.format("""{c_base}{c_skill}唯一·荆棘：{/c}被普通攻击时，会回敬攻击者魔法伤害，数额为{c_mgi}35(+自身10%的护甲值){/c}，并施加重伤3秒(回复量减少40%)
{c_skill}唯一·寒铁：{/c}被普通攻击时，减少攻击者20%攻击速度，持续2秒{/c}""")


func _onHurt(atkInfo):
	if atkInfo.atkType == NORMAL and !Repeat:
		masCha.hurtChara(atkInfo.atkCha, masCha.att.def * 0.1 + 35, MGI, EFF)
		STATUS.b_zhongshang.new({
			"cha": atkInfo.atkCha,
			"dur": 3
		})
		STATUS.b_hantie.new({
			"cha": atkInfo.atkCha,
			"dur": 2,
		})
