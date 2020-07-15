extends "../../2098858773/BossChara.gd"

var justiceKicks_pw = 1 # 正义飞踢威力
var steamWarShip_pw = 1.2 #飞轮威力
var fluidOscillation_pw = 2.8 # 火箭飞拳威力
var flaming_pw = 1.2 # 火炎放射威力
var SKILL_TXT = """{c_base}亚历山大绝境战 第二阶段

{c_skill}[正义飞踢]{/c}：残暴正义号登场！对所有敌人造成{c_phy}[{1}]{/c}的物理伤害
{c_skill}[蒸汽战轮]{/c}：在场外召唤两个飞轮。先向随机目标瞄准，然后发起冲锋，对路径上的敌人造成{c_phy}[{2}]{/c}的物理伤害，并附加[易伤]，持续10s
{c_skill}[火箭飞拳]{/c}：{TDeath}对当前目标造成{c_phy}[{3}]{/c}的小范围物理伤害
{c_skill}[大火炎放射]{/c}：朝着仇恨目标方向喷射出大范围火焰，对范围内的敌人造成{c_mgi}[{4}]{/c}的魔法伤害
{c_skill}[末世宣言]{/c}：跳跃至战场一边，朝着另一边的方向进行扫射{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知"
}

var flamingArea = [
	Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0),
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 1),
	Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)
]

func _extInit():
	._extInit()
	chaName = "残暴正义号"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))

func _init():
	._init()
	STAGE = "p1"
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		# "fluidOscillation": [25, 65, 100, 175],
		# "steamWarShip": [13, 37, 53, 115, 165],
		"flaming": [8, 125],
		"doomsdayDeclaration": [135]
	})
	closeReward()
	FFControl.HpBar.show()
	FFControl.FFMusic.play(Path, "/music/機工城律動編.oggstr")
	Utils.background_change(Path, "/background/TheEpicOfAlexander2.png")
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	sys.main.btChas.append(self)
	self.visible = false
	Chant.set_chant_position(Vector2(0, 50))

func _onBattleStart():
	._onBattleStart()
	STAGE = "p2"
	closeReward()
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 220
	justiceKicks_pw *= (E_lv / E_num) # 正义飞踢威力
	steamWarShip_pw *= (E_lv / E_num)
	fluidOscillation_pw *= (E_lv / E_num)
	flaming_pw *= (E_lv / E_num)
	pwConfig = {
		"1": "%d%%" % [justiceKicks_pw * 100],
		"2": "%d%%" % [steamWarShip_pw * 100],
		"3": "%d%%" % [fluidOscillation_pw * 100],
		"4": "%d%%" % [flaming_pw * 100]
	}
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))
	justiceKicks()

# 正义飞踢
func justiceKicks():
	var cha = matCha(Vector2(4, 2))
	if cha != null:
		if cha.team == 1:
			FFControl.complex_move("scatter")
		else:
			FFControl.complex_move("scatter")
			cha.setCell(Vector2(3, 2))

	cell = Vector2(4, 2)
	position = sys.main.map.map_to_world(Vector2(4, 2))
	self.visible = true
	Utils.draw_shadow(img, position + Vector2(0, -400), position, 25)
	Utils.draw_effect("bombardment", position, Vector2(0, -50), 6, 6)
	complexHurt(getAllChas(1), att.atk * justiceKicks_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 火箭飞拳（其实还是流体震荡）
func fluidOscillation():
	aiOn = false
	Chant.chantStart("火箭飞拳", 3)
	yield(reTimer(3), "timeout")
	Utils.draw_effect("blastYellow", aiCha.position, Vector2(0, -50), 15)
	if att.hp <= 0 or self.isDeath:
		return
	var chas = getCellChas(aiCha.cell, 1)
	complexHurt(chas, att.mgiAtk * fluidOscillation_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
	aiOn = true


# 蒸汽战轮
func steamWarShip():
	Chant.chantStart("蒸汽战轮", 4)
	var Ship1 = Utils.draw_effect_v2({
		"dir": Path + "/effects/steamWarShip",
		"pos": Vector2(-50, 150),
		"fps": 0,
		"dev": Vector2(0, -50),
		"top": true
	})
	var Ship2 = Utils.draw_effect_v2({
		"dir": Path + "/effects/steamWarShip",
		"pos": Vector2(750, 150),
		"fps": 0,
		"dev": Vector2(0, -50),
		"top": true
	})
	yield(reTimer(1), "timeout")
	var target = rndChas(getAllChas(1), 1)
	var tposition = target.position
	var tcell = target.cell
	yield(reTimer(3), "timeout")
	if att.hp <= 0 or self.isDeath:
		Ship1.queue_free()
		Ship2.queue_free()
		return
	Ship1._initFlyPos(Vector2(-50, 150) + (tposition - Vector2(-50, 150)).normalized() * 1000 , 1600)
	Ship2._initFlyPos(Vector2(750, 150) + (tposition - Vector2(850, 150)).normalized() * 1000 , 1600)

	var chas1 = Utils.lineChas(Vector2(0, 2), tcell, 15)
	for cha in chas1:
		if cha.team != team :
			FFHurtChara(cha, att.atk * steamWarShip_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": cha,
				"dur": 10
			})

	var chas2 = Utils.lineChas(Vector2(7, 2), tcell, 15)
	for cha in chas2:
		if cha.team != team :
			FFHurtChara(cha, att.atk * steamWarShip_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": cha,
				"dur": 10
			})


# 大火炎放射
func flaming():
	var mv = aiCha.cell
	var rotation = atan2(aiCha.position.y - position.y, aiCha.position.x - position.x)
	aiOn = false
	Chant.chantStart("大火炎放射", 5)
	yield(reTimer(5), "timeout")
	if att.hp <= 0 or self.isDeath:
		return

	Utils.draw_effect_v2({
		"name": "fireBig",
		"pos": position,
		"fps": 7,
		"dev": Vector2(-100, -65),
		"scale": Vector2(2, 3),
		"rotation": rotation
	})
	var chas = []
	for area in flamingArea:
		var v = mv + area
		var cha = matCha(v)
		if cha != null and cha != self:
			chas.append(cha)
	print(chas)
	complexHurt(chas, att.atk * flaming_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	aiOn = true


# 末世宣言
func doomsdayDeclaration():
	pass