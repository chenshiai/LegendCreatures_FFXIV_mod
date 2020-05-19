extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "舞者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVHumen_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_DanceStep", 35)#添加cd技能
	addSkillTxt("""[闭式舞姿]：被动，战斗开始时，选择物攻最高与魔攻最高的队友作为舞伴，提高他们与自己的攻击力10%，不可以叠加
[标准舞步]：复唱时间35s，对三格内的敌人造成物理伤害，同时舞伴与自己的攻击力再提升10%，持续10s，威力：1000""")

const DANCESTEP_PW = 10 # 标准舞步威力
var atkMaxAlly = null # 攻击力最高的队友
var mgiAtkMaxAlly = null # 法强最高的队友

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	setDancePartner()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DanceStep": danceStep()

# 寻找舞伴		
func setDancePartner():
	var chas = getAllChas(2)
	chas.sort_custom(self, "sortMgiAtkMax")
	for i in range(1):
		if i >= chas.size() : break
		mgiAtkMaxAlly = chas[i]
		mgiAtkMaxAlly.addBuff(b_DancingPartner.new(10))

	var allys = getAllChas(2)
	allys.sort_custom(self, "sortAtkMax")
	for i in range(1):
		if i >= allys.size() : break
		atkMaxAlly = allys[i]
		atkMaxAlly.addBuff(b_DancingPartner.new(10))

	addBuff(b_DancingPartner.new(10))

# 标准舞步
func danceStep():
	var chas = getCellChas(cell, 3)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atk * DANCESTEP_PW, HurtType.PHY)
	
	addBuff(b_DanceStep.new(10))
	atkMaxAlly.addBuff(b_DanceStep.new(10))
	mgiAtkMaxAlly.addBuff(b_DanceStep.new(10))

# 魔法强度排序
func sortMgiAtkMax(a,b):
	if a.att.mgiAtk > b.att.mgiAtk :
		return true
	return false

# 物理攻击排序
func sortAtkMax(a,b):
	if a.att.atk > b.att.atk :
		return true
	return false

# 舞伴buff
class b_DancingPartner:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_DancingPartner"
		isNegetive = false
		life = dur

	func _upS():
		att.atkR = 0.10
		att.mgiAtk = masCha.att.mgiAtk * 0.10
		if life <= 1: life = 10
# 伶俐
class b_DanceStep:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_DanceStep"
		isNegetive = false
		life = dur

	func _upS():
		att.atkR = 0.10
		att.mgiAtk = masCha.att.mgiAtk * 0.10
		life = clamp(life, 0, 10)
		if life <= 1: life = 0