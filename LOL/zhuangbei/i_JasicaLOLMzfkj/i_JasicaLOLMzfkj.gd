extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMzfkj"
	Repeat = id
	name = "振奋铠甲"
	att.maxHp = 550
	att.mgiDef = 65
	att.cd = 0.1
	info = TEXT.format("""{c_base}{c_skill}唯一被动：{/c}受到技能攻击时回复最大生命的1%。
{c_skill}唯一被动：{/c}所受的全部治疗效果提高30%。{/c}""")
	
func _updataAttInfo():
	if Repeat:
		att.reHp = 0
	else:
		att.reHp = 0.30


func _onHurt(atkInfo):
	if atkInfo.atkType == SKILL:
		masCha.plusHp(masCha.att.maxHp * 0.01)

