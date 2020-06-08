extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "白魔法师"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVLarafel_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_CureII", 9)
	addCdSkill("skill_CureIII", 14)
	addCdSkill("skill_Regen", 18)
	addSkillTxt("""[救疗]：冷却9s，为生命最低的友方单位恢复[80%]法强的生命值
[医济]：冷却14s，为全体友方单位恢复[60%]法强的HP，并附加[再生]效果，持续5s""")
	addSkillTxt("[再生]：冷却18s，为生命最低的友方单位附加再生，每秒恢复[10%]法强的HP，持续10s")

const CUREII_PW = 0.80 # 救疗威力
const CUREIII_PW = 0.60 # 医济威力
const REGEN_PW = 0.10 # 再生威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_CureII":
		cureII()
	if id == "skill_CureIII":
		cureIII()
	if id == "skill_Regen":
		regen()

# 救疗
func cureII():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		Utils.createEffect("healGreen", chas[0].position, Vector2(0, -30), 11, 1)
		chas[0].plusHp(att.mgiAtk * CUREII_PW)

# 医济		
func cureIII():
	var allys = getAllChas(2)
	allys.shuffle()
	for cha in allys:
		if cha != null:
			cha.addBuff(BUFF_LIST.b_Regen.new(5, att.mgiAtk * REGEN_PW))
			cha.plusHp(att.mgiAtk * CUREIII_PW)
			yield(reTimer(0.1), "timeout")

# 再生
func regen():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		chas[0].addBuff(BUFF_LIST.b_Regen.new(10, att.mgiAtk * REGEN_PW))