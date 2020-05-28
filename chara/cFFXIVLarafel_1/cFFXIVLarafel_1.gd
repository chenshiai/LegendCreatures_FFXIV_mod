extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

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
	addCdSkill("skill_CureII", 10)
	addCdSkill("skill_CureIII", 15)
	addCdSkill("skill_Regen", 18)
	addSkillTxt("""[救疗]：冷却时间10s，为生命最低的友方单位恢复[80%]法强的HP
[愈疗]：冷却时间15s，为全体友方单位恢复[60%]法强的HP""")
	addSkillTxt("[再生]：冷却时间18s，为生命最低的友方单位附加再生，每秒恢复[15%]法强的HP，持续10s")

const CUREII_PW = 0.80 # 救疗威力
const CUREIII_PW = 0.60 # 愈疗威力
const REGEN_PW = 0.15 # 再生威力

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
	var cha = null
	var chas = getAllChas(2)
	cha = Utils.Calculation.sortChasByMinHp(chas)
	if cha[0] != null:
		cha[0].plusHp(att.mgiAtk * CUREII_PW)

# 愈疗		
func cureIII():
	var allys = getAllChas(2)
	for cha in allys:
		if cha != null:
			cha.plusHp(att.mgiAtk * CUREIII_PW)

# 再生
func regen():
	var cha = null
	var chas = getAllChas(2)
	cha = Utils.Calculation.sortChasByMinHp(chas)
	if cha[0] != null:
		cha[0].addBuff(BUFF_LIST.b_Regen.new(10, att.mgiAtk * REGEN_PW))