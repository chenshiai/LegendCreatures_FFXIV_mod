extends "../BaseChara/FFXIVSummon.gd"

func _extInit():
	._extInit()
	chaName = "小仙女"
	isDeath = true
	addSkillTxt("小仙女会与学者一同作战，根据学者的等级来解锁技能")
	addSkillTxt("""lv2·[仙光的拥抱]：冷却4s，为生命最低的友方单位恢复学者[15%]法强的生命值
lv3·[异想的幻光]：冷却18s，使所有队友受到的治疗效果提高10%，持续10s
lv4·[异想的祥光]：冷却20s，为所有队友恢复学者[20%]法强的生命值""")

const EMBRACE_PW = 0.15
# const WHISPERING_PW = 0.05
const BLESSING_PW = 0.20

# 仙光的拥抱
func skill_lv1():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		chas[0].plusHp(Summoner.att.mgiAtk * EMBRACE_PW, false)
		Utils.draw_effect("recovery1", chas[0].position, Vector2(0, -30), 15)

# 异想的幻光
func skill_lv2():
	for cha in getAllChas(2):
		BUFF_LIST.b_Whispering.new({
			"cha": cha,
			"dur": 10,
		})

# 异想的祥光
func skill_lv3():
	var allys = getAllChas(2)
	allys.shuffle()
	for cha in allys:
		cha.plusHp(Summoner.att.mgiAtk * BLESSING_PW, false)
		yield(reTimer(0.1), "timeout")
