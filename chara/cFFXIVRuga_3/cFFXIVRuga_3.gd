extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "DistanceDPS"
	chaName = "机工士"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3
	lv = 2
	evos = ["cFFXIVRuga_3_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Autoturret", 3)
	addCdSkill("skill_Wildfire", 17)
	addSkillTxt(TEXT.format("""[车式浮空炮塔]：冷却3s，机工士自带的浮空炮塔进行援护射击造成[50%]的{TPhyHurt}
[超载]：『{TPassive}』浮空炮攻击5次后进入超载，机工士攻击力提升20%，持续8s。"""))
	addSkillTxt(TEXT.format("[野火]：冷却17s，对目标附加野火状态，持续7s，结束后爆炸造成[技能期间的攻击次数 x 200%]的{TPhyHurt}"))

const AUTOTURRET_PW = 0.50 # 车式浮空炮威力
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
		autoturret(true)
	if id == "skill_Wildfire":
		wildfire()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.hitCha == fireChara and atkInfo.atkType == AtkType.NORMAL:
		if atkInfo.hitCha.hasBuff("b_Wildfire") != null:
			fireCount += 1
		elif atkInfo.hitCha.hasBuff("b_Wildfire") == null:
			FFHurtChara(aiCha, att.atk * WILDFIRE_PW * fireCount, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			Utils.createEffect("blast", aiCha.position, Vector2(0,-40), 15, 1)
			fireCount = 0
			fireChara = null

# 车式浮空炮
func autoturret(addCount):
	if addCount:
		autoCount += 1

	if autoCount > 4:
		autoCount = 0
		addBuff(BUFF_LIST.b_Overload.new(13))
		
	FFHurtChara(aiCha, att.atk * AUTOTURRET_PW, Chara.HurtType.PHY, Chara.AtkType.EFF)

	

# 野火		
func wildfire():
	if aiCha != null:
		fireChara = aiCha
		aiCha.addBuff(BUFF_LIST.b_Wildfire.new(7))