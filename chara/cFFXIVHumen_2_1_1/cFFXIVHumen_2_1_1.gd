extends "../cFFXIVHumen_2_1/cFFXIVHumen_2_1.gd"

func _extInit():
	._extInit()
	chaName = "桑克瑞德-传奇"
	attCoe.maxHp = 6.3
	attCoe.atk = 4.8
	attCoe.def = 5.8
	attCoe.mgiDef = 5.8
	lv = 4
	evos = []
	addCdSkill("skill_BlastingZone", 15)
	addSkillTxt(TEXT.format("[爆破领域]：冷却15s，对目标造成[380%]的{TPhyHurt}"))

var baseId = ""
const BLASTINGZONE_PW = 3.80 # 爆破领域威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_BlastingZone":
		if aiCha != null:
			hurtChara(aiCha, att.atk * BLASTINGZONE_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)