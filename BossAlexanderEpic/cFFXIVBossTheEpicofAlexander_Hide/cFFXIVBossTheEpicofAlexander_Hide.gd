extends "../../2098858773/BossChara.gd"
var divinePunishmentRay_pw = 1.4 # 加罪罚威力
var righteousBolt_pw = 3.6 # 诛罚威力
var theSupremeJudgment_pw = 1.5 # 大审判威力
var continuousPunishment_pw = 10 # 连坐罪威力

var SKILL_TXT = """{c_base}亚历山大绝境战 最终阶段

{c_skill}[加罪罚]{/c}：{TDeath}对仇恨目标造成{c_mgi}[{1}]{/c}的小范围魔法伤害，连续使用三次
{c_skill}[诛罚]{/c}：{TDeath}对目标造成{c_phy}[{2}]{/c}的物理伤害，并附加[物理耐性下降·大]15s
{c_skill}[行动/静止命令]{/c}：[行动命令]秒杀所有静止的敌人，[静止命令]秒杀所有移动的敌人
{c_skill}[未来观测]{/c}：完美亚历山大对未来进行演算，计算如何将敌人置于死地
{c_skill}[至圣大审判]{/c}：场地上出现随机范围内的轰炸，造成{c_mgi}[{3}]{/c}的魔法伤害，并附加[易伤]15s
{c_skill}[连坐罪]{/c}：使用[至圣大审判]后，对随机目标造成{c_mgi}[{4}]{/c}的大范围魔法伤害，可分摊伤害
{c_skill}[时间牢狱]{/c}：连续落下时间牢狱，被命中的敌人时间将停止(停止攻击、CD)，若未命中敌人，则团灭所有敌人
{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知",
}

func _extInit():
	._extInit()
	chaName = "完美亚历山大"
	attCoe.atkRan = 9
	lv = 4
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt("""{c_base}龙堡内陆低地出现了一座机械城，而遥远东方草原上暮晖之民的传承中，
有着与其非常相似的金属巨人的传说。
既然如此，就以这个传说为基础编织一个故事吧。
异国的诗人让想象乘上翅膀，创作出了一首绝境的诗歌。
那是机械之神将希望托付给一名人类的故事……{/c}""")

# 必要的初始化
func _init():
	._init()
	sys.main.btChas.append(self)
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		# "divinePunishmentRay": [],
		# "righteousBolt": [],
		# "instruction": [10, 20, 30, 40],
		# "theSupremeJudgment": [10, 30, 50],
		"futureObservations": [10]
	})
	FFControl.HpBar.show()
	connect("onHurtEnd", FFControl.HpBar, "hpDown")
	connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	Utils.background_change(Path, "/background/TheEpicOfAlexander4.png")
	FFControl.FFMusic.play(Path, "/music/Orchestral.oggstr")
	call_deferred("setPos")

func setPos():
	self.get_node("ui/hpBar").visible = false
	self.show_on_top = false


func _onBattleStart():
	._onBattleStart()
	STAGE = "p4"
	var cha = matCha(Vector2(5, 3))
	if cha != null and cha.team == 1:
		FFControl.complex_move("scatter")
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 580
	divinePunishmentRay_pw *= (E_lv / E_num) # 加罪罚威力
	righteousBolt_pw *= (E_lv / E_num) # 诛罚威力
	theSupremeJudgment_pw *= (E_lv / E_num) # 大审判威力
	continuousPunishment_pw *= (E_lv / E_num) # 连坐罪威力
	pwConfig = {
		"1": "%d%%" % [divinePunishmentRay_pw * 100],
		"2": "%d%%" % [righteousBolt_pw * 100],
		"3": "%d%%" % [theSupremeJudgment_pw * 100],
		"4": "%d%%" % [continuousPunishment_pw * 100],
	}
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))
	fixed(Vector2(5, 3))


func _onBattleEnd():
	._onBattleEnd()


func _onCharaDel(cha):
	._onCharaDel(cha)

func _onHurt(atkInfo):
	._onHurt(atkInfo)

func _upS():
	._upS()
	fixed(Vector2(5, 3))


# 加罪罚
func divinePunishmentRay():
	aiOn = false
	Chant.chantStart("加罪罚", 3)
	yield(reTimer(3), "timeout")
	divine()
	yield(reTimer(1), "timeout")
	divine()
	yield(reTimer(1), "timeout")
	divine()
	aiOn = true

func divine():
	if att.hp <= 0 or self.isDeath:
		return
	Utils.draw_effect("blastYellow", aiCha.position, Vector2(0, -50), 15)
	var chas = getCellChas(aiCha.cell, 1)
	complexHurt(chas, att.mgiAtk * divinePunishmentRay_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)


# 诛罚
func righteousBolt():
	self.HateTarget = aiCha
	self.aiOn = false
	Chant.chantStart("诛罚", 5)
	yield(reTimer(5), "timeout")
	if att.hp <=0 or self.isDeath:
		self.aiOn = true
		return
	if self.HateTarget != null:
		Utils.draw_effect("thunder", self.HateTarget.position, Vector2(0, -140), 15, 2)
		FFHurtChara(self.HateTarget, att.mgiAtk * righteousBolt_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		BUFF_LIST.b_VulnerableLarge.new({"cha": self.HateTarget, "dur": 15})  
	self.aiOn = true


# 随机指令
func instruction():
	var type = sys.rndRan(0, 1)
	if type == 0:
		actionInstruction()
	else:
		staticInstruction()


# 行动指令
func actionInstruction(chant = true, observa = false):
	if chant:
		Chant.chantStart("行动指令", 3)
		yield(reTimer(3), "timeout")
	self.aiOn = false
	if att.hp <= 0 or self.isDeath:
		self.aiOn = true
		return
	for cha in getAllChas(1):
		var eff = Utils.draw_effect_v2({
			"dir": Path + "/effects/lightSword",
			"pos": cha.position + Vector2(0, -250),
			"fps": 0,
			"top": true,
			"dev": Vector2(0, -30)
		})
		eff._initFlyPos(cha.position, 500)
		if not cha.isMoveIng:
			cha.att.hp = -1
			FFHurtChara(cha, cha.att.maxHp, Chara.HurtType.MGI, Chara.AtkType.EFF)
	self.aiOn = true
	yield(reTimer(2), "timeout")
	if att.hp <= 0 or self.isDeath:
		self.aiOn = true
		return
	if observa:
		return
	staticInstruction()


# 静止指令
func staticInstruction(chant = true, observa = false):
	if chant:
		Chant.chantStart("静止指令", 3)
		yield(reTimer(3), "timeout")
	self.aiOn = false
	if att.hp <= 0 or self.isDeath:
		self.aiOn = true
		return
	for cha in getAllChas(1):
		var eff = Utils.draw_effect_v2({
			"dir": Path + "/effects/darkSword",
			"pos": cha.position + Vector2(0, -250),
			"fps": 0,
			"dev": Vector2(0, -30)
		})
		eff._initFlyPos(cha.position, 500)
		if cha.isMoveIng:
			cha.att.hp = -1
			FFHurtChara(cha, cha.att.maxHp, Chara.HurtType.MGI, Chara.AtkType.EFF)
	self.aiOn = true
	yield(reTimer(2), "timeout")
	if att.hp <= 0 or self.isDeath:
		self.aiOn = true
		return
	if observa:
		return
	staticInstruction()

func theSupremeJudgment():
	self.aiOn = false
	Chant.chantStart("至圣大审判", 4)
	yield(reTimer(4), "timeout")
	if att.hp <= 0 or self.isDeath:
		self.aiOn = true
		return
	var type = [
		{
			"pos": [Vector2(500, 50), Vector2(100, 350)],
			"area1": [Vector2(4, 0), Vector2(6, 2)],
			"area2": [Vector2(0, 3), Vector2(2, 5)],
		},
		{
			"pos": [Vector2(800, 50), Vector2(300, 350)],
			"area1": [Vector2(2, 3), Vector2(4, 5)],
			"area2": [Vector2(7, 0), Vector2(9, 2)],
		},
		{
			"pos": [Vector2(700, 350), Vector2(100, 50)],
			"area1": [Vector2(6, 3), Vector2(8, 5)],
			"area2": [Vector2(0, 0), Vector2(2, 2)],
		}
	]
	type.shuffle()
	self.aiOn = true
	for item in type:
		for pos in item.pos:
			Utils.draw_effect_v2({
				"name": "areaRect",
				"pos": pos,
				"fps": 8,
				"scale": 3,
				"top": false,
			})
		yield(reTimer(2), "timeout")

	for item in type:
		for pos in item.pos:
			Utils.draw_effect_v2({
				"dir": Path + "/effects/Judgment",
				"pos": pos,
				"fps": 10,
				"dev": Vector2(0, -70),
				"scale": 3,
			})
		var chas = []
		chas += get_area_chas("custom", item.area1[0], item.area1[1])
		chas += get_area_chas("custom", item.area2[0], item.area2[1])
		for cha in chas:
			FFHurtChara(cha, att.atk * theSupremeJudgment_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": cha,
				"dur": 10
			})
		yield(reTimer(2), "timeout")
	continuousPunishment()

# 连坐罪
func continuousPunishment():
	var chas = getAllChas(1)
	var target = rndChas(chas, 1)
	Utils.draw_effect_v2({
		"dir": Path + "/effects/share",
		"pos": target.position,
		"dev": Vector2(0, -150),
		"fps": 8,
	})
	chas = getCellChas(target.cell, 2, 1)
	for cha in chas:
		FFHurtChara(cha, att.mgiAtk * continuousPunishment_pw / chas.size(), Chara.HurtType.MGI, Chara.AtkType.SKILL)


# --------------------- 下面是未来观测的实现逻辑 --------------------
var CharaList = []
var ImgList = []
var Separation = [
	Vector2(250, 0),
	Vector2(-50, 400),
	Vector2(750, 600),
	Vector2(950, 100),
]
var positionList = [
	Vector2(350, -50),
	Vector2(250, 50),
	Vector2(250, 250),
	Vector2(250, 450),
	Vector2(450, 450),
	Vector2(650, 450),
	Vector2(750, 350),
	Vector2(750, 150),
	Vector2(750, -50),
	Vector2(550, -50),
]
# 存放未来观测的技能序列
var SkillList = []

func targetDirec(id):
	return chaData.infoDs[id].dir + "/%s" % [id]

# 未来观测！
func futureObservations():
	self.aiOn = false
	Chant.chantStart("未来观测", 4)
	yield(reTimer(5), "timeout")
	var selfPath = targetDirec(self.id)
	for pos in Separation:
		Utils.draw_effect_v2({
			"pos": pos,
			"dir": selfPath,
			"fps": 0,
			"dev": Vector2(0, -150),
			"top": false
		})
		Utils.draw_effect_v2({
			"dir": Path + "/effects/spaceTime",
			"pos": pos,
			"dev": Vector2(0, -50),
			"fps": 10,
			"scale": Vector2(-2, 2)
		})

	Chant.chantStart("未来确定", 20)
	yield(reTimer(3), "timeout")
	for cha in getAllChas(1):
		ImgList.append(b_futureObservations.new(cha, self))

	yield(reTimer(5), "timeout")
	for i in range(ImgList.size()):
		if i > positionList.size():
			break
		ImgList[i].move(positionList[i])



class b_futureObservations extends Buff:
	var Utils = globalData.infoDs["g_aFFXIVUtils"]
	func _init(cha, target):
		id = cha.id
		var chadir = chaData.infoDs[id].dir + "/%s" % [id]
		eff = Utils.draw_effect_v2({
			"pos": cha.position + Vector2(70, 0),
			"dir": chadir,
			"fps": 0,
		})
		target.addBuff(self)

	func move(position):
		var direction = position - eff.position
		var steps = direction / 10
		for i in range(10):
			yield(sys.get_tree().create_timer(0.05), "timeout")
			eff.position +=  steps
