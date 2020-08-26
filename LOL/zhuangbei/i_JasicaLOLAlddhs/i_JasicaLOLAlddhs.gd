extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAlddhs"
	RepeatId = id
	name = "卢登的回声"
	att.mgiAtk = 100
	att.cd = 0.2
	info = TEXT.format("""{c_base}{c_skill}唯一被动——極速：{/c}这个装备提供额外的10%冷却缩减。
{c_skill}唯一被动——回声：{/c}充能时间10s(不受冷却缩减影响)，每次普攻减少5%的充能时间，每次释放技能减少15%的充能时间。
充能完毕后，下一次攻击将对目标及周围1格内的敌人造成{c_mgi}100(+10% x 法强){/c}的魔法伤害{/c}""")



var nowTime = 0
var bl = false

func _connect():
	._connect()
	if Repeat:
		att.cd = 0.1

func _onAtkChara(atkInfo:AtkInfo):
	if Repeat:
		return

	if atkInfo.atkType == NORMAL:
		nowTime += 0.05

	if bl:
		bl = false
		for cha in masCha.getCellChas(atkInfo.hitCha.cell, 1, 1):
			masCha.hurtChara(cha, masCha.att.mgiAtk * 0.10 + 100, MGI, EFF)

func _onCastCdSkill(cd):
	nowTime += 0.15
	if nowTime >= 10:
		bl = true
		nowTime = 0

func _upS():
	nowTime += 1
	if nowTime >= 10:
		bl = true
		nowTime = 0

func _onBattleEnd():
	nowTime = 0