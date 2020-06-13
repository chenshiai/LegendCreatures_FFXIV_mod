extends "../cFFXIVSpirit_3_1/cFFXIVSpirit_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "埃斯蒂尼安-传奇"
	attCoe.maxHp = 5
	attCoe.atk = 5
	attCoe.def = 4.6
	attCoe.mgiDef = 3.9
	attAdd.suck += 0.10
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[舍弃苍天的龙骑士]：{TPassive}，获得10%的物理吸血"))

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()