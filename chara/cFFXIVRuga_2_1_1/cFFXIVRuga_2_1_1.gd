extends "../cFFXIVRuga_2_1/cFFXIVRuga_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "莉瑟-传奇"
	attCoe.maxHp = 4.5
	attCoe.atk = 5
	attCoe.def = 4.5
	attCoe.mgiDef = 4
	attAdd.atkR += 0.25
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[红莲之狂潮]：{TPassive}，复国领袖，提升25%的攻击力"))

var baseId = ""
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
