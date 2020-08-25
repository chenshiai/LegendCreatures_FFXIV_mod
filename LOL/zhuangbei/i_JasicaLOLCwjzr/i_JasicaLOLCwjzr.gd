extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "无尽之刃"
	att.atk = 80
	att.cri = 0.25
	att.criR = 0.25
	info = "{c_base}每次暴击附加{c_phy}物理攻击25%{/c}的伤害{/c}"

func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.isCri:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.atk * 0.25, PHY, EFF)
