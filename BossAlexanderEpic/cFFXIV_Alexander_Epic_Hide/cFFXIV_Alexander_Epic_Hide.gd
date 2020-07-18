extends "../../2098858773/BossChara.gd"

var divinePunishmentRay_pw = 1.5 # 神罚射线威力
var millionSacred_pw = 1 # 百万神圣威力
var holyJudgment_pw = 5.5 # 神圣审判威力
var lightning_pw = 1 # 闪电威力
var share_pw = 4 # 分摊威力
var SKILL_TXT = """{c_base}亚历山大绝境战 第三阶段

{c_skill}[时间停止]{/c}：将敌人的时间停止，并给予审判
{c_skill}[神罚射线]{/c}：{TDeath}对仇恨目标造成[{1}]的小范围魔法伤害，连续使用三次
{c_skill}[时空潜行进行曲]{/c}：出现在场地一边，随机点名一个角色进行[结晶攻击]。然后召唤[真心]
若[真心]成功抵达了至尊亚历山大身边，则提高至尊亚历山大的攻击伤害！
若[真心]碰到了[结晶]，则会大幅度提高自身防御力。
{c_skill}[十字圣礼]{/c}：朝着自身上下左右四个方向射出激光，[秒杀]被激光射中的敌人
{c_skill}[百万神圣]{/c}：对所有敌人造成[{2}]的魔法伤害
{c_skill}[神圣审判]]{/c}：狂暴灭团"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知"
}


func _extInit():
	._extInit()
	chaName = "至尊亚历山大"
	lv = 4
	attCoe.atkRan = 2
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))

func _init():
	._init()
	sys.main.btChas.append(self)
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	set_time_axis({
		# "divinePunishmentRay": [25, 43, 66, 96, 122],
		"crossSacrament": [17, 36, 53, 77, 90, 114, 129],
		# "millionSacred": [82, 104]
	})
	closeReward()
	FFControl.HpBar.show()
	self.connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	self.connect("onHurtEnd", FFControl.HpBar, "hpDown")
	self.scale *= 1.3
	self.show_on_top = false


func _onBattleStart():
	._onBattleStart()
	self.visible = false
	aiOn = false
	STAGE = "p3"
	attInfo.maxHp = (E_atk + E_mgiAtk + layer) / E_num * 200
	skillStrs[1] = (TEXT.format(SKILL_TXT, pwConfig))

	cell = Vector2(4, 0)
	position = sys.main.map.map_to_world(Vector2(4, 0))
	Utils.draw_effect_v2({
		"name": "changeStage",
		"pos": Vector2(350, 150),
		"fps": 6,
	})
	yield(reTimer(1), "timeout")
	Utils.background_change(Path, "/background/TheEpicOfAlexander3.png")
	self.visible = true
	self.isDeath = true
	sonicBoom()

func spaceTime(position):
	Utils.draw_effect_v2({
		"dir": Path + "/effects/spaceTime",
		"pos": position,
		"dev": Vector2(0, -50),
		"fps": 10,
		"scale": Vector2(-2, 2)
	})

func sonicBoom():
	Chant.chantStart("时间停止", 4)
	FFControl.FFMusic.play(Path, "/music/無限停止.oggstr")
	var chas = getAllChas(1)
	var type = sys.rndRan(0, 1)
	var target = rndChas(chas, 1)

	yield(reTimer(1), "timeout")
	if type == 0:
		for cha in chas:
			BUFF_LIST.b_Share.new({"cha": cha, "dur": 6})

	elif type == 1:
		BUFF_LIST.b_Share.new({"cha": target, "dur": 6})

	yield(reTimer(3), "timeout")
	FFControl.hiddenControl()

	for cha in chas:
		BUFF_LIST.b_FrozenCdSkill.new({"cha": cha, "dur": 10})
		BUFF_LIST.b_StaticTimeUnlock.new({"cha": cha, "dur": 10})

	yield(reTimer(4), "timeout")
	if type == 0:
		lightning(chas)
	elif type == 1:
		share(target)

	yield(reTimer(6), "timeout")
	self.isDeath = false
	aiOn = true
	FFControl.FFMusic.play(Path, "/music/機工城天動編.oggstr")
	FFControl.showControl()

# 闪电
func lightning(chas):
	for i in chas:
		Utils.draw_effect("ePrcC_30", i.position, Vector2(0, -50), 5, 2)
		var cha = getCellChas(i.cell, 1)
		for j in cha:
			FFHurtChara(j, att.mgiAtk * lightning_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			BUFF_LIST.b_VulnerableSmall.new({
				"cha": j,
				"dur": 4
			})


# 分摊
func share(target):
	Utils.draw_effect("death", target.position, Vector2(0, -130), 10, 2)
	var chas = getCellChas(target.cell, 2, 1)
	for cha in chas:
		FFHurtChara(cha, att.mgiAtk * share_pw / chas.size(), Chara.HurtType.MGI, Chara.AtkType.SKILL)

# 神罚射线
func divinePunishmentRay():
	aiOn = false
	Chant.chantStart("神罚射线", 3)
	yield(reTimer(3), "timeout")
	divine()
	yield(reTimer(1.5), "timeout")
	divine()
	yield(reTimer(1.5), "timeout")
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
	var chas = Utils.lineChas(Vector2(cell.x, 0), Vector2(cell.x, 5), 5)
	chas += Utils.lineChas(Vector2(cell.x - 1, 0), Vector2(cell.x - 1, 5), 5)
	chas += Utils.lineChas(Vector2(cell.x + 1, 0), Vector2(cell.x + 1, 5), 5)
	chas += Utils.lineChas(Vector2(0, cell.y), Vector2(7, cell.y), 8)
	chas += Utils.lineChas(Vector2(0, cell.y - 1), Vector2(7, cell.y - 1), 8)
	chas += Utils.lineChas(Vector2(0, cell.y + 1), Vector2(7, cell.y + 1), 8)
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
			"scale": Vector2(-4, 2),
			"rotation": item.ro
		})
	for cha in chas:
		if cha != null and !cha.isDeath and cha.team != self.team:
			cha.att.hp = -1
			FFHurtChara(cha, 100, Chara.HurtType.REAL, Chara.AtkType.EFF)
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
	pass


# 时空潜行进行曲
func TimeAndSpaceSneakingMarch():
	aiOn = false
	Chant.chantStart("时空潜行进行曲", 4)
	yield(reTimer(4), "timeout")
	spaceTime(self.position)
	self.isDeath = true
	self.visible = false
	yield(reTimer(2), "timeout")
	leftOrRight()
	spaceTime(self.position)
	self.visible = true

func leftOrRight():
	if matCha(Vector2(7, 2)) == null:
		setCell(Vector2(7, 2))
		self.position = sys.main.map.map_to_world(Vector2(7, 2))
	else:
		setCell(Vector2(0, 2))
		self.position = sys.main.map.map_to_world(Vector2(0, 2))