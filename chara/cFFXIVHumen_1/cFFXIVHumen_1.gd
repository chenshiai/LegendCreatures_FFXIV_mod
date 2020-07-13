extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4.7
	attCoe.atk = 4
	attCoe.def = 4
	attCoe.mgiDef = 4
	lv = 2
	evos = ["cFFXIVHumen_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Shiver", 10)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Shiver":
		shiver()

func _onBattleStart():
	._onBattleStart()

func shiver():
	plusHp(att.maxHp * 0.20)
	BUFF_LIST.b_Shiver.new({"cha": self, "dur": 10})

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80