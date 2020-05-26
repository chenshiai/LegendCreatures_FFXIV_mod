extends "../cFFXIVAolong_2_1/cFFXIVAolong_2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "无双斋-传奇"
	attCoe.maxHp = 4.3
	attCoe.atk = 5
	attCoe.def = 3.6
	attCoe.mgiDef = 3.3
	lv = 4
	evos = []
	addCdSkill("skill_Shinten", 8)
	addSkillTxt("""[必杀剑·震天]：冷却时间8s，对目标造成[300%]的物理伤害""")

const SHINTEN_PW = 3 # 震天威力
var baseId = ""

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Shinten":
		if aiCha != null:
			hurtChara(aiCha, att.atk * SHINTEN_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)