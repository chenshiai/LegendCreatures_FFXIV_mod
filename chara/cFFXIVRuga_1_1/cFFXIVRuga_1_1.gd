extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冠军之剑"
	lv = 3
	evos = []
	addCdSkill("skill_DivineVeil", 26)
	addSkillTxt("[圣光幕帘]：冷却26s，技能开启后的5s内，若自身有受到治疗，则为周围其他队友附加护盾，可以抵消[骑士最大生命值10%]的伤害，持续10s")
	addSkillTxt(TEXT.format("[盾阵]：{TPassive}受到攻击时有30%的概率减少15%的伤害。"))
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
			if cha != null and cha != self:
				Utils.createEffect("shield", cha.position, Vector2(0, -30), 7, 1)
				cha.addBuff(BUFF_LIST.b_DivineVeil.new(10, att.maxHp * 0.1))
				yield(reTimer(0.1), "timeout")

func _upS():
	._upS()
	if hasDivineVeil:
		divineVeilDur -= 1
		if divineVeilDur < 0:
			divineVeilDur = 5
			hasDivineVeil = false