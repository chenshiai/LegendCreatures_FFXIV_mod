extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _extInit():
	._extInit()
	OCCUPATION = "DistanceDPS"
	chaName = "舞者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.def = 2.8
	attCoe.mgiDef = 2.8
	attAdd.cri += 0.3
	lv = 2
	evos = ["cFFXIVHumen_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_DanceStep", 23)
	addSkillTxt(TEXT.format("[伶俐]：『{TPassive}』技能可以产生暴击"))
	addSkillTxt(TEXT.format("[闭式舞姿]：『{TPassive}』战斗开始时，选择物攻最高与魔攻最高的队友作为舞伴，提高他们与自己的攻击力10%"))
	addSkillTxt(TEXT.format("[标准舞步]：冷却23s，对三格内的敌人造成[600%]的{TPhyHurt}，同时舞伴与自己的攻击力再提升10%，持续10s"))

const DANCESTEP_PW = 6 # 标准舞步威力
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

func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.canCri = true

# 寻找舞伴		
func setDancePartner():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MaxMgiAtk")
	mgiAtkMaxAlly = chas[0]

	chas.sort_custom(Utils.Calculation, "sort_MaxAtk")
	atkMaxAlly = chas[0]

	if mgiAtkMaxAlly != self:
		BUFF_LIST.b_DancingPartner.new(mgiAtkMaxAlly)

	if atkMaxAlly != self and atkMaxAlly != mgiAtkMaxAlly:
		BUFF_LIST.b_DancingPartner.new(atkMaxAlly)

	BUFF_LIST.b_DancingPartner.new(self)

# 标准舞步
func danceStep():
	var chas = getCellChas(cell, 3)
	for i in chas:
		FFHurtChara(i, att.atk * DANCESTEP_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

	BUFF_LIST.b_DanceStep.new(10, self)
	BUFF_LIST.b_DanceStep.new(10, atkMaxAlly)
	BUFF_LIST.b_DanceStep.new(10, mgiAtkMaxAlly)
	var eff = newEff("numHit", Vector2(-10, -60))
	eff.setText("标准舞步！", "#ff008a")