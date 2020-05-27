extends "../cFFXIVSpirit_2_1/cFFXIVSpirit_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "于里昂热-传说"
	attCoe.maxHp = 4
	attCoe.mgiAtk = 5
	attCoe.def = 3.5
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()