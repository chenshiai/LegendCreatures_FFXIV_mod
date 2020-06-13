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
	addSkillTxt(TEXT.format("[天星交错]：{TPassive}，阳星相位现在会附加[持续恢复]的效果"))

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()