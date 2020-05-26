extends "../cFFXIVHumen_2/cFFXIVHumen_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "守约之刃"
	lv = 3
	attAdd.spd += 0.2
	evos = []
	addSkillTxt("""[续剑]：被动，攻击速度提高20%
[血壤]：被动，普通攻击会附加50%攻击力的魔法伤害""")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		if atkInfo.hitCha != null:
			hurtChara(atkInfo.hitCha, att.atk * 0.5, Chara.HurtType.MGI, Chara.AtkType.EFF)