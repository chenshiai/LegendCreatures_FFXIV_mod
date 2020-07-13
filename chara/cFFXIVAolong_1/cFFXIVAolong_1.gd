extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const PLUSHP = 0.05 # 恢复量
const BLOODSPILLER_PW = 2.90 # 血溅倍率
var atkCount = 0 # 攻击次数
var darkCount = 0 # 暗黑值

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 5
	attCoe.atk = 3.6
	attCoe.def = 3.6
	attCoe.mgiDef = 4.4
	lv = 2
	evos = ["cFFXIVAolong_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Bloodspiller", 10)
	addSkillTxt(FFData.meterage % [0])
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	atkCount = 0
	BUFF_LIST.b_Abhor.new({"cha": self})

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Bloodspiller":
		bloodspiller()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == NORMAL:
		atkCount += 1
		if atkCount == 3:
			atkCount = 0
			atkInfo.atkVal *= 1.1
			plusHp(att.maxHp * PLUSHP)

func bloodspiller():
	FFHurtChara(aiCha, att.atk * BLOODSPILLER_PW, PHY, SKILL)