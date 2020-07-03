extends "../cFFXIVNeko_1/cFFXIVNeko_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "传承之学"
	lv = 3
	evos = []
	addCdSkill("skill_Succor", 17)
	addSkillTxt("[士高气昂之策]：冷却17s，恢复自身和周围4格内队员[50%]法强的HP，并附加[鼓舞]效果")
	addCdSkill("skill_SacredSoil", 20)
	addSkillTxt("""[野战治疗阵]：冷却20s，以生命值最少的队友为中心产生减轻伤害的防护区域。
区域内所有队友受到的伤害会减轻10%，并获得持续恢复效果，持续10s""")

const SUCCOR_PW = 0.50 # 士高气昂之策威力
const SACREDSOIL_PW = 0.05 # 野战治疗阵恢复力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

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
	# Utils.draw_effect("Sacred", position, Vector2(0, -50), 7, 1, true)
	var allys = getCellChas(cell, 3, 2)
	for cha in allys:
		if cha != null:
			BUFF_LIST.b_SacredSoil.new({
				"cha": cha,
				"dur": 10,
				"hot": att.mgiAtk * SACREDSOIL_PW
			})
