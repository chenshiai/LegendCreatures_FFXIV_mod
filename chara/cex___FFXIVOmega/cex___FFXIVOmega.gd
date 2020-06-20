extends "../cex___FFXIVBossChara/cex___FFXIVBossChara.gd"
const BERSERKERTIME = 140 # 狂暴时间

var SKILL_TXT = TEXT.format("""[芥末爆弹]：死刑，对当前攻击目标造成[未知]法强的小范围{TMgiHurt}
[原子射线]：对全屏的敌人造成[未知]法强的{TMgiHurt}
[三角攻击]：对全屏的敌人造成[致命]的{TMgiHurt}（会移动至场边释放，届时请使用三段极限技[防护]）""")

func _extInit():
	._extInit()
	chaName = "欧米茄"
	lv = 4
	moveSpeed += 200
	addSkillTxt(SKILL_TXT)
	addSkillTxt("""[宇宙之光]：战斗时间超过 %d秒后，进入狂暴，每5s释放一次原子射线，每次伤害增加60%%
[机械构造]：该单位免疫[流血]""" % [BERSERKERTIME])
	addSkillTxt(TEXT.BOSS_OMEGA)

var mustardBomb_pw = 4 # 死刑威力
var atomicRay_pw = 0.75 # 原子射线威力
var triangleAttack_pw = 22 # 三角攻击威力

func _init():
	var SkillAxis = {
		"mustardBomb": [25, 55, 90, 115],
		"atomicRay": [2, 20, 40, 60, 110],
		"triangleAttack": [70]
	}
	call_deferred("setTimeAxis", SkillAxis)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	mustardBomb_pw *= (E_lv / E_num)
	atomicRay_pw *= (E_lv / E_num)
	SKILL_TXT = TEXT.format("""[芥末爆弹]：死刑，对当前攻击目标造成[{0}]点小范围{TMgiHurt}
[原子射线]：对全屏的敌人造成[{1}]点{TMgiHurt}
[三角攻击]：对全屏的敌人造成[{2}]点{TMgiHurt}（会移动至场边释放，届时请使用三段极限技[防护]）""",
		{
			"0": "%d" % [mustardBomb_pw * att.mgiAtk],
			"1": "%d" % [atomicRay_pw * att.mgiAtk],
			"2": "%d" % [triangleAttack_pw * att.mgiAtk]
		})
	skillStrs[1] = SKILL_TXT
	upAtt()

func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = SKILL_TXT
	atomicRay_pw = 0.75
	mustardBomb_pw = 4

func _onAddBuff(buff:Buff):
	if buff.id == "b_liuXue" :
			buff.isDel = true

# 技能-芥末爆弹
func mustardBomb():
	self.HateTarget = aiCha
	Chant.chantStart("芥末爆弹", 3)
	yield(reTimer(3), "timeout")
	if att.hp <= 0:
		return
	var chas = getCellChas(self.HateTarget.cell, 1)
	Utils.createEffect("blastYellow", self.HateTarget.position, Vector2(0, -50), 15)
	for i in chas:
		if i != self:
			hurtChara(i, att.mgiAtk * mustardBomb_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 技能-原子射线
func atomicRay():
	Utils.createEffect("lightBlue", Vector2(position.x, position.y - 1), Vector2(0, -10), 15, 10)
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * atomicRay_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 技能-三角攻击
func triangleAttack():
	var oriAi = self.aiOn
	normalSpr.position = Vector2(0, -50)
	self.isDeath = true
	self.aiOn = false

	yield(reTimer(0.5), "timeout")
	setCell(Vector2(0, 0))
	yield(reTimer(0.9), "timeout")
	setCell(Vector2(0, 4))
	yield(reTimer(0.8), "timeout")
	setCell(Vector2(7, 4))
	yield(reTimer(1.4), "timeout")
	setCell(Vector2(7, 2))

	Chant.chantStart("三角攻击", 5)
	yield(reTimer(5), "timeout")
	for i in range(10):
		normalSpr.position = Vector2(0, -2)
		yield(reTimer(0.1), "timeout")
		normalSpr.position = Vector2(0, 2)
		yield(reTimer(0.1), "timeout")
	normalSpr.position = Vector2(0, 0)

	Utils.createEffect("sanjiao", Vector2(300, 350), Vector2(0, -30), 7, 3)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("sanjiao", Vector2(300, 120), Vector2(0, -30), 9, 3)
	yield(reTimer(0.2), "timeout")
	Utils.createEffect("sanjiao", Vector2(400, 225), Vector2(0, -30), 13, 3)
	
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * triangleAttack_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	
	yield(reTimer(2), "timeout")
	self.isDeath = false
	self.aiOn = oriAi
	

func _upS():
	._upS()
	if battleDuration > BERSERKERTIME and (battleDuration % 5 == 0):
		atomicRay()
		atomicRay_pw += 0.6