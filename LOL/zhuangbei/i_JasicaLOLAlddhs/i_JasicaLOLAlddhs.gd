extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "卢登的回声"
	att.mgiAtk = 100
	att.cd = 0.1
	info = TEXT.format("""{c_base}充能时间8s，每次攻击或释放技能都会减少此装备5%的充能时间
充能完毕后，下一次攻击将对目标及周围1格内的敌人造成{c_mgi}100(+10% x 法强){/c}的魔法伤害{/c}""")


var t = 0
var bl = false
func _onAtkChara(atkInfo:AtkInfo):
	_onCastCdSkill()
	if bl:
		bl = false
		for cha in masCha.getCellChas(atkInfo.hitCha.cell, 1, 1):
			masCha.hurtChara(cha, masCha.att.mgiAtk * 0.10 + 100, MGI, EFF)

func _onCastCdSkill(id = ""):
	t += 0.04
	if t >= 8:
		bl = true
		t = 0

func _upS():
	t += 1 + masCha.att.cd
	if t >= 8:
		bl = true
		t = 0

func _onBattleEnd():
	t = 0