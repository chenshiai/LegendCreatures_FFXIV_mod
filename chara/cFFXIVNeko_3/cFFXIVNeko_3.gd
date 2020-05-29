extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "吟游诗人"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 0
	attCoe.def = 3
	attCoe.mgiDef = 3
	attAdd.cri += 0.4
	lv = 2
	evos = ["cFFXIVNeko_3_1"]
	addCdSkill("skill_LronJaws", 10)
	addCdSkill("skill_Ballad", 13)
	addCdSkill("skill_Paean", 8)
	addSkillTxt("""[伶牙俐齿]：冷却时间10s，对攻击目标造成[100%]的物理伤害，并附加5层[流血][中毒]
[贤者的叙事谣]：冷却时间13s，对目标造成[100%]的物理伤害，并使队伍全员攻击伤害提高5%，持续8s，此效果无法叠加
[光阴神的礼赞凯歌]：冷却时间8s，以HP最少的队员为目标，解除其[中毒][流血]，并使其免疫后来的所有负面效果，持续3s""")

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
		cha.addBuff(BUFF_LIST.b_Ballad.new(8))

# 光阴神的礼赞凯歌
func paean():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHp")
	var cha = chas[0]
	if cha != null:
		cha.addBuff(BUFF_LIST.b_Paean.new(3))

	var lx = cha.hasBuff("b_liuXue")
	var zd = cha.hasBuff("b_zhonDu")
	if lx != null:
		lx.isDel = true
	if zd != null:
		zd.isDel = true