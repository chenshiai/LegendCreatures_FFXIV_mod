extends "../cFFXIVRuga_1/cFFXIVRuga_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冠军之剑"
	lv = 3
	evos = []
	addCdSkill("skill_Requiescat", 27)
	addCdSkill("skill_DivineVeil", 16)
	addSkillTxt("[安魂祈祷]：ÇÐ27s，自身魔法强度提高50点，持续15s")
	addSkillTxt("[圣光幕帘]：ÇÐ16s，技能开启后的5s内，若自身有受到治疗，则为周围其他队友附加护盾，可以抵消[骑士最大生命值10%]的伤害，持续10s")


var hasDivineVeil = false
var divineVeilDur = 5
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	hasDivineVeil = false

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Requiescat":
		requiescat()
	if id == "skill_DivineVeil":
		divineVeil()

func requiescat():
	addBuff(BUFF_LIST.b_Requiescat.new(15))

func divineVeil():
	hasDivineVeil = true

func _onPlusHp(val):
	._onPlusHp(val)
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
		print("圣光幕帘持续中")
		if divineVeilDur < 0:
			divineVeilDur = 5
			print("圣光幕帘结束了")
			hasDivineVeil = false