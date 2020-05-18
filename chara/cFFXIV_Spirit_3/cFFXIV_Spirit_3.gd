extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "龙骑士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_DragonBlood", 10)#添加cd技能
	addSkillTxt("""[跳跃]：战斗开始时，快速跳到敌方中场
[苍天龙血]：复唱时间10s，获得5层狂怒，并使用一次[武神枪]
[武神枪]：对直线上的敌人造成物理伤害，威力：360""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	yield(reTimer(0.4),"timeout")
	addBuff(b_kuangNu.new(10))
	var mv = Vector2(cell.x, cell.y)
	if team == 1:mv.x = 6
	else:mv.x = 1
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)]
	for i in vs:
		var v = mv+i
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
				hurtChara(cha, att.atk * 3.60, HurtType.PHY)

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