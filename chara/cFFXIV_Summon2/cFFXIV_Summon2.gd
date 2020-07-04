extends "../cex___FFXIVSummon/cex___FFXIVSummon.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "迦楼罗之灵"
	isDeath = true
	addSkillTxt("风神之灵，与召唤师攻击同一目标，根据召唤师等级解锁技能")
	addSkillTxt(TEXT.format("""lv2·[烈风刃]：冷却4s，对目标造成召唤师[10%]法强的物理伤害
lv3·[螺旋气流]：冷却10s，对目标周围一格的敌人造成召唤师[30%]法强的魔法伤害，并附加[螺旋气流]
lv4·[大气爆发]：冷却24s，对目标周围一格的敌人造成召唤师[150%]法强的魔法伤害"""))

const Crimson_pw = 0.10
const Flaming_pw = 0.30
const Inferno_pw = 1.80

func _connect():
	._connect() 

func skill_lv1():
	normalSpr.position += Vector2(10, -10)
	Summoner.FFHurtChara(Summoner.aiCha, Summoner.att.mgiAtk * Crimson_pw, PHY, SKILL)
	yield(reTimer(0.1), "timeout")
	normalSpr.position -= Vector2(10, -10)

func skill_lv2():
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Flaming_pw, MGI, SKILL)
			BUFF_LIST.b_Slipstream.new({
				"cha": i,
				"cas": Summoner,
				"dur": 8
			})

func skill_lv3():
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	Utils.draw_efftext("大气爆发", Summoner.position, "#58ff83")
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Inferno_pw, MGI, SKILL)