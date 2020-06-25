extends "./BossChara.gd"
const BERSERKERTIME_P1 = 180 # P1狂暴时间

var stage = "p1" # p1 p2 p3阶段

var reincarnation_pw = 4 # 死亡轮回威力
var blowingSnow_pw = 0.75 # 吹雪威力
var lightning_pw = 1 # 闪电威力
var supernova_pw = 1 # 超新星威力
var icicles_pw = 1 # 冰柱威力

var SKILL_TXT = """{c_base}
第一阶段：
[大地之怒]：开战时使用且只使用一次。神龙的威严不可触犯，对所有敌人造成最大生命值[150%]的魔法伤害。
[死亡轮回]：{TDeath}对当前仇恨目标连续造成四次[{1}]的范围魔法伤害，可多人分摊伤害。
[吹雪]：对所有敌人造成[{2}]的魔法伤害，会在场地上留下水坑，水坑中的角色会获得[雷耐性下降·大][火耐性上升·大]。
[闪电]：对所有敌人释放闪电，造成[{3}]的小范围雷属性魔法伤害。
[超新星]：对所有敌人释放火炎攻击，造成[{4}]的火属性魔法伤害。
[召唤冰柱]：场地随机一边出现两根冰柱，对直线上的敌人造成[{5}]的魔法伤害，并附加[易伤]。

第二阶段：
[召唤小龙]：在场地上召唤4只小龙，1只大龙。
[原恒星]：对所有敌人造成[{6}]的魔法伤害，场上每有一只小龙存活，该技能伤害提升20%。

第三阶段：
[万亿斩击]：{TDeath}对当前仇恨目标造成[{7}]的物理伤害，并附加[物理耐性下降·大]
{/c}"""

var pwConfig = {
	"0": "未知",
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知",
	"5": "未知",
	"6": "未知",
	"7": "未知",
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
	set_path("cex___FFBossDragon")
	set_time_axis({
		"blowingSnow": [20, 60, 100, 140],
		"icicles": [26, 66, 106, 146],
		"leftOrRigth": [33, 73, 113, 153],
		"reincarnation": [45, 85, 125, 165],
	})
	FFControl = Utils.initFFControl()
	Utils.background_change(Path + "/background/CrystallizationSpace.png", false)
	FFControl.FFMusic.play(Path + "/music/DragonFantasy1.ogg.oggstr")


func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_attack" and stage == "p1":
		var count = 0
		for cha in Retreat.PlayerChas:
			if !cha.isDeath:
				count += 1
				attack(cha, count)
			if count == 2:
				return


func _onBattleStart():
	._onBattleStart()
	stage = "p1"
	sprcPos = Vector2(-50, -40)
	for cha in sys.main.btChas:
		if cha.team == 1:
			cha.addBuff(b_longAtk.new())
	wrathOfTheEarth()
	reincarnation_pw *= (E_lv / E_num) # 死亡轮回威力
	blowingSnow_pw *= (E_lv / E_num) # 吹雪威力
	lightning_pw *= (E_lv / E_num) # 闪电威力
	supernova_pw *= (E_lv / E_num) # 超新星威力
	icicles_pw *= (E_lv / E_num) # 冰柱威力

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
	if att.hp <= att.maxHp * 0.44 and stage == "p1":
		changeStage("p2")

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	queue_eff()

func changeStage(p):
	self.isDeath = true
	stage = p

	for cha in sys.main.btChas:
		if cha.team == 1:
			BUFF_LIST.b_FrozenCdSkill.new(20, cha)

	yield(reTimer(2), "timeout")
	normalSpr.position = Vector2(0, -300)
	Utils.draw_shadow(img,  position, position + Vector2(0, -300), 25)

	if stage == "p2":
		activeTimeManeuver()
		Utils.draw_shadow(img,  position + Vector2(0, 600), position, 25)
		FFControl.FFMusic.play(Path + "/music/DragonFantasy2.ogg.oggstr")

func activeTimeManeuver():
	pass

func queue_eff():
	if mapEffect.puddle != null:
		mapEffect.puddle.queue_free()
		mapEffect.puddle = null


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
	FFHurtChara(cha, cha.att.maxHp * 0.3, Chara.HurtType.PHY, Chara.AtkType.SKILL)
	
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
	BUFF_LIST.b_Share.new(5, aiCha)
	yield(reTimer(5), "timeout")
	shareDemage()
	yield(reTimer(1), "timeout")
	shareDemage()
	yield(reTimer(1), "timeout")
	shareDemage()
	yield(reTimer(1), "timeout")
	shareDemage()

func shareDemage():
	if att.hp <= 0:
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

	if att.hp <= 0:
		return

	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			FFHurtChara(i, att.mgiAtk * blowingSnow_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	yield(reTimer(1), "timeout")
	if att.hp <= 0:
		return

	if mapEffect.puddle == null:
		mapEffect.puddle = Utils.draw_effect_out(Path + "/effects/puddle", Vector2(position.x, position.y - 1), Vector2(25, 75), 13, 2, true)
		
# 闪电/超新星
func leftOrRigth():
	var type = sys.rndRan(0, 1)
	var name = ["闪电", "超新星"]

	Chant.chantStart(name[type], 4)
	yield(reTimer(4), "timeout")

	queue_eff()

	if att.hp <=0:
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
	if att.hp <=0:
		return

	var eff1 = Utils.draw_effect("icicles", Vector2(x1 * 100, 400), Vector2(0, -50), 4)
	eff1._initFlyPos(Vector2(x1 * 100, 0), 1600)
	var eff2 = Utils.draw_effect("icicles", Vector2(x2 * 100, 400), Vector2(0, -50), 4)
	eff2._initFlyPos(Vector2(x2 * 100, 0), 1600)

	chas1 = Utils.lineChas(Vector2(x1, 0), Vector2(x1, 5), 5)
	for cha in chas1:
		if cha.team != team :
			FFHurtChara(cha, att.mgiAtk * icicles_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			cha.addBuff(BUFF_LIST.b_VulnerableSmall.new(20))

	chas2 = Utils.lineChas(Vector2(x2, 0), Vector2(x2, 5), 5)
	for cha in chas2:
		if cha.team != team :
			FFHurtChara(cha, att.mgiAtk * icicles_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			cha.addBuff(BUFF_LIST.b_VulnerableSmall.new(20))


func _upS():
	._upS()
	if stage == "p1" and battleDuration > BERSERKERTIME_P1 and (battleDuration % 5 == 0):
		# p1阶段超过180s，狂暴
		blowingSnow()
		blowingSnow_pw += 1


class b_longAtk:
	extends Buff
	func _init():
		attInit()
		id = "b_longAtk"
		att.atkRan = 1