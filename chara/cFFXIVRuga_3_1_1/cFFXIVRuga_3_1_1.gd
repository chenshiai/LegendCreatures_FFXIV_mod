extends "../cFFXIVRuga_3_1/cFFXIVRuga_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "希尔达-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 4
	evos = []
	addSkillTxt("[机工士的明天！]：车式浮空炮增加至三个，多出的浮空炮不会累计攻击次数")

var baseId = ""

func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret":
		yield(reTimer(0.2), "timeout")
		autoturret(false)
		yield(reTimer(0.2), "timeout")
		autoturret(false)