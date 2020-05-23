extends "../cFFXIVHumen_2_1/cFFXIVHumen_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "桑克瑞德-传奇"
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	superbolide = true