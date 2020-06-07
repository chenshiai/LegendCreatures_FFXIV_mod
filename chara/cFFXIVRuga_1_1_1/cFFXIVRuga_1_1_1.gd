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
	attAdd.defL += 0.20
	lv = 4
	evos = []
	addSkillTxt("[神圣领域]：战斗开始时开启无敌，并免疫所有负面效果，持续10s")

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()