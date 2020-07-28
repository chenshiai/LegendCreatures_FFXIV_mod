extends "../BaseChara/FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const GRACE_PW = 12 # 深仁厚泽威力
const AUTHORITY_PW = 3.50 # 王权剑威力

func _extInit():
	._extInit()
	OCCUPATION = "Protect"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4.5
	attCoe.atk = 3.7
	attCoe.mgiAtk = 0.5
	attCoe.def = 5
	attCoe.mgiDef = 4
	attAdd.defL = 0.1
	lv = 2
	evos = ["cFFXIVRuga_1_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_Grace", 15)
	addCdSkill("skill_Authority", 6)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleStart():
	._onBattleStart()
	Utils.draw_effect("defense", position, Vector2(0,-60), 14)


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Grace":
		grace()
	if id == "skill_Authority":
		authority()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal *= 0.80


# 深仁厚泽		
func grace():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")

	if chas[0] != null:
		chas[0].plusHp(att.mgiAtk * GRACE_PW)
		Utils.draw_effect("laser", chas[0].position, Vector2(0, -60), 7, 1)


# 王权剑		
func authority():
	FFHurtChara(aiCha, att.atk * AUTHORITY_PW, PHY, SKILL)