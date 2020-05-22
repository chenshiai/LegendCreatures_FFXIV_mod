extends Chara
func _info():
	pass

func _extInit():
	._extInit()
	chaName = "龙骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3.3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	lv = 2
	evos = ["cFFXIVSpirit_3_1"]
	atkEff = "atk_dao"
	addCdSkill("skill_DragonBlood", 10)
	addSkillTxt("""[跳跃]：战斗开始时，快速跳到敌方中场
[苍天龙血]：冷却时间10s，获得5层狂怒，并使用一次[武神枪]
[武神枪]：对直线上的敌人造成[360%]的物理伤害""")

const DRAGONBLOOD_PW = 3.60 # 武神枪威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	addBuff(b_kuangNu.new(10))

	yield(reTimer(0.1), "timeout")
	var mv = Vector2(cell.x, cell.y)
	if team == 1: mv.x = 6
	else: mv.x = 1
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)]
	for i in vs:
		var v = mv + i
		if matCha(v) == null && sys.main.isMatin(v):
			if setCell(v) :
				var pos = sys.main.map.map_to_world(cell)
				ying(pos)
				position = pos
				aiCha = null
				break

func ying(pos):
	var l:Vector2 = pos - position
	var s = 25
	var rs = preload("res://core/ying.tscn")
	var n = l.length()/s
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = img.texture_normal
		spr.position = position + s * (i+1) * l.normalized() - Vector2(img.texture_normal.get_width() / 2, img.texture_normal.get_height())
		spr.init(255/n * i + 100)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DragonBlood" :
		addBuff(b_kuangNu.new(5))
		var eff:Eff = newEff("sk_jiGuan", sprcPos)
		eff.sprLookAt(aiCha.global_position)
		var chas = lineChas(cell, aiCha.cell, 4)
		for cha in chas:
			if cha.team != team :
				hurtChara(cha, att.atk * DRAGONBLOOD_PW, Chara.HurtType.PHY, Chara.AtkType.SKILL)

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
