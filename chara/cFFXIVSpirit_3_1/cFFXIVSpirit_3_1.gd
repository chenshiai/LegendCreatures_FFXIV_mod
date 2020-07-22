extends "../cFFXIVSpirit_3/cFFXIVSpirit_3.gd"

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	attAdd.atkL += 0.15
	addCdSkill("skill_Stardiver", 27)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))

const STARDIVER_PW = 7.3 # 坠星冲倍率

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	battleLitany()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Stardiver":
		stardiver()

func stardiver():
	aiOn = false
	normalSpr.position = Vector2(0, -450)
	Utils.draw_shadow(img, position, position + Vector2(0, -450), 40)
	yield(reTimer(0.2), "timeout")

	var cha = rndChas(getAllChas(1), 1)
	if cha == null or cha.isDeath:
		normalSpr.position = Vector2(0, 0)
		return
	aiCha = cha
	var mv = Vector2(cell.x, cell.y)
	mv.x = cha.cell.x
	mv.y = cha.cell.y
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0),
		Vector2(0, 1), Vector2(0, -1), Vector2(1, 1),
		Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)
	]
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
		FFHurtChara(i, att.atk * STARDIVER_PW, PHY, SKILL)

func battleLitany():
	var ailys = getAllChas(2)
	for cha in ailys:
		if cha != null:
			BUFF_LIST.b_Litany.new({"cha": cha})