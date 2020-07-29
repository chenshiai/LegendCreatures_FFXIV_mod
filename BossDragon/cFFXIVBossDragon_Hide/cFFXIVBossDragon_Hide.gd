extends "../../2098858773/BossChara.gd"

const BERSERKERTIME_P1 = 180 # P1狂暴时间
const BERSERKERTIME_P3 = 400 # P3狂暴时间

var P2summonCount = 3 # p2的小龙召唤次数
var P2summonLive = 15 # p2小龙存活数
var reincarnation_pw = 4 # 死亡轮回威力
var blowingSnow_pw = 0.75 # 吹雪威力
var lightning_pw = 1 # 闪电威力
var supernova_pw = 1 # 超新星威力
var icicles_pw = 1 # 冰柱威力
var protostar_pw = 0 # 原恒星威力
var trillionChop_pw = 3 # 万亿斩击威力

var SKILL_TXT = """{c_base}
神龙的普通攻击是由两边翅膀发射的飞弹攻击。

第一阶段：
[大地之怒]：开战时使用且只使用一次。神龙的威严不可触犯，对所有敌人造成{c_mgi}最大生命值[150%]{/c}的魔法伤害。
[死亡轮回]：{TDeath}对当前仇恨目标连续造成四次{c_mgi}[{1}]{/c}的范围魔法伤害，可多人分摊伤害。
[吹雪]：对所有敌人造成{c_mgi}[{2}]{/c}的魔法伤害，会在场地上留下水坑，水坑中的角色会获得[雷耐性下降·大][火耐性上升·大]。
[闪电]：对所有敌人释放闪电，造成{c_mgi}[{3}]{/c}的小范围雷属性魔法伤害。
[超新星]：对所有敌人释放火炎攻击，造成{c_mgi}[{4}]{/c}的火属性魔法伤害。
[召唤冰柱]：场地随机一边出现两根冰柱，对直线上的敌人造成{c_mgi}[{5}]{/c}的魔法伤害，并附加[易伤]。

第二阶段：
[召唤小龙]：在场地上召唤4只小龙，1只大龙。
[原恒星]：对所有敌人造成魔法伤害，该技能伤害根据读条进度正比提升。

第三阶段：
[万亿斩击]：{TDeath}对当前仇恨目标造成{c_phy}[{6}]{/c}的物理伤害，并附加[物理耐性下降·大]
{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知",
	"5": "未知",
	"6": "未知",
}

# 场地水坑区域以及特效
var mapEffect = {
	"puddle": null,
	"area": [
		Vector2(2, 1), Vector2(3, 1), Vector2(4, 1), Vector2(5, 1),
		Vector2(2, 2), Vector2(3, 2), Vector2(4, 2), Vector2(5, 2),
		Vector2(2, 3), Vector2(3, 3), Vector2(4, 3), Vector2(5, 3),
	]
}

func _extInit():
	._extInit()
	chaName = "神龙"
	lv = 4
	moveSpeed = 0
	attCoe.atkRan = 0
	addCdSkill("skill_attack", 3)
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(TEXT.BOSS_DRAGON)


# 必要的初始化
func _init():
	._init()
	set_path("cFFXIVBossDragon_Hide")
	set_time_axis({
		"blowingSnow": [20, 60, 100, 140, 340],
		"icicles": [26, 66, 106, 146],
		"leftOrRigth": [33, 73, 113, 153, 360],
		"reincarnation": [45, 85, 125, 165],
		"P2summon": [206],
		"protostar": [280],
		"uptial": [306, 308, 310, 312, 314, 316, 318],
		"P3Start": [322],
		"trillionChop": [330, 350, 370],
		"tsunami": [400]
	})
	Utils.background_change(Path, "/background/CrystallizationSpace.png")
	FFControl.FFMusic.play(Path, "/music/DragonFantasy1.ogg.oggstr")


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_attack":
		if STAGE == "p1":
			var count = 0
			for cha in Retreat.PlayerChas:
				if !cha.isDeath:
					count += 1
					attack(cha, count)
				if count == 2:
					return
		if STAGE == "p3":
			attack(aiCha, 1)
			attack(aiCha, 2)


func _onBattleStart():
	._onBattleStart()
	aiOn = false
	STAGE = "p1"
	aiCha = Retreat.PlayerChas[0]
	sprcPos = Vector2(-50, -30)
	for cha in sys.main.btChas:
		if cha.team == 1:
			cha.addBuff(b_longAtk.new())

	reincarnation_pw *= (E_lv / E_num) # 死亡轮回威力
	blowingSnow_pw *= (E_lv / E_num) # 吹雪威力
	lightning_pw *= (E_lv / E_num) # 闪电威力
	supernova_pw *= (E_lv / E_num) # 超新星威力
	icicles_pw *= (E_lv / E_num) # 冰柱威力
	trillionChop_pw *= (E_lv / E_num) # 万亿斩击

	pwConfig = {
		"1": "%d%%" % [reincarnation_pw * 100],
		"2": "%d%%" % [blowingSnow_pw * 100],
		"3": "%d%%" % [lightning_pw * 100],
		"4": "%d%%" % [supernova_pw * 100],
		"5": "%d%%" % [icicles_pw * 100],
		"6": "%d%%" % [trillionChop_pw * 100],
	}

	skillStrs[0] = (TEXT.format(SKILL_TXT, pwConfig))

	# 开场直接转p2 测试用
	# changeStage("p2")
	if STAGE == "p1":		
		wrathOfTheEarth()


func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = TEXT.format(SKILL_TXT, pwConfig)


func _onAddBuff(buff:Buff):
	if buff.id == "b_shaoZhuo":
			buff.isDel = true

	if buff.id == "b_jieShuang":
		buff.isDel = true


func _onHurt(atkInfo):
	._onHurt(atkInfo)
	# P1时当生命值低于44%时转P2
	if STAGE == "p1" and att.hp <= att.maxHp * 0.44:
		changeStage("p2")

	# P2阶段，不会受伤
	if STAGE == "p2":
		atkInfo.hurtVal = 0

func _onCharaDel(cha):
	._onCharaDel(cha)
	# 当白金龙死亡时，再次召唤一波小怪，三波小怪全死后打断原恒星读条
	if cha.id == "cFFXIV_Dragon_entourage_large":
		P2summonLive -= 1
		print("神龙眷属剩余：%d" % [P2summonLive])
		if P2summonCount > 0:
			P2summon()

	if cha.id == "cFFXIV_Dragon_entourage_small":
		P2summonLive -= 1
		print("神龙眷属剩余：%d" % [P2summonLive])

	if cha.team != 1 and cha != self and P2summonCount == 0 and P2summonLive <= 0:
		P2summonCount = 0
		P2SummonEnd()

# 死亡时，如果有水坑特效就释放
func _onDeath(atkInfo):
	._onDeath(atkInfo)
	queue_free_eff()

# 转阶段控制
func changeStage(p):
	STAGE = p
	queue_free_eff()

	# p2转场
	if STAGE == "p2":
		normalSpr.position = Vector2(0, -400)
		self.visible = false
		Utils.draw_shadow(img,  position, position + Vector2(0, -300), 25)
		battleDuration = 180
		FFControl.hiddenControl()
		BUFF_LIST.b_FrozenCdSkill.new({"cha": self, "dur": 26})

		for cha in sys.main.btChas:
			if cha.team == 1:
				BUFF_LIST.b_FrozenCdSkill.new({"cha": cha, "dur": 26})
				BUFF_LIST.b_StaticTimeUnlock.new({"cha": cha, "dur": 26})

		FFControl.FFMusic.dbDown(20)

		yield(reTimer(2), "timeout")
		FFControl.FFMusic.play(Path, "/music/DragonFantasy2.ogg.oggstr")
		FFControl.FFMusic.dbUp(20)

		yield(reTimer(3), "timeout")
		Utils.background_change(Path, "/background/CrystallizationSpace2.png")
		Utils.draw_shadow(img, Vector2(400, 600), Vector2(400, 0), 25)
		
		for cha in sys.main.btChas:
			if cha != null and !cha.isDeath and cha != self:
				BUFF_LIST.RotateCha.new({"cha": cha, "dur": 19.2})
				
		yield(reTimer(18), "timeout")
		Utils.draw_shadow(img, Vector2(400, 600), Vector2(400, 0), 25)
		Utils.background_change(Path, "/background/CrystallizationSpace3.png")
		FFControl.showControl()
		Chant.chantStart("原恒星", 75)

	if STAGE == "p3":
		setCell(Vector2(4, 0))
		position = sys.main.map.map_to_world(Vector2(4, 0))
		normalSpr.position = Vector2(0, 0)


# 召唤小龙
func P2summon():
	summonDragon(Vector2(0, 0), 5)
	summonDragon(Vector2(7, 0), 5)
	summonDragon(Vector2(0, 4), 5)
	summonDragon(Vector2(3, 2), 5, true)
	summonDragon(Vector2(7, 4), 5)
	P2summonCount -= 1

# 距离衰减AOE以及召唤的实现
func summonDragon(cell, time, large = false):
	var position = cell * 100
	self.addBuff(attenuation.new(position, time))
	yield(reTimer(time), "timeout")
	if att.hp <= 0:
		return

	var eff2:Eff = newEff("sk_yunShi")
	eff2.position = position
	eff2.scale *= 4

	for cha in getAllChas(1):
		if cellRan(cell, cha.cell) < 4:
			var damage = Utils.attenuationDamage(cell, cha.cell, att.atk * 3)
			FFHurtChara(cha, damage, Chara.HurtType.PHY, Chara.AtkType.SKILL)

	yield(reTimer(0.5), "timeout")
	if large:
		if !newChara("cFFXIV_Dragon_entourage_large", cell):
			P2summonLive -= 1
	else:
		if !newChara("cFFXIV_Dragon_entourage_small", cell):
			P2summonLive -= 1
	
class attenuation extends Buff:
	var Utils = globalData.infoDs["g_aFFXIVUtils"]
	func _init(position, dur):
		life = dur
		eff = Utils.draw_effect("attenuation", position, Vector2(0, -12), 7, 4, true)
	func _del():
		eff.queue_free()

# 小龙击杀完毕，P2召唤结束
func P2SummonEnd():
	Chant.interrupt()
	battleDuration = 292

	var chas = getAllChas(1)
	for i in chas:
		BUFF_LIST.b_StaticTimeUnlock.new({"cha": i, "dur": 30})

	yield(reTimer(2), "timeout")
	protostar(false)
	yield(reTimer(4), "timeout")
	FFControl.FFMusic.dbDown(20)	
	yield(reTimer(2), "timeout")
	FFControl.FFMusic.seek(104)
	FFControl.FFMusic.dbUp(20)
	for i in chas:
		BUFF_LIST.b_FrozenCdSkill.new({"cha": i, "dur": 12})


# P3开始！
func P3Start():
	changeStage("p3")
	self.visible = true
	pass

func queue_free_eff():
	if mapEffect.puddle != null:
		mapEffect.puddle.queue_free()
		mapEffect.puddle = null

# 神龙的普攻
func attack(cha, count):
	var StartPoint = self.sprcPos
	if count == 1:
		StartPoint = Vector2(100, -50)
	elif count == 2:
		StartPoint = Vector2(600, -50)

	var d:Eff = newEff("sk_feiDang", cha.sprcPos)
	d.position = StartPoint
	d._initFlyCha(cha, 700)
	yield(d, "onReach")
	FFHurtChara(cha, cha.att.maxHp * 0.3, Chara.HurtType.PHY, Chara.AtkType.NORMAL)
	
# 大地之怒
func wrathOfTheEarth():
	Chant.chantStart("大地之怒", 6)
	yield(reTimer(6), "timeout")
	Utils.draw_effect("beatficVision", Vector2(350, 200), Vector2(0, -30), 10, 4)
	if att.hp <= 0:
		return
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			FFHurtChara(i, i.att.maxHp * 1.5, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 死亡轮回
func reincarnation():
	Chant.chantStart("死亡轮回", 5)
	BUFF_LIST.b_Share.new({"cha": aiCha, "dur": 5})
	yield(reTimer(5), "timeout")
	sharedamage()
	yield(reTimer(1), "timeout")
	sharedamage()
	yield(reTimer(1), "timeout")
	sharedamage()
	yield(reTimer(1), "timeout")
	sharedamage()

func sharedamage():
	if att.hp <= 0 and STAGE != "p1":
		return
	Utils.draw_effect("death", aiCha.position, Vector2(0, -130), 10, 2)
	var chas = getCellChas(aiCha.cell, 2, 1)
	for cha in chas:
		FFHurtChara(cha, att.mgiAtk * reincarnation_pw / chas.size(), Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 吹雪
func blowingSnow():
	Chant.chantStart("吹雪", 4)
	yield(reTimer(4), "timeout")

	var positionList = [Vector2(100, 200), Vector2(600, 200), Vector2(350, 250), Vector2(100, 400), Vector2(600, 400)]
	for pos in positionList:
		var eff:Eff = newEff("sk_bingYu")
		eff.scale *= 3
		eff.position = pos
		yield(reTimer(0.1), "timeout")

	if att.hp <= 0 or STAGE == "p2":
		return

	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			FFHurtChara(i, att.mgiAtk * blowingSnow_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	yield(reTimer(1), "timeout")
	if att.hp <= 0:
		return

	if mapEffect.puddle == null:
		mapEffect.puddle = Utils.draw_effect_out(Path + "/effects/puddle", Vector2(position.x, position.y), Vector2(25, 75), 13, 2, true)
		mapEffect.puddle.show_on_top = false
# 闪电/超新星
func leftOrRigth():
	var type = sys.rndRan(0, 1)
	var name = ["闪电", "超新星"]

	Chant.chantStart(name[type], 4)
	yield(reTimer(4), "timeout")

	queue_free_eff()

	if att.hp <= 0 or STAGE == "p2":
		return

	if type == 0:
		lightning()
	elif type == 1:
		supernova()

# 闪电
func lightning():
	var chas = getAllChas(1)
	for i in chas:
		Utils.draw_effect("ePrcC_30", i.position, Vector2(0, -50), 5)
		var cha = getCellChas(i.cell, 1)
		for j in cha:
			if j != self and mapEffect.area.has(j.cell):
				FFHurtChara(j, att.mgiAtk * lightning_pw * 2, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			else:
				FFHurtChara(j, att.mgiAtk * lightning_pw * 0.8, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 超新星
func supernova():
	var chas = getAllChas(1)
	for i in chas:
		Utils.draw_effect("light", i.position, Vector2(0, -50), 15)
		if i != self and mapEffect.area.has(i.cell):
			FFHurtChara(i, att.mgiAtk * supernova_pw * 0.8, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		else:
			FFHurtChara(i, att.mgiAtk * supernova_pw * 2, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 召唤冰柱
func icicles():
	Chant.chantStart("召唤冰柱", 4)
	var type = sys.rndRan(0, 1)
	var chas1
	var chas2
	var vertical = [1, 2]

	if type == 0:
		vertical = [1, 2]
	elif type == 1:
		vertical = [5, 6]

	var x1 = vertical[0]
	var x2 = vertical[1]
	
	Utils.draw_effect("danger", Vector2(x1 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
	Utils.draw_effect("danger", Vector2(x2 * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
	yield(reTimer(4), "timeout")
	if att.hp <= 0 or STAGE == "p2":
		return

	var eff1 = Utils.draw_effect("icicles", Vector2(x1 * 100, 400), Vector2(0, -50), 4)
	eff1._initFlyPos(Vector2(x1 * 100, 0), 1600)
	var eff2 = Utils.draw_effect("icicles", Vector2(x2 * 100, 400), Vector2(0, -50), 4)
	eff2._initFlyPos(Vector2(x2 * 100, 0), 1600)

	chas1 = Utils.lineChas(Vector2(x1, 0), Vector2(x1, 5), 5)
	for cha in chas1:
		if cha.team != team :
			FFHurtChara(cha, att.mgiAtk * icicles_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({"cha": cha, "dur": 20})

	chas2 = Utils.lineChas(Vector2(x2, 0), Vector2(x2, 5), 5)
	for cha in chas2:
		if cha.team != team :
			FFHurtChara(cha, att.mgiAtk * icicles_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({"cha": cha, "dur": 20})

# 原恒星
func protostar(overtime = true):
	Utils.draw_effect("energyStorage", position, Vector2(0, 0), 15, 6)
	Utils.draw_effect("beatficVision", Vector2(350, 200), Vector2(0, -30), 10, 4)
	var chas = getAllChas(1)
	for i in chas:
		if overtime:
			i.att.hp = -1
			FFHurtChara(i, i.att.maxHp, Chara.HurtType.REAL, Chara.AtkType.SKILL)
		else:
			FFHurtChara(i, att.mgiAtk * supernova_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)


func uptial():
	var cha = sys.rndListItem(getAllChas(1))
	addBuff(laser.new(cha.cell.x, self, 5))


# 用buff做临时对象，内部延时不受外部影响，且时间结束自动释放，完美
class laser extends Buff:
	var chas
	var Utils = globalData.infoDs["g_aFFXIVUtils"]
	func _init(x, Dragon = null, dur = 1):
		life = dur
		Utils.draw_effect("danger", Vector2(x * 100, -1), Vector2(-300, 0), 2, 1, false, deg2rad(90))
		yield(sys.get_tree().create_timer(3), "timeout")
		var effect = Utils.draw_effect("icicles", Vector2(x * 100, 400), Vector2(0, -50), 4)
		effect._initFlyPos(Vector2(x * 100, 0), 1600)

		chas = Utils.lineChas(Vector2(x, 0), Vector2(x, 5), 5)
		for cha in chas:
			Dragon.FFHurtChara(cha, Dragon.att.mgiAtk * Dragon.icicles_pw * 0.5, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		

# 万亿斩击
func trillionChop():
	Chant.chantStart("万亿斩击", 5)
	self.HateTarget = aiCha
	yield(reTimer(5), "timeout")
	if att.hp <=0:
		return
	if self.HateTarget != null:
		Utils.draw_effect("zhua", self.HateTarget.position, Vector2(0, -30), 15, 3)
		hurtChara(self.HateTarget, att.mgiAtk * trillionChop_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
		BUFF_LIST.b_VulnerableLarge.new({"cha": self.HateTarget, "dur": 15})
	self.aiOn = false

func tsunami():
	Chant.chantStart("大海啸-团灭", 30)
	yield(reTimer(31), "timeout")
	if att.hp <=0:
		return
	var chas = getAllChas(1)
	for i in chas:
		i.att.hp = -1
		FFHurtChara(i, i.att.maxHp, Chara.HurtType.REAL, Chara.AtkType.SKILL)


func _upS():
	._upS()
	if aiCha.isDeath or aiCha == null:
		aiCha = sys.rndListItem(getAllChas(1))

	if STAGE == "p1":
		setCell(Vector2(4, 0))
		position = sys.main.map.map_to_world(Vector2(4, 0))

	if STAGE == "p2":
		setCell(Vector2(7, 2))
		position = sys.main.map.map_to_world(Vector2(7, 2))
		# 从p2开始，每秒累计原恒星的威力
		protostar_pw += 0.02

	if STAGE == "p3":
		setCell(Vector2(4, 0))
		position = sys.main.map.map_to_world(Vector2(4, 0))

	if STAGE == "p1" and battleDuration > BERSERKERTIME_P1 and (battleDuration % 5 == 0):
		# p1阶段超过180s，狂暴
		blowingSnow()
		blowingSnow_pw += 1
		battleDuration = BERSERKERTIME_P1


class b_longAtk:
	extends Buff
	func _init():
		attInit()
		id = "b_longAtk"
		att.atkRan = 1