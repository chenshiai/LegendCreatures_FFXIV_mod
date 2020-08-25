extends "../BaseFlower/BaseFlower.gd"


# 初始化时会自动执行一次父类的 _init，所以不用 ._init
func _init():
	name = "哀嚎耳环"
	att.atk = 40
	att.mgiAtk = 65
	att.spd = 0.2
	EquipmentInfo = "[逆]金盏花-花语：悲叹\n普通攻击为目标附加2层|哀嚎|"
	info = TEXT.format(EquipmentInfo)
	_set_equip_channel({
		"Agony": "普通攻击额外附加1层|哀嚎|",
		"Heartbroke": "技能额外为目标附加1层|哀嚎|",
		"Rebirth": "技能驱散自己所有|哀嚎|",
		"Pure": "技能为自己回复1%最大生命值",
		"Greed": "普通攻击额外造成攻速越接近0越高的伤害",
		"Stink": "释放技能时获得1层|隐蔽|",
		"Fade": "普通攻击额外附加1层|寄生|",
		"Gental": "温柔：攻击额外附加1层|虚弱|",
		"Beauty": "普攻造成10%魔攻的额外魔法伤害",
		"Heritage": "一定次数攻击后增加1点双攻，次数会随着装备成长增加",
	})


var counter0 = 0
var stacked = 1
func _onAtkChara(atkInfo:AtkInfo):
	if atkInfo.atkType == NORMAL:
		atkInfo.hitCha.addBuff(ABuff.agony.new(2))
		for channel in EquipChannel:
			match channel:
				"Agony":
					atkInfo.hitCha.addBuff(ABuff.agony.new(1))
				"Greed":
					masCha.hurtChara(masCha.aiCha, 100 / (masCha.att.spd * 0.01), PHY, EFF)
				"Fade":
					atkInfo.hitCha.addBuff(ABuff.parasite.new(1))
				"Gental":
					atkInfo.hitCha.addBuff(ABuff.exhausted.new(1))
				"Beauty":
					masCha.hurtChara(masCha.aiCha, masCha.att.mgiAtk * 0.1, MGI, EFF)
				"Heritage":
					if counter0 >= (stacked / 0.5 + 1):
						att.atk += 1
						att.mgiAtk += 1
						stacked += 1
						counter0 = 0
					else:
						counter0 += 1

	if atkInfo.atkType == SKILL:
		for channel in EquipChannel:
			match channel:
				"Heartbroke":
					atkInfo.hitCha.addBuff(ABuff.agony.new(1))
				"Rebirth":
					var bf:Buff = masCha.hasBuff(ABuff.agony)
					if bf != null:
						bf.isDel = true
				"Pure":
					masCha.plusHp(masCha.att.maxHp * 0.01)
				"Stink":
					masCha.addBuff(ABuff.shrouded.new(1))

