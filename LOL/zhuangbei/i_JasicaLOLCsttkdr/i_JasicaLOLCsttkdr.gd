extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "斯塔缇克电刃"
	att.spd = 0.6
	att.cri = 0.25
	att.atkRan = 2
	info = TEXT.format("""{c_base}每8次普通攻击或释放技能后充能完毕
消耗所有充能，下一次攻击会造成{c_mgi}120{/c}的额外魔法伤害，并将该伤害弹射给其他5个目标{/c}""")


func _onBattleStart():
	c = 0
	n = 0

var c = 0 #弹射次数
var n = 0 #攻击次数
func _onCastCdSkill(id):
	n += 1

func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		n += 1

	if n >= 8:
		n = 0
		c = 0
		var demage = 120
		if sys.rndPer(masCha.att.cri * 100):
			demage *= 2 + masCha.att.criR
		for cha in masCha.getCellChas(atkInfo.hitCha.cell, 5, 1):
			if c < 5:
				masCha.hurtChara(cha, demage, MGI, EFF)
			c += 1
