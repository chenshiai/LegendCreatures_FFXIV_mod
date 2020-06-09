const Utils = load("g_aFFXIVUtils") # 全局工具
var allAtt = {}

var limitBreak = null
var limitBreakLevel:float = 0 # 极限技等级
var limitBreakVal:float = 0 # 攒满极限技所需要的点数

var im = Image.new()
var limitUnder = ImageTexture.new()
var limitProgress = ImageTexture.new()
var limitProgress0 = ImageTexture.new()
var limitProgress1 = ImageTexture.new()
var limitProgress2 = ImageTexture.new()

func _init():
	print("最终幻想14：—————— 极限技能加载 ——————")
	pass

func createLimitBreak():
	const Path = Utils.getPath()
	limitBreak = TextureProgress.new() # 极限技UI节点

	limitUnder = Utils.loadImgTexture("/img/limitBreak_under.png")
	limitBreak.texture_under = limitUnder

	limitProgress0 = Utils.loadImgTexture("/img/limitBreak_progress0.png")
	limitBreak.texture_progress = limitProgress0

	limitProgress1 = Utils.loadImgTexture("/img/limitBreak_progress1.png")
	limitProgress2 = Utils.loadImgTexture("/img/limitBreak_progress2.png")
	limitProgress = Utils.loadImgTexture("/img/limitBreak_progress.png")

	limitBreak.value = 0
	limitBreak.visible = true
	limitBreak.rect_position = Vector2(380, 528)
	sys.main.get_node("ui").add_child(limitBreak)

	Utils.createUiButton("防护", Vector2(1140, 250), self, "limit_protect", {})
	Utils.createUiButton("进攻", Vector2(1140, 305), self, "limit_attack", {})
	Utils.createUiButton("治疗", Vector2(1140, 360), self, "limit_treatment", {})


func initLimitValue():
	allAtt = Utils.Calculation.getEnemyPower(2)
	limitBreakVal = (allAtt["atk"] + allAtt["mgiAtk"]) * 30


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


func limitBreakUp(atkInfo):
	if limitBreak.value < 100:
		limitBreak.value +=  clamp(atkInfo.atkVal * 100.0 / limitBreakVal, 2, 5)
		nowLimitBreak(limitBreak.value)
	pass


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
		var toolman = sys.main.newChara("cFFXIV_zTatalu", 2)
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for i in sys.main.btChas:
			if i != null and i.team == 2:
				toolman.hurtChara(i, (allAtt["atk"] + allAtt["mgiAtk"]) * lv, Chara.HurtType.REAL, Chara.AtkType.SKILL)
				Utils.createEffect("fireII", i.position, Vector2(0, -40), 15, 4)
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