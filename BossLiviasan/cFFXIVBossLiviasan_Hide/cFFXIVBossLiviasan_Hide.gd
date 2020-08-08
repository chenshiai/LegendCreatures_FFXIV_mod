extends "../../2098858773/BossChara.gd"
const WaterPro = 13
var BASE = """[color=#ffffff]
虽然受到了出乎意料的袭击，不过已经获得了伊甸控制权的一行人终于要开始为重新取回属性之力而行动起来。
据于里昂热所说，最初应该激活的属性乃是所有生命之源的水属性之力。
乘上伊甸的暗之战士们来到了第一世界曾经最深的海底，
此处有着一条巨大的海沟——涅柔斯海渊，
于里昂热利用暗之战士心中水神“利维亚桑”的形象进行了构想请神。
挑战构想蛮神，激活水属性！[/color]"""

var SKILL_TXT = """{c_base}
{c_skill}[裂流]{/c}：{TDeath}对仇恨目标发射激流，造成{c_mgi}[{1}]{/c}的魔法伤害，并附加[水耐性下降·大]4s，连续使用两次
{c_skill}[怒潮咆哮]{/c}：对全屏的敌人造成{c_mgi}[{2}]{/c}的魔法伤害
{c_skill}[离岸洋流]{/c}：对场地一边进行喷水，对命中的敌人造成{c_mgi}[{3}]{/c}的魔法伤害，并附加[水耐性下降·大]15s
{c_skill}[大漩涡]{/c}：随机出现在场地一边，进行半场俯冲对命中的敌人造成{c_mgi}[{4}]{/c}的魔法伤害，并附加[水耐性下降·大]15s{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知",
}

func _extInit():
	._extInit()
	chaName = "利维亚桑（构想）"
	lv = 4
	attCoe.atkRan = 0
	moveSpeed = 0
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(BASE)
	addCdSkill("skill_attack", 3)

var cleftFlow_pw = 3.5 # 裂流威力
var theTideRoared_pw = 1.2 # 怒潮咆哮威力
var offshoreCurrent_pw = 1.6 # 离岸洋流威力
var maelstrom_pw = 1.2 # 俯冲威力
var isAwaken = false # 是否觉醒
func _init():
	._init()
	set_time_axis({
		"cleftFlow": [12, 60, 130, 160],
		"theTideRoared": [2, 44, 52, 80, 120, 140, 150],
		"offshoreCurrent": [24, 73, 96],
		"awaken": [86],
		"maelstrom": [34, 106],
		"over": [170]
	})
	set_path("cFFXIVBossLiviasan_Hide")
	FFControl = Utils.getFFControl()
	Utils.background_change(Path, "/background/NereusAbyss.png")
	FFControl.FFMusic.play(Path, "/music/希望の園エデン：覚醒編.oggstr")
	self.show_on_top = false
	call_deferred("setPos")

func setPos():
	normalSpr.position = Vector2(-60, 85)
	sprcPos = Vector2(-60, 0)
	self.get_node("ui/hpBar").scale *= 2

func _onBattleStart():
	._onBattleStart()
	aiOn = false
	STAGE = "p1"
	for cha in sys.main.btChas:
		if cha.team == 1:
			cha.addBuff(b_longAtk.new())

	# attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 540
	cleftFlow_pw *= (E_lv / E_num)
	theTideRoared_pw *= (E_lv / E_num)
	offshoreCurrent_pw *= (E_lv / E_num)
	maelstrom_pw *= (E_lv / E_num)
	pwConfig = {
		"1": "%d%%" % [cleftFlow_pw * 100],
		"2": "%d%%" % [theTideRoared_pw * 100],
		"3": "%d%%" % [offshoreCurrent_pw * 100],
		"4": "%d%%" % [maelstrom_pw * 100]
	}
	skillStrs[1] = TEXT.format(SKILL_TXT, pwConfig)
	aiCha = Retreat.PlayerChas[0]
	upAtt()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if STAGE == "p2":
		atkInfo.hurtVal = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_attack":
		if STAGE != "p2":
			var count = 0
			for cha in Retreat.PlayerChas:
				if !cha.isDeath:
					count += 1
					attack(cha, count)
				if count == 2:
					return

func _upS():
	._upS()
	if aiCha.isDeath or aiCha == null:
		aiCha = sys.rndListItem(getAllChas(1))
	setCell(Vector2(5, 0))
	position = sys.main.map.map_to_world(Vector2(5, 0))


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

func over():
	Chant.chantStart("混沌的涡动-团灭", 30)
	yield(reTimer(31), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Ace()

class b_longAtk:
	extends Buff
	func _init():
		attInit()
		id = "b_longAtk"
		att.atkRan = 1

func awaken():
	pass

func cleftFlow(first = true):
	var start
	var target
	if first:
		self.HateTarget = aiCha
		Chant.chantStart("裂流", 5)
		BUFF_LIST.b_RollCall.new({"cha": self.HateTarget, "dur": 5})
		yield(reTimer(5), "timeout")
		if att.hp <= 0 or self.isDeath:
			return
		start = position + Vector2(-100, 0)
		target = self.HateTarget
	else:
		start = position + Vector2(100, 0)
		target = aiCha

	var	rotation = (target.position - start).angle()
	Utils.draw_effect_v2({
		"name": "wave",
		"pos": start,
		"dev": Vector2(-125, 0),
		"fps": 8,
		"scale": 3,
		"rotation": rotation,
		"top": false
	})
	FFHurtChara(target, att.mgiAtk * cleftFlow_pw, Chara.HurtType.MGI, WaterPro)
	BUFF_LIST.b_decreasedTolerance.new({
		"cha": cha,
		"dur": 4,
		"text": "水耐性下降·大",
		"pw": 99,
		"atkType": WaterPro,
		"color": "#00a8ff"
	})
	if first:
		yield(reTimer(1), "timeout")
		cleftFlow(false)

func theTideRoared():
	Chant.chantStart("怒潮咆哮", 4)
	yield(reTimer(4), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Utils.draw_effect_v2({
		"name": "waterBoom",
		"pos": Vector2(450, 200),
		"fps": 15,
		"dev": Vector2(0, 0),
		"scale": Vector2(2.5, 2.4)
	})

	var chas = getAllChas(1)
	complexHurt(chas, att.mgiAtk * theTideRoared_pw, Chara.HurtType.MGI, WaterPro)



func offshoreCurrent():
	Chant.chantStart("离岸洋流", 5)
	var type = sys.rndRan(0, 1)
	var pos
	var dev
	if type == 0:
		dev = 0
		pos = position + Vector2(-130, 0)
	elif type == 1:
		dev = 5
		pos = position + Vector2(80, 0)

	Utils.draw_effect_v2({
		"dir": Path +"/effects/offshoreCurrent",
		"pos": pos,
		"fps": 1.5,
		"scale": 3,
		"dev": Vector2(0, 0),
		"top": true
	})
	yield(reTimer(5), "timeout")
	
	if att.hp <= 0 or self.isDeath:
		return
	for i in range(5):
		Utils.draw_effect_v2({
			"name": "wave",
			"pos": Vector2((i + dev) * 100, 0),
			"dev": Vector2(-105, 0),
			"fps": 8,
			"scale": 3,
			"rotation": deg2rad(90),
			"top": false
		})

	for cha in getAllChas(1):
		if cha.cell.x < dev + 5 and cha.cell.x >= dev:
			FFHurtChara(cha, att.mgiAtk * offshoreCurrent_pw, Chara.HurtType.MGI, WaterPro)
			BUFF_LIST.b_decreasedTolerance.new({
				"cha": cha,
				"dur": 15,
				"text": "水耐性下降·大",
				"pw": 99,
				"atkType": WaterPro,
				"color": "#00a8ff"
			})

func maelstrom():
	Chant.chantStart("大漩涡", 5)
	yield(reTimer(5), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	self.isDeath = true
	normalSpr.position += Vector2(0, -800)
	Utils.draw_shadow(img, position, position + Vector2(0, -250), 40)
	
	var dev = sys.rndRan(0, 1)
	vertical(dev)
	yield(reTimer(4), "timeout")
	dev = sys.rndRan(0, 1)
	horizontal(dev)

func vertical(dev):
	Utils.draw_effect_v2({
		"dir": Path +"/effects/maelstrom",
		"pos": Vector2(150 + (550 * dev), 0),
		"fps": 1,
		"dev": Vector2(0, -100)
	})
	yield(reTimer(4), "timeout")
	Utils.draw_shadow(img, Vector2(150 + (550 * dev), 0), Vector2(150 + (550 * dev), 800), 20)
	for cha in getAllChas(1):
		if cha.cell.x < (dev * 5) + 5 and cha.cell.x >= (dev * 5):
			FFHurtChara(cha, att.mgiAtk * maelstrom_pw, Chara.HurtType.MGI, WaterPro)
			BUFF_LIST.b_decreasedTolerance.new({
				"cha": cha,
				"dur": 15,
				"text": "水耐性下降·大",
				"pw": 99,
				"atkType": WaterPro,
				"color": "#00a8ff"
			})
	

func horizontal(dev):
	Utils.draw_effect_v2({
		"dir": Path +"/effects/maelstrom",
		"pos": Vector2(0, 50 + (350 * dev)),
		"fps": 1,
		"dev": Vector2(0, 0)
	})
	yield(reTimer(4), "timeout")
	Utils.draw_shadow(img, Vector2(0, 250 + (250 * dev)), Vector2(1200, 250 + (250 * dev)), 20)
	for cha in getAllChas(1):
		if cha.cell.y <= (dev * 3) + 2 and cha.cell.y >= (dev * 3):
			FFHurtChara(cha, att.mgiAtk * maelstrom_pw, Chara.HurtType.MGI, WaterPro)
			BUFF_LIST.b_decreasedTolerance.new({
				"cha": cha,
				"dur": 15,
				"text": "水耐性下降·大",
				"pw": 99,
				"atkType": WaterPro,
				"color": "#00a8ff"
			})
	yield(reTimer(1), "timeout")
	self.isDeath = false
	normalSpr.position -= Vector2(0, -800)
	