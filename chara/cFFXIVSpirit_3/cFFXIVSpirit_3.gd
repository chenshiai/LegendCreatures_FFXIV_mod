extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "龙骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	lv = 2
	evos = ["cFFXIVSpirit_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_HighJump", 13)
	addCdSkill("skill_DragonBlood", 15)
	addSkillTxt("""[高跳]：冷却13s，跳起接近目标并攻击,造成[300%]的物理伤害(优先生命值最低的单位，开战使用一次)。攻击后回到原位。
[苍天龙血]：被动，[高跳]以及[坠星冲]的威力提高[30%]
[武神枪]：冷却15s，对直线上的敌人造成[400%]的物理伤害""")

const HIGHJUMP_PW = 3.30 # 高跳威力
const GEIRSKOGUL_PW = 4.00 # 武神枪威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	call_deferred("highJump")

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_HighJump":
		highJump()
	if id == "skill_DragonBlood" :
		geirskogul()


func highJump():
	var chas = getAllChas(1)
	chas.sort_custom(Utils.Calculation, "sort_MinHp")
	var cha = chas[0]
	if cha != null:
		aiOn = false
		normalSpr.position = Vector2(0, -800)
		Utils.createShadow(img, position, position + Vector2(0, -150), 40)
		yield(reTimer(0.2), "timeout")

		var x = cha.position.x
		var y = cha.position.y
		var deviation = Vector2(x, y) - position

		Utils.createShadow(img, Vector2(x, y - 400), Vector2(x, y), 40)
		Utils.createEffect("slashBlue", cha.position, Vector2(0, -30), 14, 2)
		if cha != null:
			hurtChara(cha, att.atk * HIGHJUMP_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

		Utils.createShadow(img, Vector2(x, y), Vector2(x, y) + Vector2(0, -150) - (75 * deviation.normalized()), 40)
		yield(reTimer(0.3), "timeout")
		Utils.createShadow(img,  position + Vector2(0, -150), position, 40)
		normalSpr.position = Vector2(0, 0)
		aiOn = true

func geirskogul():
	if aiCha != null:
		var eff:Eff = newEff("sk_jiGuan", sprcPos)
		eff.sprLookAt(aiCha.global_position)
		var chas = lineChas(cell, aiCha.cell, 4)
		for cha in chas:
			if cha.team != team :
				hurtChara(cha, att.atk * GEIRSKOGUL_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

func lineChas(aCell, bCell, num):
	var chas = []
	var aPos = sys.main.map.map_to_world(aCell)
	var bPos = sys.main.map.map_to_world(bCell)
	var n = (bPos - aPos).normalized()
	var oldCell = null
	for i in range(num):
		aPos += n * 100
		var ac = sys.main.map.world_to_map(aPos)
		if oldCell != ac :
			oldCell = ac
			if matCha(ac) != null:
				chas.append(matCha(ac))
	return chas
