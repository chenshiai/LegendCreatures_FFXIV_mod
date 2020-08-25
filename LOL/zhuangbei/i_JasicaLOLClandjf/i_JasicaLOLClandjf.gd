extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "卢安娜的飓风"
	att.spd = 0.60
	att.cri = 0.25
	att.atkRan = 2
	info = TEXT.format("{c_base}每次普通攻击会发射两支弩箭向附近两个目标造成{c_phy}40%物理攻击{/c}的物理伤害{/c}")


func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		var n = 0
		var chas = masCha.getCellChas(masCha.cell, masCha.att.atkRan, 1)
		for cha in chas:
			if cha != atkInfo.hitCha:
				n += 1
				if n < 3 :
					var d:Eff = masCha.newEff(masCha.atkEff, masCha.sprcPos)
					d._initFlyCha(cha)
					masCha.hurtChara(cha, masCha.att.atk * 0.40, PHY, EFF)
