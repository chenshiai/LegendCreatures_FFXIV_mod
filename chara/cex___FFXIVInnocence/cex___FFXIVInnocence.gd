extends "../cex___FFXIVBossChara/cex___FFXIVBossChara.gd"
const BERSERKERTIME = 190 # 狂暴时间
var SKILL_TXT = TEXT.format("""[夺影]：对全屏的敌人造成[未知]的{TMgiHurt}。
[断罪飞翔]：随机两条竖线或横线进行飞剑攻击，造成[未知]的{TMgiHurt}，并附加一层易伤(受伤加重30%)。
[裁决之雷]：死刑！！对当前目标释放大伤害攻击，造成[未知]的{TMgiHurt}，并附加大易伤(平A致命)。
[转阶段·回转火焰剑]：全屏攻击，造成[未知]的{TPhyHurt}
[荣福直观]：移动至场边，向对面进行冲刺，造成[未知]的{TPhyHurt}，距离中线越近的目标受伤越高。""")

func _extInit():
	._extInit()
	chaName = "无瑕灵君"
	lv = 4
	addSkillTxt(SKILL_TXT)
	addSkillTxt("""[创星]：战斗时间超过 %d秒后，狂暴灭团。
[完美]：该单位免疫[烧灼][失明][结霜]""" % [BERSERKERTIME])
	addSkillTxt(TEXT.BOSS_INNOCENCE)

var righteousBolt_pw = 4 # 裁决之雷威力
var wingedReprobation_pw = 1.2 # 断罪飞翔威力
var shadowReaver_pw = 1 # 夺影威力
var flammingSword_pw = 1 # 转阶段·回转火焰剑
var beatficVision_pw = 2 # 荣福直观
var deviation = Vector2(0, 0)

func _init():
	var SkillAxis = {
		"righteousBolt": [20, 60, 120, 160],
		"wingedReprobation": [10, 30, 50, 70, 90, 130, 170],
		"shadowReaver": [2, 35, 76, 115, 140],
		"flammingSword": [100],
		"beatficVision": [110, 150, 180]
	}
	call_deferred("setTimeAxis", SkillAxis)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	righteousBolt_pw *= (E_lv / E_num)
	wingedReprobation_pw *= (E_lv / E_num)
	shadowReaver_pw *= (E_lv / E_num)
	flammingSword_pw *= (E_lv / E_num)
	beatficVision_pw *= (E_lv / E_num)
	SKILL_TXT = TEXT.format("""[夺影]：对全屏的敌人造成[{0}]的{TMgiHurt}。
[断罪飞翔]：随机两条竖线或横线进行飞剑攻击，造成[{1}]的{TMgiHurt}，并附加一层易伤(受伤加重30%%)。
[裁决之雷]：死刑！！对当前目标释放大伤害攻击，造成[{2}]的{TMgiHurt}，并附加大易伤(平A致命)。
[转阶段·回转火焰剑]：全屏攻击，造成[{3}]的{TPhyHurt}
[荣福直观]：移动至场边，向对面进行冲刺，造成[{4}]的{TPhyHurt}，距离中线越近的目标受伤越高。""",
		{
			"0": "%d%%" % [shadowReaver_pw * 100],
			"1": "%d%%" % [wingedReprobation_pw * 100],
			"2": "%d%%" % [righteousBolt_pw * 100],
			"3": "%d%%" % [flammingSword_pw * 100],
			"4": "%d%%" % [beatficVision_pw * 100]
		})
	skillStrs[1] = SKILL_TXT
	upAtt()

func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = SKILL_TXT
	righteousBolt_pw = 4 # 裁决之雷威力
	wingedReprobation_pw = 0.75 # 断罪飞翔威力
	shadowReaver_pw = 1 # 夺影威力
	flammingSword_pw = 1.5 # 转阶段·回转火焰剑 威力
	beatficVision_pw = 0.5# 荣福直观威力

func _onAddBuff(buff:Buff):
	if buff.id == "b_shaoZhuo":
			buff.isDel = true

	if buff.id == "b_shiMing":
		buff.isDel = true

	if buff.id == "b_jieShuang":
		buff.isDel = true

