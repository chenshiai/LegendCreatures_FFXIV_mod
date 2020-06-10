extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冠军之剑"
	lv = 3
	evos = []
	addCdSkill("skill_DivineVeil", 16)
	addSkillTxt("[圣光幕帘]：冷却16s，技能开启后的5s内，若自身有受到治疗，则为周围其他队友附加护盾，可以抵消[骑士最大生命值10%]的伤害，持续10s")
	addSkillTxt("[盾阵]：被动，受到攻击时有30%的概率减少40%的伤害。")

var hasDivineVeil = false
var divineVeilDur = 5

func _connect():
	._connect()
	self.connect("onPlusHp", self, "divineVeilTodo")

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
		atkInfo.hurtVal *= 0.60

func divineVeil():
	hasDivineVeil = true

func divineVeilTodo(val):
	if hasDivineVeil:
		hasDivineVeil = false
		divineVeilDur = 5
		print("圣光幕帘触发了")

		var allys = getAllChas(2)
		for cha in allys:
			if cha != null and cha != self:
				cha.addBuff(BUFF_LIST.b_DivineVeil.new(10, att.maxHp * 0.1))

func _upS():
	._upS()
	if hasDivineVeil:
		divineVeilDur -= 1
		if divineVeilDur < 0:
			divineVeilDur = 5
			hasDivineVeil = false