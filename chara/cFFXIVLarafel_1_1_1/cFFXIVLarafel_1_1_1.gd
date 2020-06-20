extends "../cFFXIVLarafel_1_1/cFFXIVLarafel_1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "嘉恩·艾·神纳-传奇"
	attCoe.maxHp = 4
	attCoe.mgiAtk = 5
	attCoe.def = 3.5
	attCoe.mgiDef = 3.9
	lv = 4
	evos = []
	# addSkillTxt("[神速咏唱]：{TPassive}加快自身15%的技能释放速度")
	addCdSkill("skill_Assize", 19)
	addSkillTxt(TEXT.format("[法令]：冷却19s，对周围3格内的敌人造成[270%]法强的{TMgiHurt}，同时为范围内的队友恢复[90%]法强的HP"))

var baseId = ""
const ASSIZE_PW = 2.70 # 法令伤害威力
const ASSIZE_HEAL_PW = 0.90 # 法令治疗威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Assize":
		assize()

func assize():
	var allys = getCellChas(self.cell, 3, 2)
	for cha in allys:
		if cha != null:
			cha.plusHp(att.mgiAtk * CUREIII_PW)

	var enmy = getCellChas(self.cell, 3)
	for cha in enmy:
		FFHurtChara(cha, att.mgiAtk * STORNIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)