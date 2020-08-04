extends "../../2098858773/BossChara.gd"

var divinePunishmentRay_pw = 1.5 # 神罚射线威力
var millionSacred_pw = 1.5 # 百万神圣威力
var holyJudgment_pw = 5.5 # 神圣审判威力
var lightning_pw = 1.3 # 闪电威力
var share_pw = 13 # 分摊威力

var SKILL_TXT = """{c_base}亚历山大绝境战 第三阶段

{c_skill}[时间停止]{/c}：将敌人的时间停止，并给予审判
{c_skill}[神罚射线]{/c}：{TDeath}对仇恨目标造成{c_mgi}[{1}]{/c}的小范围魔法伤害，连续使用三次
{c_skill}[十字圣礼]{/c}：朝着自身上下左右四个方向射出激光，[秒杀]被激光射中的敌人
{c_skill}[时空潜行]{/c}：随机出现在场地一边，然后释放[十字圣礼]
{c_skill}[百万神圣]{/c}：对所有敌人造成{c_mgi}[{2}]{/c}的魔法伤害
{c_skill}[神圣审判]]{/c}：狂暴灭团"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
}


func _extInit():
	._extInit()
	chaName = "至尊亚历山大"
	lv = 4
	attCoe.atkRan = 1
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))

func _init():
	._init()
	sys.main.btChas.append(self)
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		"divinePunishmentRay": [25, 55, 85, 135],
		"crossSacrament": [17, 95, 115],
		"millionSacred": [45, 77, 100, 105, 110, 160, 165],
		"TimeAndSpaceSneakingMarch": [33, 65, 145],
		"sonicBoom": [120],
		"holyJudgment": [174],
	})
	closeReward()
	FFControl.HpBar.show()
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	self.connect("onHurtEnd", FFControl.HpBar, "hpDown")
	self.scale *= 1.2
	self.show_on_top = false


func _onBattleStart():
	._onBattleStart()
	normalSpr.position = Vector2(0, 30)
	self.visible = false
	aiOn = false
	STAGE = "p3"
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 620
	divinePunishmentRay_pw *= (E_lv / E_num) # 神罚射线威力
	millionSacred_pw *= (E_lv / E_num) # 百万神圣威力
	holyJudgment_pw *= (E_lv / E_num) # 神圣审判威力
	lightning_pw *= (E_lv / E_num) # 闪电威力
	share_pw *= (E_lv / E_num) # 分摊威力
	var pwConfig = {
		"1": "%d%%" % [divinePunishmentRay_pw * 100],
		"2": "%d%%" % [millionSacred_pw * 100],
	}
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))

	cell = Vector2(5, 0)
	position = sys.main.map.map_to_world(Vector2(5, 0))
	Utils.draw_effect_v2({
		"name": "changeStage",
		"pos": Vector2(450, 200),
		"fps": 6,
		"scale": Vector2(1.25, 1.2)
	})
	yield(reTimer(1), "timeout")
	Utils.background_change(Path, "/background/TheEpicOfAlexander3.png")
	self.visible = true
	self.isDeath = true
	sonicBoom(true)


func _onDeath(atkInfo):
	._onDeath(atkInfo)
	if STAGE != "p0":
		var Alexander = sys.main.newChara("cFFXIVBossTheEpicofAlexander_Hide", 2)
		if Alexander:
			sys.main.map.add_child(Alexander)
			Alexander._onBattleStart()


func spaceTime(position):
	Utils.draw_effect_v2({
		"dir": Path + "/effects/spaceTime",
		"pos": position,
		"dev": Vector2(0, -50),
		"fps": 10,
		"scale": Vector2(-2, 2)
	})

func sonicBoom(BGM = false):
	aiOn = false
	Chant.chantStart("时间停止", 4)
	if BGM:
		FFControl.FFMusic.play(Path, "/music/無限停止.oggstr")
		spaceTime(self.position)
	var chas = getAllChas(1)
	var type = sys.rndRan(0, 1)
	var target = rndChas(chas, 1)

	yield(reTimer(1), "timeout")
	if type == 0:
		for cha in chas:
			BUFF_LIST.b_RollCall.new({"cha": cha, "dur": 6})

	elif type == 1:
		BUFF_LIST.b_Share.new({"cha": target, "dur": 6})

	yield(reTimer(3), "timeout")
	FFControl.hiddenControl()

	for cha in chas:
		BUFF_LIST.b_FrozenCdSkill.new({"cha": cha, "dur": 11})
		BUFF_LIST.b_StaticTimeUnlock.new({"cha": cha, "dur": 11})

	yield(reTimer(4), "timeout")
	if type == 0:
		lightning(chas)
	elif type == 1:
		share(target)

	yield(reTimer(6), "timeout")
	self.isDeath = false
	aiOn = true
	if BGM:
		FFControl.FFMusic.play(Path, "/music/機工城天動編.oggstr")
	FFControl.showControl()

# 闪电
func lightning(chas):
	for i in chas:
		Utils.draw_effect("ePrcC_30", i.position, Vector2(0, -50), 5, Vector2(2, 3))
		var cha = getCellChas(i.cell, 1)
		for j in cha:
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": j,
				"dur": 4
			})
			FFHurtChara(j, att.mgiAtk * lightning_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)


# 分摊
func share(target):
	# Utils.draw_effect("ePrcC_30", target.position, Vector2(0, -50), 5, 4)
	Utils.draw_effect_v2({
		"dir": Path + "/effects/share",
		"pos": target.position,
		"dev": Vector2(0, -150),
		"fps": 8,
	})
	var chas = getCellChas(target.cell, 2, 1)
	for cha in chas:
		FFHurtChara(cha, att.mgiAtk * share_pw / chas.size(), Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 神罚射线
func divinePunishmentRay():
	aiOn = false
	Chant.chantStart("神罚射线", 3)
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
	complexHurt(chas, att.mgiAtk * divinePunishmentRay_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 十字圣礼
func crossSacrament(hasChant = true):
	aiOn = false
	if hasChant:
		Chant.chantStart("十字圣礼", 3)
		yield(reTimer(3), "timeout")
		if att.hp <= 0 or self.isDeath:
			return
	var chas = Utils.lineChas(Vector2(cell.x, 0), Vector2(cell.x, 4), 6)
	chas += Utils.lineChas(Vector2(cell.x - 1, 0), Vector2(cell.x - 1, 4), 6)
	chas += Utils.lineChas(Vector2(cell.x + 1, 0), Vector2(cell.x + 1, 4), 6)
	chas += Utils.lineChas(Vector2(0, cell.y), Vector2(7, cell.y), 9)
	chas += Utils.lineChas(Vector2(0, cell.y - 1), Vector2(7, cell.y - 1), 9)
	# chas += Utils.lineChas(Vector2(0, cell.y + 1), Vector2(7, cell.y + 1), 9)
	var config = [
		{
			"dev": Vector2(75, -25),
			"ro": deg2rad(0)
		},
		{
			"dev": Vector2(75, 0),
			"ro": deg2rad(90)
		},
		{
			"dev": Vector2(75, 25),
			"ro": deg2rad(180)
		},
		{
			"dev": Vector2(75, 0),
			"ro": deg2rad(270)
		}
	]
	for item in config:
		Utils.draw_effect_v2({
			"name": "sanjiao",
			"pos": position,
			"dev": item.dev,
			"fps": 14,
			"scale": Vector2(-4.5, 2),
			"rotation": item.ro
		})
	for cha in chas:
		if cha != null and !cha.isDeath and cha.team != self.team:
			cha.att.hp = -1
			FFHurtChara(cha, att.mgiAtk * lightning_pw, Chara.HurtType.REAL, Chara.AtkType.EFF)
	yield(reTimer(2), "timeout")
	aiOn = true


# 百万神圣
func millionSacred():
	aiOn = false
	Chant.chantStart("百万神圣", 4)
	yield(reTimer(4), "timeout")
	Utils.draw_effect("lightBlue", position, Vector2(0, -10), 15, 10)

	if att.hp <= 0 or self.isDeath:
		return

	complexHurt(getAllChas(1), att.mgiAtk * millionSacred_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
	aiOn = true


# 神圣审判
func holyJudgment():
	aiOn = false
	STAGE = "p4"
	Chant.chantStart("神圣审判", 29)
	yield(reTimer(30), "timeout")
	if att.hp <= 0 or self.isDeath:
		return
	Ace() 


# 时空潜行
func TimeAndSpaceSneakingMarch():
	aiOn = false
	Chant.chantStart("时空潜行", 4)
	yield(reTimer(4), "timeout")
	spaceTime(self.position)
	self.isDeath = true
	self.visible = false
	yield(reTimer(2), "timeout")
	leftOrRight()
	spaceTime(self.position)
	self.visible = true
	yield(reTimer(2), "timeout")
	crossSacrament(false)
	yield(reTimer(2), "timeout")
	self.isDeath = false
	aiOn = true

