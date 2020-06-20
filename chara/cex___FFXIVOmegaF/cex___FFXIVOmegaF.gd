extends "../cex___FFXIVBossChara/cex___FFXIVBossChara.gd"
const BERSERKERTIME = 120 # 狂暴时间

var SKILL_TXT = TEXT.format("""[太阳射线]：{TDeath}对当前攻击目标造成[未知]法强的小范围{TMgiHurt}
[激光雨]：对全屏的敌人造成[未知]法强的{TMgiHurt}
[优化爆炎]：对所有敌人造成一次[未知]法强的小范围{TMgiHurt}""")

func _extInit():
	._extInit()
	chaName = "欧米茄F"
	lv = 4
	addSkillTxt(SKILL_TXT)
	addSkillTxt("""[宇宙之光]：战斗时间超过 %d秒后，进入狂暴，每5s释放一次激光雨，每次伤害增加60%%
[防火墙]：该单位免疫[烧灼]""" % [BERSERKERTIME])
	addSkillTxt(TEXT.BOSS_OMEGA)

var solaRays_pw = 4 # 死刑威力
var laserRain_pw = 0.75 # 激光雨威力
var optimizedFireIII_pw = 1 # 爆炎威力

func _init():
	var SkillAxis = {
		"solarRays": [25, 55, 85, 115],
		"laserRain": [5, 20, 40, 60, 90, 110],
		"optimizedFireIII": [80]
	}
	call_deferred("setTimeAxis", SkillAxis)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	solaRays_pw *= (E_lv / E_num)
	laserRain_pw *= (E_lv / E_num)
	optimizedFireIII_pw *= (E_lv / E_num)
	SKILL_TXT = TEXT.format("""[太阳射线]：{TDeath}对当前攻击目标造成[{0}]法强的小范围{TMgiHurt}
[激光雨]：对全屏的敌人造成[{1}]法强的{TMgiHurt}
[优化爆炎]：对所有敌人造成一次[{2}]法强的小范围{TMgiHurt}""",
		{
			"0": "%d%%" % [solaRays_pw * 100],
			"1": "%d%%" % [laserRain_pw * 100],
			"2": "%d%%" % [optimizedFireIII_pw * 100]
		})
	skillStrs[1] = SKILL_TXT
	upAtt()

func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = SKILL_TXT
	laserRain_pw = 0.75

func _onAddBuff(buff:Buff):
	if buff.id == "b_shaoZhuo" :
			buff.isDel = true

# 技能-太阳射线
func solarRays():
	self.HateTarget = aiCha
	Chant.chantStart("太阳射线", 3)
	yield(reTimer(3), "timeout")
	if att.hp <= 0:
		return
	var chas = getCellChas(self.HateTarget.cell, 1)
	Utils.createEffect("blastYellow", self.HateTarget.position, Vector2(0, -50), 15)
	for i in chas:
		if i != self:
			hurtChara(i, att.mgiAtk * solaRays_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 技能-激光雨
func laserRain():
	Utils.createEffect("lightBlue", Vector2(position.x, position.y - 1), Vector2(0, -10), 15, 10)
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * laserRain_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 技能-优化爆炎
func optimizedFireIII():
	Chant.chantStart("优化爆炎", 3)
	yield(reTimer(3), "timeout")
	if att.hp <=0:
		return
	var chas = getAllChas(1)
	for i in chas:
		Utils.createEffect("light", i.position, Vector2(0, -10), 15, 1.8)
		var cha = getCellChas(i.cell, 1)
		for j in cha:
			if j != self:
				hurtChara(j, att.mgiAtk * optimizedFireIII_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		yield(reTimer(0.1), "timeout")

func _upS():
	._upS()
	if battleDuration > BERSERKERTIME and (battleDuration % 5 == 0):
		laserRain()
		laserRain_pw += 0.6