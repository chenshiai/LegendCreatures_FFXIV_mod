extends "../cFFXIVLarafel_1/cFFXIVLarafel_1.gd"

func _extInit():
	._extInit()
	chaName = "角尊之白"
	lv = 3
	evos = []
	addCdSkill("skill_Benediction", 20)
	addSkillTxt("[天赐祝福]：冷却20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却延长至60s")
	addCdSkill("skill_StornIII", 4)
	addSkillTxt(TEXT.format("[崩石]：冷却4s，对目标造成[90%]的{TMgiHurt}"))

const STORNIII_PW = 0.90 # 崩石威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	var sk = getSkill("skill_Benediction")
	sk.cd = 20
	skillStrs[2] = "[天赐祝福]：冷却20s，为生命最低的友方单位恢复至满血，第一次使用后，此技能冷却延长至60s"

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
	FFHurtChara(aiCha, att.mgiAtk * STORNIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func benediction():
	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MinHpP")
	if chas[0] != null:
		chas[0].plusHp(chas[0].att.maxHp)
	
	var sk = getSkill("skill_Benediction")
	sk.cd = 60
	skillStrs[2] = "[天赐祝福]：冷却60s，为生命最低的友方单位恢复至满血（已经使用过一次）"
	Utils.createEffect("heal", position, Vector2(0, -30), 7)
