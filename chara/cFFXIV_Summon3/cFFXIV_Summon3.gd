extends "../cex___FFXIVSummon/cex___FFXIVSummon.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "泰坦之灵"
	isDeath = true
	addSkillTxt("土神之灵，与召唤师攻击同一目标，根据召唤师等级解锁技能")
	addSkillTxt(TEXT.format("""lv2·[碎岩]：冷却4s，对目标造成召唤师[40%]法强的魔法伤害
lv3·[山崩]：冷却10s，对目标周围一格的敌人造成召唤师[40%]法强的物理伤害
lv4·[大地之怒]：冷却24s，对目标周围一格的敌人造成召唤师[130%]法强的物理伤害"""))

const Crimson_pw = 0.40
const Flaming_pw = 0.40
const Inferno_pw = 1.30

func _connect():
	._connect() 

func skill_lv1():
	normalSpr.position += Vector2(10, -10)
	Summoner.FFHurtChara(Summoner.aiCha, Summoner.att.mgiAtk * Crimson_pw, MGI, SKILL)
	yield(reTimer(0.1), "timeout")
	normalSpr.position -= Vector2(10, -10)

func skill_lv2():
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Flaming_pw, PHY, SKILL)

func skill_lv3():
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	Utils.draw_efftext("大地之怒", Summoner.position, "#f1b500")
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Inferno_pw, PHY, SKILL)