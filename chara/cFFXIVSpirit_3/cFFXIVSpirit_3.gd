extends "../BaseChara/FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const HIGHJUMP_PW = 3.30 # 高跳威力
const GEIRSKOGUL_PW = 4.00 # 武神枪威力

func _extInit():
	._extInit()
	OCCUPATION = "CloseCombat"
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	lv = 2
	evos = ["cFFXIVSpirit_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_HighJump", 11)
	addCdSkill("skill_DragonBlood", 12)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleStart():
	._onBattleStart()
	call_deferred("highJump")


func _onBattleEnd():
	._onBattleEnd()
	normalSpr.position = Vector2(0, 0)


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_HighJump":
		highJump()
	if id == "skill_DragonBlood" :
		geirskogul()


func highJump():
	var chas = getAllChas(1)
	var cha
	if chas.size() > 0:
	 cha = chas[0]
	else:
		return
	chas.sort_custom(Utils.Calculation, "sort_MinHp")
	if cha != null:
		aiOn = false
		normalSpr.position = Vector2(0, -800)
		Utils.draw_shadow(img, position, position + Vector2(0, -150), 40)
		yield(reTimer(0.2), "timeout")

		var x = cha.position.x
		var y = cha.position.y
		var deviation = Vector2(x, y) - position

		Utils.draw_shadow(img, Vector2(x, y - 400), Vector2(x, y), 40)
		Utils.draw_effect("slashBlue", cha.position, Vector2(0, -30), 14, 2)
		FFHurtChara(cha, att.atk * HIGHJUMP_PW, PHY, SKILL)

		Utils.draw_shadow(img, Vector2(x, y), Vector2(x, y) + Vector2(0, -150) - (75 * deviation.normalized()), 40)
		yield(reTimer(0.3), "timeout")
		Utils.draw_shadow(img,  position + Vector2(0, -150), position, 40)
		normalSpr.position = Vector2(0, 0)
		aiOn = true


func geirskogul():
	if aiCha != null:
		var eff:Eff = newEff("sk_jiGuan", sprcPos)
		eff.sprLookAt(aiCha.global_position)
		var chas = Utils.lineChas(cell, aiCha.cell, 4)
		for cha in chas:
			if cha.team != team :
				FFHurtChara(cha, att.atk * GEIRSKOGUL_PW, PHY, SKILL)
