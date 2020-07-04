extends "../cex___FFXIVSummon/cex___FFXIVSummon.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "小仙女"
	isDeath = true
	addSkillTxt("小仙女会与学者一同作战，根据学者的等级来解锁技能")
	addSkillTxt("""lv2·[仙光的拥抱]：冷却4s，为生命最低的友方单位恢复学者[15%]法强的生命值
lv3·[仙光的低语]：冷却18s，为周围3格内的队友附加持续恢复效果，每秒恢复学者[5%]法强的生命值，持续10s
lv4·[异想的祥光]：冷却20s，为周围3格内的队友恢复学者[20%]法强的生命值""")

const EMBRACE_PW = 0.15
const WHISPERING_PW = 0.05
const BLESSING_PW = 0.20
func _connect():
	._connect()

# 仙光的拥抱
func skill_lv1():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		chas[0].plusHp(Summoner.att.mgiAtk * EMBRACE_PW)
		Utils.draw_effect("recovery1", chas[0].position, Vector2(0, -30), 15)

# 仙光的低语
func skill_lv2():
	var allys = getAllChas(2)
	allys.shuffle()
	Utils.draw_efftext("仙光的低语", Summoner.position, "#1a8a00")

	for cha in allys:
		if cha != null:
			BUFF_LIST.b_Whispering.new({
				"cha": cha,
				"dur": 10,
				"hot": Summoner.att.mgiAtk * WHISPERING_PW
			})

# 异想的祥光
func skill_lv3():
	var allys = getAllChas(2)
	allys.shuffle()
	Utils.draw_efftext("异想的祥光", Summoner.position, "#1a8a00")
	for cha in allys:
		if cha != null and !cha.isDeath:
			cha.plusHp(Summoner.att.mgiAtk * BLESSING_PW)
			yield(reTimer(0.1), "timeout")
