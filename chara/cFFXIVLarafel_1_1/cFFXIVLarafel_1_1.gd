extends "../cFFXIVLarafel_1/cFFXIVLarafel_1.gd"
const STORNIII_PW = 1.0 # 崩石威力

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_Benediction", 20)
	addCdSkill("skill_StornIII", 4)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onBattleStart():
	._onBattleStart()
	var sk = getSkill("skill_Benediction")
	sk.cd = 20


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Benediction":
		benediction()
	if id == "skill_StornIII":
		stornIII()


func stornIII():
	var d:Eff = newEff("sk_feiDang",sprcPos)
	d._initFlyCha(aiCha)
	yield(d, "onReach")
	FFHurtChara(aiCha, att.mgiAtk * STORNIII_PW, MGI, SKILL)


func benediction():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")
	if chas[0] != null:
		chas[0].plusHp(chas[0].att.maxHp)

	var sk = getSkill("skill_Benediction")
	sk.cd = 60
