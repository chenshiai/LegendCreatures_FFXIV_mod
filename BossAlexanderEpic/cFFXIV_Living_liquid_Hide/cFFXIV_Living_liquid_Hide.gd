extends "../../2098858773/BossChara.gd"
const BERSERKERTIME_P1 = 140 # P1狂暴时间
var HandoWater = null
var fluidOscillation_pw = 2.5 # 流体震荡威力
var pourOut_pw = 1.2 # 倾泻威力
var waves_pw = 1.6 # 水波威力
var tarchwater = false # 是否碰到了水球
var SKILL_TXT = """
{c_base}亚历山大绝境战 第一阶段
{c_skill}[流体震荡]{/c}：{TDeath}对当前目标造成{c_phy}[{1}]{/c}的小范围物理伤害。
{c_skill}[水波]{/c}：射出水波，对命中的敌人造成{c_mgi}[{3}]{/c}的水属性魔法伤害，并附加[水耐性下降·大]，持续15s。
{c_skill}[倾泻]{/c}：对全屏的敌人造成{c_mgi}[{2}]{/c}的水属性魔法伤害，并在场上留下两个[水圈]，然后召唤[活水之手]。
说明：水圈将周期性地朝距离最近敌人的方向射出一道水波。
{c_skill}[万变水波]{/c}：[有生命活水]与[水圈]将连续发动[水波]组合技能，之后[水圈]会产生一个缓慢移动的水球。
说明：任何单位在碰到水球后会引发全屏爆炸。{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
}

var mapEffect = [
	{
		"cell": Vector2(1, 1),
		"effect": null
	},
	{
		"cell": Vector2(8, 4),
		"effect": null
	},
]

func queue_free_eff():
	for item in mapEffect:
		if item.effect != null:
			item.effect.queue_free()
			item.effect = null

func _extInit():
	._extInit()
	chaName = "有生命活水"
	lv = 4
	attCoe.atkRan = 1
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(TEXT.BOSS_LIVING_LIQUID)

func _init():
	._init()
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		"pourOut": [18, 87, 133],
		"hydrosphere": [30, 40, 60, 70, 80, 115],
		"fluidOscillation": [10, 36, 54, 124],
		"waves": [95],
		"parting": [104],
		"waves2": [107],
		"waterPolo": [118],
		"over": [140]
	})
	Utils.background_change(Path, "/background/TheEpicOfAlexander.png")
	closeReward()


func _onBattleStart():
	._onBattleStart()
	STAGE = "p1"
	closeReward()
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 400
	fluidOscillation_pw *= (E_lv / E_num) # 流体震荡威力
	pourOut_pw *= (E_lv / E_num) # 倾泻威力
	waves_pw *= (E_lv / E_num) # 水波威力
	pwConfig = {
		"1": "%d%%" % [fluidOscillation_pw * 100],
		"2": "%d%%" % [pourOut_pw * 100],
		"3": "%d%%" % [waves_pw * 100],
	}
	skillStrs[1] = TEXT.format(SKILL_TXT, pwConfig)
	att.hp = 1000
	FFControl.FFMusic.play(Path, "/music/dregs.oggstr")
	upAtt()

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if atkInfo.atkCha != self and HandoWater != null:
		HandoWater.hurtself(atkInfo.hurtVal)

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	StageToP2()
	queue_free_eff()
	if HandoWater != null:
		HandoWater.att.hp = -1
		HandoWater.hurtself(atkInfo.hurtVal)

func StageToP2():
	if STAGE == "p1":
		var CruiseChaser = sys.main.newChara("cFFXIV_CruiseChaser_Hide", 2)
		# var CruiseChaser = sys.main.newChara("cFFXIVBossTheEpicofAlexander_Hide", 2)
		if CruiseChaser:
			sys.main.map.add_child(CruiseChaser)
			CruiseChaser._onBattleStart()

# 流体震荡
func fluidOscillation():
	Chant.chantStart("流体震荡", 3)
	yield(reTimer(3), "timeout")
	Utils.draw_effect("blastYellow", aiCha.position, Vector2(0, -50), 15)
	if att.hp <= 0 or self.isDeath:
		return
	var chas = getCellChas(aiCha.cell, 1)
	complexHurt(chas, att.mgiAtk * fluidOscillation_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 倾泻
func pourOut():
	aiOn = false
	Chant.chantStart("倾泻", 4)
	yield(reTimer(4), "timeout")
	Utils.draw_effect("waterBoom", Vector2(350, 150), Vector2(0, 0), 15, 2)
	yield(reTimer(0.2), "timeout")

	if att.hp <= 0 or self.isDeath:
		return

	complexHurt(getAllChas(1), att.mgiAtk * pourOut_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

	for item in mapEffect:
		if item.effect == null:
			item.effect = Utils.draw_effect("puddle", item.cell * 100, Vector2(0, 0), 13, 1, true)
			item.effect.show_on_top = false

	summonHandoWater()
	yield(reTimer(2), "timeout")
	aiOn = true


func summonHandoWater():
	if HandoWater == null:
		HandoWater = sys.main.newChara("cFFXIV_HandofivingWater_Hide", 2)
		sys.main.map.add_child(HandoWater)
		HandoWater.attInfo.maxHp = att.hp
		HandoWater.attInfo.atk = att.atk
		HandoWater.attInfo.mgiAtk = att.mgiAtk
		HandoWater.attInfo.def = att.def
		HandoWater.attInfo.mgiDef = att.mgiDef
		HandoWater.attCoe.atkRan = 0
		HandoWater.moveSpeed = 100
		HandoWater.upAtt()
		HandoWater.Summoner = self


# 水圈喷水
func hydrosphere(show = true):
	var chas = getAllChas(1)
	for item in mapEffect:
		if item.effect != null:
			var target = Utils.distanceMinCha(item.cell, chas)
			wave(item.cell, target.cell, show)


# 水波
func wave(cell, chaCell, show = false):
	var start = cell * 100
	var chaPosition = chaCell * 100
	var rotation = atan2(chaPosition.y - start.y, chaPosition.x - start.x)

	if show:
		var eff1 = Utils.draw_effect("wavedanger", start, Vector2(-125, 0), 2, Vector2(5, 3), false, rotation)
		eff1.show_on_top = false
		yield(reTimer(3), "timeout")
		if att.hp <= 0 or self.isDeath:
			return

	var eff2 = Utils.draw_effect("wave", start, Vector2(-125, 0), 8, Vector2(5, 3), false, rotation)
	eff2.show_on_top = false

	var chas = Utils.lineChas(cell, chaCell, 15)

	for cha in chas:
		if cha.team != team :
			FFHurtChara(cha, att.atk * waves_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			BUFF_LIST.b_waterDown.new({
				"cha": cha,
				"dur": 15
			})


# 万变水波1
func waves():
	aiOn = false
	Chant.chantStart("万变水波", 5)
	yield(reTimer(5), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	for cha in getAllChas(1):
		wave(self.cell, cha.cell, true)

# 万变水波2
func waves2():
	if att.hp <= 0 or self.isDeath:
		return
	for cha in getAllChas(1):
		wave(self.cell, cha.cell, false)
	aiOn = true

# 离别之手
func parting():
	HandoWater.parting()

func waterPolo():
	queue_free_eff()
	for item in mapEffect:
		var startPos = item.cell * 100
		item.effect = Utils.draw_effect("waterBall", startPos, Vector2(0,-30), 0)
		item.effect._initFlyPos(startPos + (self.position - startPos).normalized() * 800, 50)
		item.effect.show_on_top = true
		item.effect.connect("onInCell", self, "effInCell")


func effInCell(cell):
	if (att.hp <= 0 and !tarchwater) or self.isDeath:
		return
	tarchwater = true
	var cha = matCha(cell)
	if cha != null:
		queue_free_eff()
		Ace()
		Utils.draw_effect("waterBoom", Vector2(350, 150), Vector2(0, 0), 15, 2)

func over():
	aiOn = false
	Chant.chantStart("倾泻-团灭", 15)
	yield(reTimer(15), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	var chas = getAllChas(1)
	Utils.draw_effect("waterBoom", Vector2(350, 150), Vector2(0, 0), 15, 2)
	yield(reTimer(0.2), "timeout")

	if att.hp <= 0:
		return
	Ace()
