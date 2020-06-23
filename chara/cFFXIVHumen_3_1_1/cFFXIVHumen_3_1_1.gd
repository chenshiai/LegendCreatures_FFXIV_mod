extends "../cFFXIVHumen_3_1/cFFXIVHumen_3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "娜休梅拉-传奇"
	attCoe.maxHp = 4
	attCoe.atk = 5
	attCoe.def = 3.2
	attCoe.mgiDef = 3.8
	lv = 4
	evos = []
	addCdSkill("skill_Devilment", 18)
	addSkillTxt("[进攻之探戈]：冷却18s，自身与舞伴的攻击力提高20%，持续8s")



func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Devilment":
		devilment()

# 进攻探戈
func devilment():
	BUFF_LIST.b_Devilment.new(8)
	BUFF_LIST.b_Devilment.new(8, atkMaxAlly)
	BUFF_LIST.b_Devilment.new(8, mgiAtkMaxAlly)
	var eff = newEff("numHit", Vector2(-40, -60))
	eff.setText("进攻之探戈！", "#ff008a")