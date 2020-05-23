extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "东方木人（测试专用）"
	attCoe.maxHp = 256
	lv = 4
	addSkillTxt("""产自多玛国的木人，坚硬耐磨，具有极优的抗打击能力。是广大光之战士的得力助手，利于磨练自身技艺
“我们多玛产的木人质量绝对保证！你就放心大胆的砍吧！” —— 飞燕""")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	aiOn = null
	aiCha = null

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	isDeath = false
	plusHp(att.maxHp * 1)
	