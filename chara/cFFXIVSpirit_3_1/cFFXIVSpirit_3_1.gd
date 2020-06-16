extends "../cFFXIVSpirit_3/cFFXIVSpirit_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "红血之龙"
	lv = 3
	evos = []
	attAdd.atkL += 0.15
	addCdSkill("skill_Stardiver", 27)
	addSkillTxt(TEXT.format("[坠星冲]：冷却27s，高高跃起，向随机一名敌人猛冲，对落点周围2格的敌人造成[700%]的{TPhyHurt}"))

const STARDIVER_PW = 7.3 # 坠星冲倍率

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Stardiver":
		stardiver()

func stardiver():
	aiOn = false
	normalSpr.position = Vector2(0, -10)
	yield(reTimer(0.2), "timeout")

	normalSpr.position = Vector2(0, -450)
	Utils.createShadow(img, Vector2(0, 0), normalSpr.position, 40)
	yield(reTimer(0.4), "timeout")

	var cha = rndChas(getAllChas(1), 1)
	var mv = Vector2(cell.x, cell.y)
	mv.x = cha.cell.x
	mv.y = cha.cell.y
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)]
	for i in vs:
		var v = mv + i
		if matCha(v) == null and sys.main.isMatin(v):
			if setCell(v) :
				var pos = sys.main.map.map_to_world(cell)
				position = pos
				break

	var eff:Eff = newEff("sk_yunShi")
	eff.position = self.position
	eff.scale *= 2
	yield(reTimer(0.3), "timeout")

	aiOn = true
	normalSpr.position = Vector2(0, 0)
	var chas = getCellChas(cell, 2)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atk * STARDIVER_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)