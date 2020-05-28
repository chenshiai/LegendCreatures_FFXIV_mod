extends "../cFFXIVNeko_1/cFFXIVNeko_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "传承之学"
	lv = 3
	evos = []
	addCdSkill("skill_Succor", 18)
	addSkillTxt("[士高气昂之策]：冷却时间18s，恢复自身和周围3格内队员[100%]法强的HP，并附加[鼓舞]效果，持续5s")
	addCdSkill("skill_SacredSoil", 20)
	addSkillTxt("[野战治疗阵]：冷却时间20s，使自身和周围2格内队员受到的伤害减少10%，并附加持续恢复效果，持续10s")

const SUCCOR_PW = 1.00 # 士高气昂之策威力
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
	var ailys = getCellChas(cell, 3, 2)
	ailys.shuffle()
	for cha in ailys:
		if cha != null:
			cha.plusHp(att.mgiAtk * SUCCOR_PW)
			cha.addBuff(BUFF_LIST.b_Adloquium.new(5, att.mgiAtk * SUCCOR_PW * shield_pw))
			Utils.createEffect("shield", cha.position, Vector2(0,-30), 7)
			yield(reTimer(0.1), "timeout")

func sacredSoil():
	var eff = newEff("numHit", Vector2(-30, -60))
	eff.setText("野战治疗阵！", "#1a8a00")
	var ailys = getCellChas(cell, 2, 2)
	for cha in ailys:
		if cha != null:
			cha.addBuff(BUFF_LIST.b_SacredSoil.new(10, att.mgiAtk * SACREDSOIL_PW))