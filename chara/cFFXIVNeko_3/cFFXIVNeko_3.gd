extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

func _extInit():
	._extInit()
	OCCUPATION = "DistanceDPS"
	chaName = FFData.name_1
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4.1
	attCoe.def = 3
	attCoe.mgiDef = 3
	attAdd.cri += 0.2
	lv = 2
	evos = ["cFFXIVNeko_3_1"]
	addCdSkill("skill_LronJaws", 10)
	addCdSkill("skill_Ballad", 16)
	addCdSkill("skill_Paean", 20)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_LronJaws":
		lronjaws()
	if id == "skill_Ballad":
		ballad()
	if id == "skill_Paean":
		paean()

# 伶牙俐齿
func lronjaws():
	normalAtkChara(aiCha)
	aiCha.addBuff(b_zhonDu.new(5))
	aiCha.addBuff(b_liuXue.new(5))

# 贤者的叙事谣
func ballad():
	normalAtkChara(aiCha)
	var chas = getAllChas(2)
	for cha in chas :
		BUFF_LIST.b_Ballad.new({"cha": cha, "dur": 8})

# 大地神的抒情恋歌
func paean():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")
	var cha = chas[0]
	if cha != null:
		BUFF_LIST.b_Paean.new({"cha": cha, "dur": 10})
