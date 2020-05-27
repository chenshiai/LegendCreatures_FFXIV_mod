extends "../cFFXIVSpirit_1_1/cFFXIVSpirit_1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "蕾薇瓦-传奇"
	attCoe.maxHp = 4
	attCoe.mgiAtk = 5
	attCoe.def = 3.5
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []
	addSkillTxt("[天星交错]：被动，阳星相位现在会附加[黑夜领域]的效果")

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()