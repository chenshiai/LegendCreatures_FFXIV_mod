extends "../../2098858773/BossChara.gd"

var limitCutting_pw = 1 # 极限切割威力
var tornado_pw = 1.2 # 龙卷威力
var collimation_pw = 1 # 照准威力

var SKILL_TXT = """{c_base}亚历山大绝境战 第二阶段

{c_skill}[极限切割]{/c}：出现在随机一个敌人身边，对其所在位置进行范围斩击，造成{c_phy}[{1}]{/c}的物理伤害，并附加[易伤]，持续10s
然后向随机一个敌人进行冲锋，对冲锋路径上的敌人造成{c_phy}[{1}]{/c}的物理伤害
{c_skill}[龙卷]{/c}：释放龙卷风，对所有敌人造成{c_phy}[{2}]{/c}的物理伤害
{c_skill}[光子炮]{/c}：释放光子炮，使所有敌人{c_balance}生命值归1{/c}
{c_skill}[照准]{/c}：对所有敌人所在位置进行轰炸，造成{c_phy}[{3}]{/c}的中范围物理伤害{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知"
}

var vs = [
	Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0),
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 1),
	Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1),
	Vector2(-2, 0), Vector2(2, 0), Vector2(0, 2), Vector2(0, -2)
]

var limitCuttingArea = [
	Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0),
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 1),
	Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1),
]

func _extInit():
	._extInit()
	chaName = "巡航驱逐者"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))

func _init():
	._init()
	STAGE = "p1"
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		"limitCutting": [2, 6, 10, 14, 18, 22, 26, 30],
		"justiceKicks": [34],
		"tornado": [44, 75, 105, 145, 175],
		"collimation": [50, 95, 125],
		"photonGun": [60, 135]
	})
	closeReward()
	FFControl.HpBar.show()
	self.connect("onHurtEnd", FFControl.HpBar, "hpDown")
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	sys.main.btChas.append(self)

func _onBattleStart():
	._onBattleStart()
	aiOn = false
	STAGE = "p1"
	closeReward()
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 220
	limitCutting_pw *= (E_lv / E_num) # 极限切割威力
	tornado_pw *= (E_lv / E_num) # 龙卷威力
	collimation_pw *= (E_lv / E_num) # 照准威力
	pwConfig = {
		"1": "%d%%" % [limitCutting_pw * 100],
		"2": "%d%%" % [tornado_pw * 100],
		"3": "%d%%" % [collimation_pw * 100]
	}
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))
	self.visible = false

	for cha in sys.main.btChas:
		if cha.team == 1:
			BUFF_LIST.b_StaticTimeUnlock.new({"cha": cha, "dur": 34})

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if STAGE == "p1":
		atkInfo.hurtVal = 0

func limitCutting():
	Chant.chantStart("极限切割", 1)
	self.visible = true
	vs.shuffle()
	normalSpr.position = Vector2(0, -450)
	yield(reTimer(0.2), "timeout")

	var target = rndChas(getAllChas(1), 1)
	if target == null or target.isDeath:
		normalSpr.position = Vector2(0, 0)
		return

	var mv = target.cell
	for i in vs:
		var v = mv + i
		if matCha(v) == null and sys.main.isMatin(v):
			if setCell(v) :
				var pos = sys.main.map.map_to_world(cell)
				position = pos
				break

	normalSpr.position = Vector2(0, 0)
	Utils.draw_shadow(img, position + Vector2(0, -250), position, 60)
	var rotation = atan2(target.position.y - position.y, target.position.x - position.x)
	yield(reTimer(1), "timeout")
	var effLimit = Utils.draw_effect_out(Path + "/effects/limitCutting", position, Vector2(-95, 0), 15, 1, false, rotation)
	effLimit.show_on_top = false
	var chas = []
	for area in limitCuttingArea:
		var v = mv + area
		var cha = matCha(v)
		if cha != null and cha != self:
			chas.append(cha)
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": cha,
				"dur": 10
			})
	complexHurt(chas, att.atk * limitCutting_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

	yield(reTimer(1), "timeout")
	for i in range(10):
		var newTarget = rndChas(getAllChas(1), 1)
		if newTarget != target:
			target = newTarget
			break
	normalSpr.position = Vector2(0, -800)
	if target != null:
		Utils.draw_shadow(img, position, position + (target.position - position).normalized() * 1000, 25)
		chas = Utils.lineChas(cell, target.cell, 15)
		for cha in chas:
			if cha.team != team :
				FFHurtChara(cha, att.atk * limitCutting_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

func startP2():
	STAGE = "p2"
	aiOn = true

func justiceKicks():
	Chant.chantStart("正义飞踢", 3)
	normalSpr.position = Vector2(0, 0)
	yield(reTimer(3), "timeout")
	if STAGE == "p1":
		var CruiseChaser = sys.main.newChara("cFFXIV_BruteJustice_Hide", 2)
		sys.main.map.add_child(CruiseChaser)
		if CruiseChaser:
			CruiseChaser._onBattleStart()
		else:
			killSelf()
	startP2()

func photonGun():
	aiOn = false
	Chant.chantStart("光子炮", 3)
	yield(reTimer(3), "timeout")
	Utils.draw_effect("energyStorage", Vector2(350, 0), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("energyStorage", Vector2(150, 150), Vector2(0, 0), 13, 6)
	yield(reTimer(0.2), "timeout")
	Utils.draw_effect("energyStorage", Vector2(500, 200), Vector2(0, 0), 13, 6)

	if att.hp <= 0:
		return
	for cha in getAllChas(1):
		cha.att.hp = 1
		cha.plusHp(0, false)
	yield(reTimer(1), "timeout")
	aiOn = true

func tornado():
	aiOn = false
	Chant.chantStart("龙卷", 4)
	yield(reTimer(4), "timeout")
	Utils.draw_effect("lightBlue", position, Vector2(0, -10), 15, 10)

	if att.hp <= 0:
		return

	complexHurt(getAllChas(1), att.mgiAtk * tornado_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
	aiOn = true


func collimation():
	Chant.chantStart("照准", 4)
	yield(reTimer(4), "timeout")
	if att.hp <= 0:
		return

	var cellList = []
	for cha in getAllChas(1):
		cellList.append(cha.cell)
		var eff = Utils.draw_effect("dangerS", cha.position, Vector2(0, 0), 1, 2.5)
		eff.show_on_top = false
	yield(reTimer(2), "timeout")

	for cell in cellList:
		var pos = sys.main.map.map_to_world(cell)
		Utils.draw_effect("bombardment", pos, Vector2(0, -50), 6)
		for area in limitCuttingArea:
			var v = cell + area
			var cha = matCha(v)
			if cha != null and cha != self:
				FFHurtChara(cha, att.atk * collimation_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
