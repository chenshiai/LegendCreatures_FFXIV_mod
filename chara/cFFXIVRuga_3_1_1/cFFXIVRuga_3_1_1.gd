extends "../cFFXIVRuga_3_1/cFFXIVRuga_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "希尔达-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.mgiAtk = 3
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()