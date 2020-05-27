extends "../cFFXIVRuga_1_1/cFFXIVRuga_1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "杰林斯-传奇"
	attCoe.maxHp = 6
	attCoe.atk = 4.8
	attCoe.def = 6
	attCoe.mgiDef = 4.9
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()