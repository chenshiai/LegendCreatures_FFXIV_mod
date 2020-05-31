extends Talent
var Utils = globalData.infoDs["g_FFXIVUtils"]
var Path
var originBackground
var hpBar # 血条UI节点
var limitBreak # 极限技UI节点
var limitBreakLevel = 0 # 极限技等级
var limitBreakVal = 0 # 攒满极限技所需要的点数
var layer = 0 # 当前关卡数
var probability = 100 # boss出现概率

var allAtt = {}
var toolman = sys.main.newChara("cex___FFXIVBaseChara", 2)

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
	limitBreakVal = (allAtt["atk"] + allAtt["mgiAtk"]) * 40
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
	if sys.rndPer(probability) && layer > 1:
		hpBar.set_visible(true)
		hpBar.value = 100
		probability = 10
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
	elif layer > 27:
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
	var protectBtn = Button.new()
	protectBtn.text = "防护"
	protectBtn.margin_left = 1130
	protectBtn.margin_right = 1180
	sys.main.get_node("ui").add_child(protectBtn)
	protectBtn.connect("pressed", self, "limit_protect")

	var attackBtn = Button.new()
	attackBtn.text = "进攻"
	attackBtn.margin_left = 1180
	attackBtn.margin_right = 1230
	sys.main.get_node("ui").add_child(attackBtn)
	attackBtn.connect("pressed", self, "limit_attack")

	var treatmentBtn = Button.new()
	treatmentBtn.text = "治疗"
	treatmentBtn.margin_left = 1230
	treatmentBtn.margin_right = 1280
	sys.main.get_node("ui").add_child(treatmentBtn)
	treatmentBtn.connect("pressed", self, "limit_treatment")

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
	return cha

func hpdown(atkInfo):
	var cha = atkInfo.hitCha
	hpBar.value = cha.att.hp / cha.att.maxHp * 100
	if limitBreak.value < 100:
		limitBreak.value += atkInfo.atkVal * 200 / limitBreakVal

	if limitBreak.value >= 100:
		limitBreak.texture_progress = limitProgress
		limitBreakLevel = 3
	elif limitBreak.value >= 67:
		limitBreak.texture_progress = limitProgress2
		limitBreakLevel = 2
	elif limitBreak.value >= 33:
		limitBreak.texture_progress = limitProgress1
		limitBreakLevel = 1

func resetLimit():
	limitBreakLevel = 0
	limitBreak.value = 0
	limitBreak.texture_progress = limitProgress0

func limit_protect():
	if limitBreakLevel != 0:
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				yield(Chara.reTimer(0.1), "timeout")
				i.addBuff(limit_protect.new(limitBreakLevel))
				Utils.createEffect("defense", i.position, Vector2(0, -60), 14)
		resetLimit()
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_attack():
	if limitBreakLevel != 0:
		for i in sys.main.btChas:
			if i != null and i.team == 2:
				Utils.createEffect("fireII", i.position, Vector2(0, -60), 15, 2)
				toolman.hurtChara(i, (allAtt["atk"] + allAtt["mgiAtk"]) * limitBreakLevel, Chara.HurtType.REAL, Chara.AtkType.SKILL)
				pass
		resetLimit()
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_treatment():
	if limitBreakLevel != 0:
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				yield(Chara.reTimer(0.1), "timeout")
				i.plusHp(i.att.maxHp * 0.33 * limitBreakLevel)
				Utils.createEffect("heal", i.position, Vector2(0, -30), 7)
		resetLimit()
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
		atkInfo.hurtVal *= 0.3 * lv

	func _upS():
		life = clamp(life, 0, 10)
		if life <= 1:
			life = 0