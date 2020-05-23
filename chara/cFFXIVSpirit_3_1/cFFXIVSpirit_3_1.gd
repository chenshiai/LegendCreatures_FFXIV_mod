extends "../cFFXIVSpirit_3/cFFXIVSpirit_3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "红血之龙"
	lv = 3
	evos = []
	attAdd.atkR += 0.15
	addCdSkill("skill_Stardiver", 25)
	addSkillTxt("[红莲龙血]：被动，获得15%的攻击力加成")
	addSkillTxt("[坠星冲]：冷却时间25s，高高跃起，向随机一名敌人猛冲，对落点周围2格的敌人造成[600%]的物理伤害")

const STARDIVER_PW = 6 # 坠星冲倍率

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()
	normalSpr.position = Vector2(0, 0)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Stardiver": stardiver()

func stardiver():
	aiCha = null
	normalSpr.position = Vector2(0, -10)
	yield(reTimer(0.2), "timeout")

	normalSpr.position = Vector2(0, -450)
	jump(Vector2(0, 0), normalSpr.position)
	yield(reTimer(0.4), "timeout")

	var allChas = getAllChas(1)
	allChas.shuffle()
	var mv = Vector2(cell.x, cell.y)
	mv.x = allChas[0].cell.x
	mv.y = allChas[0].cell.y
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)]
	for i in vs:
		var v = mv + i
		if matCha(v) == null && sys.main.isMatin(v):
			if setCell(v) :
				var pos = sys.main.map.map_to_world(cell)
				position = pos
				break

	var eff:Eff = newEff("sk_yunShi")
	eff.position = self.position
	eff.scale *= 2
	yield(reTimer(0.3), "timeout")

	normalSpr.position = Vector2(0, 0)
	var chas = getCellChas(cell, 2)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atk * STARDIVER_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

func jump(startPositon, endPositon):
	var l:Vector2 = endPositon - startPositon
	var s = 25
	var rs = preload("res://core/ying.tscn")
	var n = l.length()/s
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = img.texture_normal
		spr.position = position + s * (i+1) * l.normalized() - Vector2(img.texture_normal.get_width() / 2, img.texture_normal.get_height())
		spr.init(255/n * i + 100)