extends "../cFFXIVAolong_1/cFFXIVAolong_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "深渊之暗"
	lv = 3
	evos = []
	addCdSkill("skill_DarkMissionary", 12)
	addSkillTxt("""[至黑之夜]：造成非特效伤害时会累计暗黑值，达到1000点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却时间12s，使队伍全员受到魔法伤害减少20%，持续6s""")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()
	darkCount = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DarkMissionary":
		darkMissionary()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != AtkType.EFF:
		darkCount += atkInfo.atkVal * 0.5
		if darkCount >= 1000:
			darkCount = 0
			addBuff(BUFF_LIST.b_TheBlackestNight.new(att.maxHp * 0.20))
			Utils.createEffect("shield", position, Vector2(0,-30), 7)

# 暗黑布道			
func darkMissionary():
	var allys = getAllChas(2)
	for cha in allys:
		if cha != null:
			cha.addBuff(BUFF_LIST.b_DarkMissionary.new(6))