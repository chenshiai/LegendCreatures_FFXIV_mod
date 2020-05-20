extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "机工士"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVRuga_3_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Autoturret", 3)
	addCdSkill("skill_Wildfire", 17)
	addSkillTxt("""[车式浮空炮塔]：复唱时间3s，机工士自带的浮空炮塔进行援护射击，与机工士同时攻击同一个目标，威力：40
[超载]：被动，浮空炮攻击5次后进入超载，机工士攻击力提升20%，持续8s。结束后进入冷却，降低10%的攻击力，持续5s
[野火]：复唱时间17s，对目标附加野火状态，持续7s，结束后爆炸造成物理伤害，每次普通攻击都会使野火威力提升150""")

const AUTOTURRET_PW = 0.40 # 车式浮空炮威力
const WILDFIRE_PW = 1.50 # 野火提升威力
var autoCount = 0 # 浮空炮攻击次数
var fireCount = 0 # 野火提升阶段
var fireChara = null # 被施加了野火的目标

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	autoCount = 0
	fireCount = 0
	fireChara = null

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret": autoturret()
	if id == "skill_Wildfire": wildfire()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.hitCha == fireChara && atkInfo.atkType == AtkType.NORMAL:
		if atkInfo.hitCha.hasBuff("b_Wildfire") != null:
			fireCount += 1
			print("野火层数：", fireCount)
		elif atkInfo.hitCha.hasBuff("b_Wildfire") == null:
			print("野火触发！", att.atk * WILDFIRE_PW * fireCount)
			hurtChara(aiCha, att.atk * WILDFIRE_PW * fireCount, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			fireCount = 0
			fireChara = null

# 车式浮空炮
func autoturret():
	if aiCha != null:
		autoCount += 1
		hurtChara(aiCha, att.atk * AUTOTURRET_PW, Chara.HurtType.PHY, Chara.AtkType.EFF)
	if autoCount >= 5:
		autoCount = 0
		addBuff(b_Overload.new(13))

# 野火		
func wildfire():
	if aiCha != null:
		fireChara = aiCha
		aiCha.addBuff(b_Wildfire.new(7))

# 野火Buff
class b_Wildfire:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Wildfire"
		isNegetive = false
		life = dur

	func _upS():
		life = clamp(life, 0, 7)
		if life < 1: life = 0

class b_Overload:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Overload"
		isNegetive = false
		life = dur

	func _upS():
		if life > 5:
			att.atkR = 0.20
		else:
			att.atkR = - 0.10 
		life = clamp(life, 0, 13)
		if life < 1: life = 0