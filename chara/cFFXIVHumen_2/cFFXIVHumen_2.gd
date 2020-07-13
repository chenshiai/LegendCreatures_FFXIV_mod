extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4.5
	attCoe.atk = 4
	attCoe.def = 4.3
	attCoe.mgiDef = 4.3
	lv = 2
	evos = ["cFFXIVHumen_2_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_BowShock", 9)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))

const BOWSHOCK_PW = 2.60 # 弓形冲波威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BowShock":
		bowShock()

# 弓形冲波
func bowShock():
	var chas = getCellChas(cell, 2, 1)
	for i in chas:
		FFHurtChara(i, att.atk * BOWSHOCK_PW, PHY, SKILL)
		i.addBuff(b_shaoZhuo.new(4))

func _onHurt(atkInfo:AtkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80
