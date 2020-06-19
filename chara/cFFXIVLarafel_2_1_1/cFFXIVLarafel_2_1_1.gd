extends "../cFFXIVLarafel_2_1/cFFXIVLarafel_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "帕帕力莫-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 3
	attCoe.mgiAtk = 6
	attCoe.def = 3.5
	attCoe.mgiDef = 4.3
	attAdd.mgiAtkL += 0.3
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[最好的学生]：『{TPassive}』提高30%的法强"))

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()