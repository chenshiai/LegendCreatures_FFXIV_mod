extends "../cFFXIVSpirit_3_1/cFFXIVSpirit_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "埃斯蒂尼安-传奇"
	attCoe.maxHp = 5
	attCoe.mgiAtk = 5
	attCoe.def = 4.6
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()