extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "瑞莱的冰晶节杖"
	att.mgiAtk = 90
	att.maxHp = 300
	info = TEXT.format("""{c_base}每次攻击赋予目标5层[结霜]
技能命中对敌人造成{c_mgi}[结霜]层数 x 3%法强{/c}的魔法伤害{/c}""")


func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == SKILL or atkInfo.atkType == NORMAL:
		atkInfo.hitCha.addBuff(b_jieShuang.new(5))
	var bf = atkInfo.hitCha.hasBuff("b_jieShuang")
	if atkInfo.atkType == SKILL and bf != null:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.mgiAtk * 0.03 * bf.life, MGI,EFF )
