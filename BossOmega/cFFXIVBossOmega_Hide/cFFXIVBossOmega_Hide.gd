extends "../../2098858773/BossChara.gd"

var SKILL_TXT = TEXT.format("""{c_base}
{c_skill}[机械构造]{/c}：该单位免疫[流血]
{c_skill}[芥末爆弹]{/c}：{TDeath}对当前攻击目标造成{c_mgi}[{1}]{/c}法强的小范围魔法伤害
{c_skill}[原子射线]{/c}：对全屏的敌人造成{c_mgi}[{2}]{/c}的魔法伤害
{c_skill}[火炎放射]{/c}：向所有敌人放射火炎，对命中的敌人造成{c_mgi}[{3}]{/c}的魔法伤害
{c_skill}[三角攻击]{/c}：对全屏的敌人造成{c_mgi}[致命]{/c}的魔法伤害（会移动至场边释放，届时请使用三段极限技[防护]）{/c}""")

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
}

func _extInit():
	._extInit()
	chaName = "欧米茄"
	lv = 4
	moveSpeed += 200
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(TEXT.BOSS_OMEGA)

var mustardBomb_pw = 4 # 死刑威力
var atomicRay_pw = 0.75 # 原子射线威力
var triangleAttack_pw = 22 # 三角攻击威力
var flaming_pw = 1.2 # 火炎放射威力

func _init():
	._init()
	set_time_axis({
		"mustardBomb": [25, 55, 100, 125, 155],
		"atomicRay": [2, 20, 40, 60, 145, 180, 190],
		"flaming2": [10, 90, 165],
		"triangleAttack": [70],
		"over": [200]
	})
	set_path("cFFXIVBossOmega_Hide")
	FFControl = Utils.getFFControl()
	Utils.background_change(Path, "/background/SpaceTimeSlit1.png")
	FFControl.FFMusic.play(Path, "/music/Omega.oggstr")

func _onBattleStart():
	._onBattleStart()
	STAGE = "p1"
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 720
	mustardBomb_pw *= (E_lv / E_num)
	atomicRay_pw *= (E_lv / E_num)
	flaming_pw *= (E_lv / E_num)
	pwConfig = {
		"1": "%d%%" % [mustardBomb_pw * 100],
		"2": "%d%%" % [atomicRay_pw * 100],
		"3": "%d%%" % [flaming_pw * 100]
	}
	skillStrs[1] = TEXT.format(SKILL_TXT, pwConfig)
	upAtt()


func _onAddBuff(buff:Buff):
	if buff.id == "b_liuXue" :
			buff.isDel = true

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if STAGE == "p2":
		atkInfo.hurtVal = 0


# 技能-芥末爆弹
func mustardBomb():
	aiOn = false
	self.HateTarget = aiCha
	Chant.chantStart("芥末爆弹", 3)
	yield(reTimer(3), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Utils.draw_effect("blastYellow", self.HateTarget.position, Vector2(0, -50), 15)
	var chas = getCellChas(self.HateTarget.cell, 1, 1)
	complexHurt(chas, att.mgiAtk * mustardBomb_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	aiOn = true
	
# 技能-原子射线
func atomicRay():
	aiOn = false
	Chant.chantStart("原子射线", 3)
	yield(reTimer(3), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Utils.draw_effect("lightBlue", Vector2(position.x, position.y - 1), Vector2(0, -10), 15, 10)
	var chas = getAllChas(1)
	complexHurt(chas, att.mgiAtk * atomicRay_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	aiOn = true

func over():
	aiOn = false
	Chant.chantStart("原子射线-团灭", 15)
	yield(reTimer(15), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Ace()

# 技能-三角攻击
func triangleAttack():
	normalSpr.position = Vector2(0, -50)
	STAGE = "p2"
	self.aiOn = false
	for cha in getAllChas(1):
		BUFF_LIST.b_StaticTimeUnlock.new({"cha": cha, "dur": 12})

	yield(reTimer(0.5), "timeout")
	setCell(Vector2(0, 0))
	yield(reTimer(1), "timeout")
	setCell(Vector2(0, 5))
	yield(reTimer(0.9), "timeout")
	setCell(Vector2(8, 5))
	yield(reTimer(1.5), "timeout")
	setCell(Vector2(8, 3))

	Chant.chantStart("三角攻击", 7)
	yield(reTimer(5), "timeout")
	for i in range(10):
		normalSpr.position = Vector2(0, -2)
		yield(reTimer(0.1), "timeout")
		normalSpr.position = Vector2(0, 2)
		yield(reTimer(0.1), "timeout")
	normalSpr.position = Vector2(0, 0)

	Utils.draw_effect("sanjiao", Vector2(400, 350), Vector2(0, -30), 7, 3)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("sanjiao", Vector2(400, 120), Vector2(0, -30), 9, 3)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("sanjiao", Vector2(400, 225), Vector2(0, -30), 13, 3)
	
	var chas = getAllChas(1)
	for cha in chas:
		yield(reTimer(0.1), "timeout")
		if cha.hasBuff("limit_protect"):
			FFHurtChara(cha, att.mgiAtk * triangleAttack_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		else:
			cha.att.hp = -1
			FFHurtChara(cha, 100, Chara.HurtType.REAL, Chara.AtkType.SKILL)

	yield(reTimer(2), "timeout")
	self.aiOn = true
	STAGE = "p3"

# 火炎放射
func flaming2():
	aiOn = false
	Chant.chantStart("火炎放射", 5)
	yield(reTimer(5), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	for cha in getAllChas(1):
		flaming(self.cell, cha.cell)
	aiOn = true


# 火炎
func flaming(cell, chaCell):
	var start = cell * 100
	var chaPosition = chaCell * 100
	var rotation = (chaPosition - start).angle()
	Utils.draw_effect_v2({
		"name": "wave",
		"pos": start,
		"dev": Vector2(-125, 0),
		"fps": 8,
		"scale": 3,
		"rotation": rotation,
		"top": false
	})

	var chas = Utils.lineChas(cell, chaCell, 15)
	complexHurt(chas, att.atk * flaming_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
