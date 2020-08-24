extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "兰德里的折磨"	
	att.mgiAtk = 80
	att.maxHp = 300
	att.cd = 0.1
	info = TEXT.format("""{c_base}技能与普攻叠加2层{c_skill}[冰霜]{/c}
攻击带有15层冰霜的单位时清除15层冰霜并造成对方{c_real}[最大生命2%]{/c}的真实伤害
{c_skill}[冰霜]{/c}：减少目标10%物理防御、魔法防御、攻速，每层多减少1%攻速{/c}""")


func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL or atkInfo.atkType == SKILL:
		STATUS.b_bingshuang.new({
			"cha": atkInfo.hitCha,
			"dur": 2,
		})
		var bf = atkInfo.hitCha.hasBuff("b_bingshuang")
		if bf != null && bf.life >= 15 :
			bf.isDel = true
			masCha.hurtChara(atkInfo.hitCha, atkInfo.hitCha.att.maxHp * 0.02, REAL, EFF)

	
