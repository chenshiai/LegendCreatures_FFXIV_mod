extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const AUTOTURRET_PW = 0.50 # 车式浮空炮威力
const WILDFIRE_PW = 2.00 # 野火提升威力
var autoCount = 0 # 浮空炮攻击次数
var fireCount = 1 # 野火提升阶段
var fireChara = null # 被施加了野火的目标

func _extInit():
	._extInit()
	OCCUPATION = "LongRange"
	chaName = FFData.name_1
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3
	attAdd.cri -= 0.1
	lv = 2
	evos = ["cFFXIVRuga_3_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_Autoturret", 3)
	addCdSkill("skill_Wildfire", 17)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleStart():
	._onBattleStart()
	autoCount = 0
	fireCount = 1
	fireChara = null
	yield(reTimer(1), "timeout")
	call_deferred("wildfire")


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret":
		autoturret(true)
	if id == "skill_Wildfire":
		wildfire()


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.hitCha == fireChara and atkInfo.atkType == NORMAL:
		if atkInfo.hitCha.hasBuff("b_Wildfire") != null:
			fireCount += 1
		elif atkInfo.hitCha.hasBuff("b_Wildfire") == null:
			FFHurtChara(aiCha, att.atk * WILDFIRE_PW * fireCount, PHY, SKILL)
			Utils.draw_effect("blast", aiCha.position, Vector2(0,-40), 15, 1)
			fireCount = 0
			fireChara = null


# 车式浮空炮
func autoturret(addCount):
	if addCount:
		autoCount += 1
	if autoCount > 4:
		autoCount = 0
		BUFF_LIST.b_Overload.new({"cha": self, "dur": 13})
	FFHurtChara(aiCha, att.atk * AUTOTURRET_PW, PHY, SKILL)


# 野火
func wildfire():
	if aiCha != null:
		fireChara = aiCha
		BUFF_LIST.b_Wildfire.new({"cha": aiCha, "dur": 7})