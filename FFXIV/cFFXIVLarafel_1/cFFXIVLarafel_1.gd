extends "../BaseChara/FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const CUREII_PW = 0.80 # 救疗威力
const CUREIII_PW = 0.50 # 医济威力
const REGEN_PW = 0.10 # 再生威力

func _init():
	logoImgName = "WhiteMage"
	OCCUPATION = "Treatment"

func _extInit():
	._extInit()
	chaName = FFData.name_1
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
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


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
		chas[0].plusHp(att.mgiAtk * CUREII_PW)


# 医济
func cureIII():
	var allys = getAllChas(2)
	allys.shuffle()
	for cha in allys:
		cha.plusHp(att.mgiAtk * CUREIII_PW)
		BUFF_LIST.b_Regen.new({
			"cha": cha,
			"dur": 8,
			"hot": att.mgiAtk * REGEN_PW
		})
		yield(reTimer(0.1), "timeout")


# 再生
func regen():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		BUFF_LIST.b_Regen.new({
			"cha": chas[0],
			"dur": 10,
			"hot": att.mgiAtk * REGEN_PW
		})