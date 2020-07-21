extends "../cFFXIVHumen_2_1/cFFXIVHumen_2_1.gd"

func _extInit():
	._extInit()
	chaName = "FFXIVHumen_2-name_3"
	attCoe.maxHp = 6.3
	attCoe.atk = 4.8
	attCoe.def = 5.8
	attCoe.mgiDef = 5.8
	lv = 4
	evos = []
	addCdSkill("skill_BlastingZone", 10)
	addSkillTxt("FFXIVHumen_2-skill_text_2")


const BLASTINGZONE_PW = 3.80 # 爆破领域威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BlastingZone":
		FFHurtChara(aiCha, att.atk * BLASTINGZONE_PW, PHY, SKILL)