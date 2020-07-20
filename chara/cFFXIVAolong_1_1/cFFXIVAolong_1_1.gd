extends "../cFFXIVAolong_1/cFFXIVAolong_1.gd"

func _extInit():
	._extInit()
	chaName = "FFXIVAolong_1-name_2"
	lv = 3
	evos = []
	addCdSkill("skill_DarkMissionary", 12)
	addSkillTxt("FFXIVAolong_1-skill_text_1")

func _onBattleEnd():
	._onBattleEnd()
	darkCount = 0
	skillStrs[0] = "%s: %d / 700" % [meterage[locale], darkCount]

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DarkMissionary":
		darkMissionary()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType != EFF:
		darkCount += atkInfo.atkVal / self.lv
		skillStrs[0] = "%s: %d / 700" % [meterage[locale], darkCount]
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