# 裁决之雷
func righteousBolt():
	self.HateTarget = aiCha
	self.aiOn = false
	Chant.chantStart("裁决之雷", 5)
	yield(reTimer(5), "timeout")
	if att.hp <=0:
		return
	if self.HateTarget != null:
		Utils.createEffect("thunder", self.HateTarget.position, Vector2(0, -140), 15, 1)
		hurtChara(self.HateTarget, att.mgiAtk * righteousBolt_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		self.HateTarget.addBuff(b_VulnerableLarge.new(15))
	self.aiOn = true

# 断罪飞翔
func wingedReprobation():
	Chant.chantStart("断罪飞翔", 4)
	var type = sys.rndRan(0, 1)
	var chas1
	var chas2

	if type == 0:
		var vertical = [0, 1, 2, 3, 4, 5, 6, 7]
		vertical.shuffle()
		var x1 = vertical.pop_front()
		var x2 = vertical.pop_back()
		
		Utils.createEffect("danger", Vector2(x1 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
		Utils.createEffect("danger", Vector2(x2 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
		yield(reTimer(4), "timeout")

		var eff1 = Utils.createEffect("sword", Vector2(x1 * 100, 0), Vector2(0, -50), 0)
		eff1._initFlyPos(Vector2(x1 * 100, 500), 1600)
		var eff2 = Utils.createEffect("sword", Vector2(x2 * 100, 0), Vector2(0, -50), 0)
		eff2._initFlyPos(Vector2(x2 * 100, 500), 1600)

		chas1 = Utils.lineChas( Vector2(x1, 0), Vector2(x1, 5), 5)
		chas2 = Utils.lineChas( Vector2(x2, 0), Vector2(x2, 5), 5)

	elif type == 1:
		var transverse = [0, 1, 2, 3, 4]
		transverse.shuffle()
		var y1 = transverse.pop_front()
		var y2 = transverse.pop_back()
		
		Utils.createEffect("danger", Vector2(-1, y1 * 100), Vector2(-350, -50), 2, 1, false)
		Utils.createEffect("danger", Vector2(-1, y2 * 100), Vector2(-350, -50), 2, 1, false)
		yield(reTimer(4), "timeout")

		var eff1 = Utils.createEffect("sword", Vector2(0, y1 * 100), Vector2(0, -50), 0)
		eff1._initFlyPos(Vector2(800, y1 * 100) , 1600) 
		var eff2 = Utils.createEffect("sword", Vector2(0, y2 * 100), Vector2(0, -50), 0)
		eff2._initFlyPos(Vector2(800, y2 * 100) , 1600)
		
		chas1 = Utils.lineChas(Vector2(0, y1), Vector2(8, y1), 9)
		chas2 = Utils.lineChas(Vector2(0, y2), Vector2(8, y2), 9)
	
	if att.hp <=0:
		return
	for cha in chas1:
		if cha.team != team :
			hurtChara(cha, att.mgiAtk * wingedReprobation_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			addBuff(b_VulnerableSmall.new(15))

	for cha in chas2:
		if cha.team != team :
			hurtChara(cha, att.mgiAtk * wingedReprobation_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			addBuff(b_VulnerableSmall.new(15))

# 夺影
func shadowReaver():
	Chant.chantStart("夺影", 3)
	yield(reTimer(3), "timeout")
	if att.hp <= 0:
		return
	var chas = getAllChas(1)
	Utils.createEffect("energyStorage", Vector2(350, 0), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("energyStorage", Vector2(150, 150), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("energyStorage", Vector2(500, 200), Vector2(0, 0), 13, 6)

	if att.hp <=0:
		return
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * flammingSword_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 回转火焰剑
func flammingSword():
	self.isDeath = true
	self.aiOn = false
	leftOrRight()
	yield(reTimer(0.5), "timeout")
	Utils.createShadow(img,  position + Vector2(0, -250), position, 40)
	normalSpr.position = Vector2(0, 0)

	Chant.chantStart("回转火焰剑！", 5)
	yield(reTimer(1), "timeout")
	Utils.createEffect("flammingSword", Vector2(350, 150), Vector2(0, 0), 12, 4)
	yield(reTimer(0.5), "timeout")
	Utils.createEffect("flammingSword", Vector2(350, 125), Vector2(0, 0), 14, 3)
	yield(reTimer(0.5), "timeout")
	Utils.createEffect("flammingSword", Vector2(350, 100), Vector2(0, 0), 16, 2)

	var eff = Utils.createEffect("light2", Vector2(350, 150), Vector2(0, 0), 0, 4)
	yield(reTimer(3), "timeout")

	if att.hp <= 0:
		return
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.atk * flammingSword_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

	Utils.createEffect("beatficVision", Vector2(350, 200), Vector2(0, -30), 10, 4)
	eff.queue_free()
	yield(reTimer(2), "timeout")
	self.aiOn = true
	self.isDeath = false

# 荣福直观
func beatficVision():
	self.isDeath = true
	self.aiOn = false
	leftOrRight()

	yield(reTimer(0.5), "timeout")
	Utils.createShadow(img,  position + Vector2(0, -250), position, 40)
	var eff = Utils.createEffect("light1", Vector2(position.x, position.y - 1), Vector2(0, -20), 0, 6)
	normalSpr.position = Vector2(0, 0)

	Chant.chantStart("荣福直观", 3)
	yield(reTimer(3), "timeout")
	eff.queue_free()
	normalSpr.position = deviation
	Utils.createShadow(img,  position, position + deviation, 40)
	beatficVisionDamage()
	Utils.createEffect("beatficVision", Vector2(350, 200), Vector2(0, -30), 10, 4)

	yield(reTimer(2), "timeout")
	Utils.createShadow(img, position + Vector2(0, -250), position, 40)
	normalSpr.position = Vector2(0, 0)

	yield(reTimer(1), "timeout")
	self.aiOn = true
	self.isDeath = false

func beatficVisionDamage():
	if att.hp <= 0:
		return
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			var y = i.cell.y - 2
			var pw = 3.50 - (0.625 * y * y + 0.50)
			hurtChara(i, att.atk * beatficVision_pw * pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

func leftOrRight():
	normalSpr.position = Vector2(0, -800)
	Utils.createShadow(img, position, position + Vector2(0, -250), 40)

	if matCha(Vector2(7, 2)) == null:
		setCell(Vector2(7, 2))
		position = sys.main.map.map_to_world(Vector2(7, 2))
		deviation = Vector2(-1200, 0)
	else:
		setCell(Vector2(0, 2))
		position = sys.main.map.map_to_world(Vector2(0, 2))
		deviation = Vector2(1200, 0)

func _upS():
	._upS()
	if battleDuration > BERSERKERTIME and (battleDuration % 5 == 0):
		shadowReaver()
		shadowReaver_pw += 20

class b_VulnerableSmall:
	extends Buff
	func _init(dur = 1):
		attInit()
		life = dur
		isNegetive = false
		id = "b_VulnerableSmall"
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo):
		atkInfo.hurtVal *= 1.3

	func _upS():
		life = clamp(life, 0, 15)

class b_VulnerableLarge:
	extends Buff
	func _init(dur = 1):
		attInit()
		life = dur
		isNegetive = false
		id = "b_VulnerableLarge"
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			atkInfo.hurtVal *= 99

	func _upS():
		life = clamp(life, 0, 15)