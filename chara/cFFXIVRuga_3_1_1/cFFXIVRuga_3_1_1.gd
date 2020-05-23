extends "../cFFXIVRuga_3_1/cFFXIVRuga_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "希尔达-传奇"
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()