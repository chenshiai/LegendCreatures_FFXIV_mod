extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "舞者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4 
	attCoe.mgiAtk = 2
	attCoe.def = 2.8
	attCoe.mgiDef = 2.8
	attAdd.cri += 0.3
	lv = 2
	evos = ["cFFXIVHumen_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_DanceStep", 35)
	addSkillTxt("[闭式舞姿]：被动，战斗开始时，选择物攻最高与魔攻最高的队友作为舞伴，提高他们与自己的攻击力10%，可以叠加")
	addSkillTxt("[标准舞步]：冷却时间35s，对三格内的敌人造成[1000%]的物理伤害，同时舞伴与自己的攻击力再提升10%，持续10s")

const DANCESTEP_PW = 10 # 标准舞步威力
var atkMaxAlly = null # 攻击力最高的队友
var mgiAtkMaxAlly = null # 法强最高的队友

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	setDancePartner()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DanceStep":
		danceStep()

# 寻找舞伴		
func setDancePartner():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MaxMgiAtk")
	mgiAtkMaxAlly = chas[0]

	chas.sort_custom(Utils.Calculation, "sort_MaxAtk")
	atkMaxAlly = chas[0]

	mgiAtkMaxAlly.addBuff(BUFF_LIST.b_DancingPartner.new())
	atkMaxAlly.addBuff(BUFF_LIST.b_DancingPartner.new())

	addBuff(BUFF_LIST.b_DancingPartner.new())

# 标准舞步
func danceStep():
	var chas = getCellChas(cell, 3)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atk * DANCESTEP_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)
	
	addBuff(BUFF_LIST.b_DanceStep.new(10))
	atkMaxAlly.addBuff(BUFF_LIST.b_DanceStep.new(10))
	mgiAtkMaxAlly.addBuff(BUFF_LIST.b_DanceStep.new(10))
	var eff = newEff("numHit", Vector2(-10, -60))
	eff.setText("标准舞步！", "#ff008a")