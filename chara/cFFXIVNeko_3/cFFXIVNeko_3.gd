extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "DistanceDPS"
	chaName = "吟游诗人"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVNeko_3_1"]
	addCdSkill("skill_LronJaws", 10)
	addCdSkill("skill_Ballad", 16)
	addCdSkill("skill_Paean", 20)
	addSkillTxt(TEXT.format("""[伶牙俐齿]：冷却10s，对目标发动一次额外的普通攻击，并附加5层[流血][中毒]
[贤者的叙事谣]：冷却16s，对目标发动一次额外的普通攻击，并使队伍全员攻击伤害提高5%，持续8s，此效果无法叠加
[大地神的抒情恋歌]：冷却20s，以生命值最少的队员为目标，使其受到的治疗效果提高20%，持续10s"""))

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
