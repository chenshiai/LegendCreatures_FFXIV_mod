extends "../cFFXIVNeko_1_1/cFFXIVNeko_1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "阿尔菲诺-传奇"
	attCoe.maxHp = 4.3
	attCoe.atk = 3
	attCoe.mgiAtk = 5
	attCoe.def = 4.2
	attCoe.mgiDef = 4.5
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[我的梦想，就是拯救世界！]：{TPassive}护盾生成量变为[治疗量的225%]"))



func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	shield_pw = 2.25