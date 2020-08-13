extends "../cFFXIVNeko_1/cFFXIVNeko_1.gd"

const SUCCOR_PW = 0.50 # 士高气昂之策威力
const SACREDSOIL_PW = 0.05 # 野战治疗阵恢复力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Succor", 17)
	addCdSkill("skill_SacredSoil", 20)
	addCdSkill("skill_Summon_2", 18)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Succor":
		succor()
	if id == "skill_SacredSoil":
		sacredSoil()


func succor():
	var allys = getCellChas(cell, 4, 2)
	allys.shuffle()
	for cha in allys:
		if cha != null and !cha.isDeath:
			cha.plusHp(att.mgiAtk * SUCCOR_PW, false)
			BUFF_LIST.b_Adloquium.new({
				"cha": cha,
				"dur": 10,
				"HD": att.mgiAtk * SUCCOR_PW * shield_pw
			})
			Utils.draw_effect("shield", cha.position, Vector2(0,-30), 14)
			yield(reTimer(0.1), "timeout")


func sacredSoil():
	Utils.draw_efftext("野战治疗阵！", position, "#1a8a00")
	var allys = getCellChas(cell, 3, 2)
	for cha in allys:
		BUFF_LIST.b_SacredSoil.new({
			"cha": cha,
			"dur": 10,
			"hot": att.mgiAtk * SACREDSOIL_PW
		})
