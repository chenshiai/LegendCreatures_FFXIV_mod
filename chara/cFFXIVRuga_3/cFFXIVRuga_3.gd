extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
var Utils = globalData.infoDs["g_FFXIVUtils"]

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "机工士"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 1
	attCoe.def = 2.9
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVRuga_3_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Autoturret", 3)
	addCdSkill("skill_Wildfire", 17)
	addSkillTxt("""[车式浮空炮塔]：冷却时间3s，机工士自带的浮空炮塔进行援护射击造成[40%]的物理伤害
[超载]：被动，浮空炮攻击5次后进入超载，机工士攻击力提升20%，持续8s。结束后进入冷却，降低10%的攻击力，持续5s""")
	addSkillTxt("[野火]：冷却时间17s，对目标附加野火状态，持续7s，结束后爆炸造成[技能期间的攻击次数 x 200%]的物理伤害")

const AUTOTURRET_PW = 0.40 # 车式浮空炮威力
const WILDFIRE_PW = 2.00 # 野火提升威力
var autoCount = 0 # 浮空炮攻击次数
var fireCount = 0 # 野火提升阶段
var fireChara = null # 被施加了野火的目标

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	autoCount = 0
	fireCount = 0
	fireChara = null

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret":
		autoturret()
	if id == "skill_Wildfire":
		wildfire()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.hitCha == fireChara && atkInfo.atkType == AtkType.NORMAL:
		if atkInfo.hitCha.hasBuff("b_Wildfire") != null:
			fireCount += 1
		elif atkInfo.hitCha.hasBuff("b_Wildfire") == null:
			if aiCha != null:
				hurtChara(aiCha, att.atk * WILDFIRE_PW * fireCount, Chara.HurtType.PHY, Chara.AtkType.SKILL)
				Utils.createEffect("blast", aiCha.position, Vector2(0,-40), 15, 1)
			fireCount = 0
			fireChara = null

# 车式浮空炮
func autoturret():
	if aiCha != null:
		autoCount += 1
		hurtChara(aiCha, att.atk * AUTOTURRET_PW, Chara.HurtType.PHY, Chara.AtkType.EFF)
	if autoCount > 4:
		autoCount = 0
		addBuff(BUFF_LIST.b_Overload.new(13))

# 野火		
func wildfire():
	if aiCha != null:
		fireChara = aiCha
		aiCha.addBuff(BUFF_LIST.b_Wildfire.new(7))