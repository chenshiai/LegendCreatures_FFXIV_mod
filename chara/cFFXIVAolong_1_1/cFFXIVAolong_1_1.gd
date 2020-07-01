extends "../cFFXIVAolong_1/cFFXIVAolong_1.gd"

var SKILL_TXT_1_1 = """[至黑之夜]：造成非特效伤害时会累计暗黑值，达到700点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却12s，使队伍全员受到的{TMgiHurt}减少10%，持续6s"""

func _extInit():
	._extInit()
	chaName = "深渊之暗"
	lv = 3
	evos = []
	addCdSkill("skill_DarkMissionary", 12)
	addSkillTxt(TEXT.format(SKILL_TXT_1_1))

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
	if atkInfo.atkType != EFF:
		darkCount += atkInfo.atkVal / self.lv
		skillStrs[0] = "暗黑值：%d / 700" % [darkCount]
		if darkCount >= 700:
			darkCount = 0
			BUFF_LIST.b_TheBlackestNight.new({
				"cha": self,
				"HD": att.maxHp * 0.20
			})
			Utils.draw_effect("ePcr_phyPZ", position, Vector2(0,-30), 15)

# 暗黑布道			
func darkMissionary():
	var allys = getAllChas(2)
	for cha in allys:
		BUFF_LIST.b_DarkMissionary.new({
			"cha": cha,
			"dur": 6
		})