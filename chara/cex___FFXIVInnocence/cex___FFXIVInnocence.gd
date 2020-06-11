extends "../cex___FFXIVBossChara/cex___FFXIVBossChara.gd"
const BERSERKERTIME = 180 # 狂暴时间

const SKILL_TXT = """[夺影]：对全屏的敌人造成[未知]的魔法伤害。
[断罪飞翔]：随机两条竖线或横线进行飞剑攻击，造成[未知]的魔法伤害，并附加一层易伤(受伤加重30%)。
[裁决之雷]：死刑！！对当前目标释放大伤害攻击，造成[未知]的魔法伤害，并附加大易伤(平A致命)。
[转阶段·回转火焰剑]：全屏攻击，造成[未知]的魔法伤害
[富荣直观]：移动至场边，向对面进行冲刺，造成[未知]的物理伤害，距离越近的目标受伤越高。"""

func _extInit():
	._extInit()
	chaName = "全能神 无瑕灵君"
	lv = 4
	addSkillTxt(SKILL_TXT)
	addSkillTxt("""[创星]：战斗时间超过 %d秒后，狂暴灭团。
[完美]：该单位免疫[烧灼][失明][结霜]""" % [BERSERKERTIME])

var righteousBolt_pw = 4 # 裁决之雷威力
var wingedReprobation_pw = 0.75 # 断罪飞翔威力
var shadowReaver_pw = 1 # 夺影威力
var flammingSword_pw = 1 # 转阶段·回转火焰剑
var beatficVision_pw = 2 # 富荣直观

func _init():
	var SkillAxis = {
		"righteousBolt": [20, 50, 120, 150],
		"wingedReprobation": [15, 30, 45, 60, 75, 95, 110, 125, 140, 155, 170],
		"shadowReaver": [5, 90, 105, 165],
		"flammingSword": [80],
		"beatficVision": [115, 130, 145]
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
	skillStrs[1] = """[夺影]：对全屏的敌人造成[%d%%]的魔法伤害。
[断罪飞翔]：随机两条竖线或横线进行飞剑攻击，造成[%d%%]的魔法伤害，并附加一层易伤(受伤加重30%%)。
[裁决之雷]：死刑，对当前目标释放大伤害攻击，造成[%d%%]的魔法伤害，并附加大易伤(平A致命)。
[转阶段·回转火焰剑]：全屏攻击，造成[%d%%]的魔法伤害
[富荣直观]：移动至场边，向对面进行冲刺，造成[%d%%]的物理伤害，距离越近的目标受伤越高。
""" % [shadowReaver_pw * 100, wingedReprobation_pw * 100, righteousBolt_pw * 100, flammingSword_pw * 100, beatficVision_pw * 100]
	upAtt()

func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = SKILL_TXT
	righteousBolt_pw = 4 # 裁决之雷威力
	wingedReprobation_pw = 0.75 # 断罪飞翔威力
	shadowReaver_pw = 1 # 夺影威力
	flammingSword_pw = 1 # 转阶段·回转火焰剑
	beatficVision_pw = 2 # 富荣直观

func _onAddBuff(buff:Buff):
	if buff.id == "b_shaoZhuo":
			buff.isDel = true

	if buff.id == "b_shiMing":
		buff.isDel = true

	if buff.id == "b_jieShuang":
		buff.isDel = true

func righteousBolt():
	var ai = aiCha
	yield(reTimer(5), "timeout")
	Utils.createEffect("shiwan", ai.position, Vector2(0, -30), 15, 4)
	hurtChara(ai, att.mgiAtk * righteousBolt_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	ai.addBuff(b_VulnerableLarge.new(20))

func wingedReprobation():
	var type = sys.rndRan(0, 1)
	if type == 0:
		var vertical = [0, 1, 2, 3, 4, 5, 6, 7]
		vertical.shuffle()
		var x1 = vertical.pop_front()
		var x2 = vertical.pop_back()
		
		Utils.createEffect("danger", Vector2(x1 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
		Utils.createEffect("danger", Vector2(x2 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
		Utils.createEffect("sword", Vector2(x1 * 100, 0), Vector2(50, 0), 1, 1, false, deg2rad(90))
		Utils.createEffect("sword", Vector2(x2 * 100, 0), Vector2(50, 0), 1, 1, false, deg2rad(90))
		yield(reTimer(4), "timeout")
		var eff1 = Utils.createEffect("sword", Vector2(x1 * 100, 0), Vector2(0, -50), 0)
		eff1._initFlyPos(Vector2(x1 * 100, 500), 1600)
		var eff2 = Utils.createEffect("sword", Vector2(x2 * 100, 0), Vector2(0, -50), 0)
		eff2._initFlyPos(Vector2(x2 * 100, 500), 1600) 

	elif type == 1:
		var transverse = [0, 1, 2, 3, 4]
		transverse.shuffle()
		var y1 = transverse.pop_front()
		var y2 = transverse.pop_back()
		
		Utils.createEffect("danger", Vector2(-1, y1 * 100), Vector2(-350, -50), 2, 1, false)
		Utils.createEffect("danger", Vector2(-1, y2 * 100), Vector2(-350, -50), 2, 1, false)
		Utils.createEffect("sword", Vector2(0, y1 * 100), Vector2(0, -50), 1, 1, false)
		Utils.createEffect("sword", Vector2(0, y2 * 100), Vector2(0, -50), 1, 1, false)
		yield(reTimer(4), "timeout")
		var eff1 = Utils.createEffect("sword", Vector2(0, y1 * 100), Vector2(0, -50), 0)
		eff1._initFlyPos(Vector2(800, y1 * 100) , 1600) 
		var eff2 = Utils.createEffect("sword", Vector2(0, y2 * 100), Vector2(0, -50), 0)
		eff2._initFlyPos(Vector2(800, y2 * 100) , 1600) 

func shadowReaver():
	var chas = getAllChas(1)
	Utils.createEffect("energyStorage", Vector2(350, 0), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("energyStorage", Vector2(150, 150), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("energyStorage", Vector2(500, 200), Vector2(0, 0), 13, 6)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * shadowReaver_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func flammingSword():
	print("回转火焰剑！", battleDuration)
	pass

func beatficVision():
	print("富荣直观！", battleDuration)
	pass

func _upS():
	._upS()
	if battleDuration > BERSERKERTIME:
		shadowReaver()

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
		life = clamp(life, 0, 20)

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
			atkInfo.hurtVal *= 9999

	func _upS():
		life = clamp(life, 0, 20)