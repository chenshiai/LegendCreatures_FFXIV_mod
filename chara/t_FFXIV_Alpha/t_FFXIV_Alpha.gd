extends Talent
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var Path # 当前路径
var originBackground # 原版背景
var hpBar # 血条UI节点
var limitBreak # 极限技UI节点
var limitBreakLevel:int = 0 # 极限技等级
var limitBreakVal:float = 0.0 # 攒满极限技所需要的点数
var layer = 0 # 当前关卡数

const PROBABILITY = 15 # boss出现的基本概率
const BOSS_LAYER = 27 # 在多少关之后概率动态调整
var probability = PROBABILITY # Boss出现的动态概率

var allAtt = {} # 玩家数据总和
var toolman = sys.main.newChara("cFFXIV_zTatalu", 2) # 释放极限技能的工具人

var im = Image.new()
var hpBarUnder = ImageTexture.new()
var hpBarProgress = ImageTexture.new()
var limitUnder = ImageTexture.new()
var limitProgress = ImageTexture.new()
var limitProgress0 = ImageTexture.new()
var limitProgress1 = ImageTexture.new()
var limitProgress2 = ImageTexture.new()

func init():
	name = "Raid战斗记录"

func get_info():
	return """从此刻开始体验经过夸大的激昂战斗
所有敌方双攻提高%d%%，战斗后额外获得%d金币
有概率出现强大的BOSS单位！！！
BOSS战可以使用极限技能了！！！""" % [(0.1 + lv * 0.01) * 100, 25 + lv * 15]

func _connect():
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")

	Path = chaData.infoDs["cFFXIV_zTatalu"].dir
	originBackground = sys.main.get_node("scene/bg/bg").get_texture()
	progressBar()
	limitBreakButton()
	sys.newBaseMsg("极限技使用说明", """极限技，是可以扭转战局的绝招。
使用后会清空极限槽，请务必看清战场情况。
极限技可分为三种效果：
[防护]：短时间内给玩家单位减伤。
[进攻]：对敌方单体造成极大伤害。
[治疗]：为玩家单位恢复体力。
等级越高效果越强！！！""")

class Bf:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.atkL += 0.1 + lv * 0.01
		att.mgiAtkL += 0.1 + lv * 0.01

func run():
	allAtt = Utils.Calculation.getEnemyPower(2)
	limitBreakVal = (allAtt["atk"] + allAtt["mgiAtk"]) * 30
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Bf.new(lv))

func reward():
	player.plusGold(25 + lv * 15)
	sys.main.get_node("scene/bg/bg").set_texture(originBackground)
	hpBar.set_visible(false)
	resetLimit()

func come():
	layer = sys.main.guankaMsg.lvStep - 2
	if layer > BOSS_LAYER:
		if sys.rndPer(probability):
			hpBar.set_visible(true)
			hpBar.value = 100
			probability = PROBABILITY
			clear(null)
			var n = sys.rndRan(0, 2)
			match n:
				0:
					Utils.backGroundChange("SpaceTimeSlit")
					addenemy("cex___FFXIVOmegaF")
				1:
					Utils.backGroundChange("SpaceTimeSlit")
					addenemy("cex___FFXIVOmegaM")
				2:
					Utils.backGroundChange("SpaceTimeSlit1")
					addenemy("cex___FFXIVOmega")
		else:
			probability += 1
	
