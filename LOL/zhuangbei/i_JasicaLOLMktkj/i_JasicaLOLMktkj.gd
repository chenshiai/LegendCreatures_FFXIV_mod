extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMktkj"
	RepeatId = id
	name = "狂徒铠甲"
	att.maxHp = 800
	att.reHp = 0.2
	att.cd = 0.1
	info = TEXT.format("""{c_base}{c_skill}唯一被动：{/c}+10%冷却缩减。
{c_skill}唯一被动：{/c}在自身拥有至少3000点最大生命值时，提供狂徒之心效果。

[狂徒之心]：每受到8次普攻或技能伤害，恢复最大生命的2%。{/c}""")

var open = false # 狂徒之心是否开启
var num = 0 # 受到攻击次数

func _connect():
	._connect()
	if Repeat:
		att.cd = 0

func _onHurt(atkInfo):
	if (atkInfo.atkType == NORMAL or atkInfo.atkType == SKILL) and !Repeat:
		if masCha.att.maxHp >= 3000:
			num += 1
			if num >= 8:
				masCha.plusHp(masCha.att.maxHp * 0.02)



	