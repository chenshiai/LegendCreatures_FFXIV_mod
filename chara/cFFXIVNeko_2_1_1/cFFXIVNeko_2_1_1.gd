extends "../cFFXIVNeko_2_1/cFFXIVNeko_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "次优召唤师-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 3
	attCoe.mgiAtk = 6
	attCoe.def = 3.8
	attCoe.mgiDef = 4.3
	lv = 4
	evos = []
	addSkillTxt("[不死鸟附体]：被动，[龙神迸发]变为[不死鸟迸发]，造成伤害的同时会给目标附加20层[烧灼]")

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()