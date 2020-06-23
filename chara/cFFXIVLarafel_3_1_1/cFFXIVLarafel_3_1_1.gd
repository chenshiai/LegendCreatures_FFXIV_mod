extends "../cFFXIVLarafel_3_1/cFFXIVLarafel_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "西·如恩·提亚-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 4
	attCoe.mgiAtk = 5.5
	attCoe.def = 4
	attCoe.mgiDef = 4.3
	lv = 4
	evos = []
	addSkillTxt(TEXT.format("[抗争之力]：{TPassive}当黑白魔元失衡时（差距大于30），则量少魔元的获得量提高10点"))


const MORGEN_UP = 10

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Verthunder":
		if blackMorgen - whiteMorgan >= 30:
			whiteMorgan += MORGEN_UP
		elif whiteMorgan - blackMorgen >= 30:
			blackMorgen += MORGEN_UP