func progressBar():
	hpBar = TextureProgress.new()
	limitBreak = TextureProgress.new()

	im.load(Path + "/img/hpbar_under.png")
	hpBarUnder.create_from_image(im)
	hpBar.texture_under = hpBarUnder

	im.load(Path + "/img/hpbar_progress.png")
	hpBarProgress.create_from_image(im)
	hpBar.texture_progress = hpBarProgress

	im.load(Path + "/img/limitBreak_under.png")
	limitUnder.create_from_image(im)
	limitBreak.texture_under = limitUnder

	im.load(Path + "/img/limitBreak_progress0.png")
	limitProgress0.create_from_image(im)
	limitBreak.texture_progress = limitProgress0

	im.load(Path + "/img/limitBreak_progress1.png")
	limitProgress1.create_from_image(im)
	im.load(Path + "/img/limitBreak_progress2.png")
	limitProgress2.create_from_image(im)
	im.load(Path + "/img/limitBreak_progress.png")
	limitProgress.create_from_image(im)

	hpBar.value = 100
	hpBar.visible = false
	hpBar.grow_vertical = 0
	hpBar.anchor_top = 1
	hpBar.anchor_bottom = 1
	hpBar.margin_left = 50
	hpBar.margin_bottom = -23
	sys.main.get_node("kuang/NinePatchRect3").add_child(hpBar)

	limitBreak.value = 0
	limitBreak.visible = true
	limitBreak.grow_vertical = 0
	limitBreak.anchor_top = 20
	limitBreak.anchor_bottom = 1
	limitBreak.margin_left = 50
	limitBreak.margin_bottom = -7
	sys.main.get_node("kuang/NinePatchRect3").add_child(limitBreak)

func limitBreakButton():
	var config = {
		"text": "防护",
		"margin_left": 1130,
		"margin_right": 1180
	}
	Utils.createUiButton(config, self, "limit_protect")
	
	config = {
		"text": "进攻",
		"margin_left": 1185,
		"margin_right": 1235
	}
	Utils.createUiButton(config, self, "limit_attack")
	
	config = {
		"text": "治疗",
		"margin_left": 1240,
		"margin_right": 1290
	}
	Utils.createUiButton(config, self, "limit_treatment")

func clear(bosscha):
	var cha
	for i in range(0,8):
		for j in range(0,5):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null && cha.team != 1 && cha != bosscha:
				sys.main.delMatChara(cha)

func addenemy(id):
	var cha
	cha = sys.main.newChara(id, 2)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(Vector2(6, 2), cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	cha.connect("onHurtEnd", self, "hpdown")
	cha.connect("onAtkChara", self, "limitBreakUp")
	return cha

func hpdown(atkInfo):
	var cha = atkInfo.hitCha
	hpBar.value = cha.att.hp / cha.att.maxHp * 100

func limitBreakUp(atkInfo):
	if limitBreak.value < 100:
		limitBreak.value +=  clamp(atkInfo.atkVal * 100.0 / limitBreakVal, 2, 5)
		nowLimitBreak(limitBreak.value)
	pass

func resetLimit():
	limitBreakLevel = 0
	limitBreak.value = 0
	limitBreak.texture_progress = limitProgress0

func nowLimitBreak(value):
	if value >= 100:
		limitBreak.texture_progress = limitProgress
		limitBreakLevel = 3
	elif value >= 67:
		limitBreak.texture_progress = limitProgress2
		limitBreakLevel = 2
	elif value >= 33:
		limitBreak.texture_progress = limitProgress1
		limitBreakLevel = 1

func limit_protect():
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				i.addBuff(limit_protect.new(lv))
				Utils.createEffect("defense", i.position, Vector2(0, -30), 14, 2)
				yield(sys.get_tree().create_timer(0.1), "timeout")
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_attack():
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for i in sys.main.btChas:
			if i != null and i.team == 2:
				toolman.hurtChara(i, (allAtt["atk"] + allAtt["mgiAtk"]) * lv, Chara.HurtType.REAL, Chara.AtkType.SKILL)
				Utils.createEffect("fireII", i.position, Vector2(0, -60), 15, 4)
				pass
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_treatment():
	if limitBreakLevel != 0:
		var healStep = limitBreakLevel
		healStep = (healStep * healStep * 0.5 + 1.5 * healStep + 1) / 10
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				i.plusHp(i.att.maxHp * healStep)
				Utils.createEffect("heal", i.position, Vector2(0, -30), 7, 2)
				yield(sys.get_tree().create_timer(0.1), "timeout")
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

class limit_protect:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		id = "limit_protect"
		life = 10
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 1 - pow(2, lv) / 10