extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_DivineVeil", 26)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))
	if not is_connected("onPlusHp", self, "divineVeilTodo"):
		connect("onPlusHp", self, "divineVeilTodo")

var hasDivineVeil = false
var divineVeilDur = 5
var selfExample = null
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	hasDivineVeil = false

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DivineVeil":
		divineVeil()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if sys.rndPer(30):
		atkInfo.hurtVal *= 0.85

func over():
	pass

func divineVeil():
	hasDivineVeil = true

func divineVeilTodo(val):
	if hasDivineVeil:
		hasDivineVeil = false
		divineVeilDur = 5

		var allys = getAllChas(2)
		allys.shuffle()
		for cha in allys:
			if cha != null and !cha.isDeath and cha != self:
				Utils.draw_effect("ePcr_pingZhang", cha.position, Vector2(0, -30), 7, 1)
				BUFF_LIST.b_DivineVeil.new({
					"cha": cha,
					"dur": 10,
					"HD": att.maxHp * 0.1
				})
				yield(reTimer(0.1), "timeout")

func _upS():
	._upS()
	if hasDivineVeil:
		divineVeilDur -= 1
		if divineVeilDur < 0:
			divineVeilDur = 5
			hasDivineVeil = false