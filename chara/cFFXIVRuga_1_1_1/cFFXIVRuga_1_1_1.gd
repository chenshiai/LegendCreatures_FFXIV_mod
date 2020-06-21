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
	addSkillTxt("[神圣领域]：战斗开始时开启无敌，持续10s，之后每70s使用一次")
	addCdSkill("skill_Superbolide", 70)

var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	BUFF_LIST.b_Superbolide.new(10, self)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Superbolide":
		BUFF_LIST.b_Superbolide.new(10, self)
