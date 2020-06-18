var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var TEXT = globalData.infoDs["g_bFFXIVText"]
var allAtt = {}

var limitBreak = null
var limitBreakLevel:float = 0 # 极限技等级
var limitBreakVal:float = 0 # 攒满极限技所需要的点数
var limitBreakNow:float = 0 # 已有极限点数


var im = Image.new()
var limitUnder = ImageTexture.new()
var limitProgress = ImageTexture.new()
var limitProgress0 = ImageTexture.new()
var limitProgress1 = ImageTexture.new()
var limitProgress2 = ImageTexture.new()


var infomation = null
var textGrid = null


func _init():
	print("最终幻想14：—————— 极限技能加载 ——————")
	pass

func createLimitBreak():
	var Path = Utils.getPath()
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
	limitBreak.rect_position = Vector2(380, 526)
	sys.main.get_node("ui").add_child(limitBreak)

	infomation = sys.newMsg("jiangLiMsg")
	infomation.get_node("Panel/Label").text = TEXT.LimitBreakInfomation.title
	infomation.get_node("Panel/Button").connect("pressed", self, "MsgOk")
	textGrid = Label.new()
	textGrid.text = TEXT.LimitBreakInfomation.content
	infomation.get_node("Panel/CenterContainer").add_child(textGrid)
	infomation.show()

func MsgOk():
	pass

func initLimitValue():
	allAtt = Utils.Calculation.getEnemyPower(2)
	limitBreakVal = (allAtt["atk"] + allAtt["mgiAtk"]) * 30


func resetLimit():
	limitBreakLevel = 0
	limitBreakNow = 0
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
		limitBreakNow += atkInfo.atkVal
		limitBreak.value =  limitBreakNow * 100 / limitBreakVal
		nowLimitBreak(limitBreak.value)
	pass


func limit_protect():
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for cha in sys.main.btChas:
			if cha != null and cha.team == 1:
				cha.addBuff(limit_protect.new(lv))
				Utils.createEffect("shield2", cha.position, Vector2(0, -30), 14, 1)
				yield(sys.get_tree().create_timer(0.1), "timeout")
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")


func limit_attack():
	if limitBreakLevel != 0:
		var toolman = sys.main.newChara("cFFXIV_zTatalu", 2)
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for cha in sys.main.btChas:
			if cha != null and cha.team == 2:
				toolman.hurtChara(cha, (allAtt["atk"] + allAtt["mgiAtk"]) * lv, Chara.HurtType.REAL, Chara.AtkType.SKILL)
				Utils.createEffect("fireII", cha.position, Vector2(0, -40), 15, 4)
				return
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")


func limit_treatment():
	if limitBreakLevel != 0:
		var healStep = limitBreakLevel
		healStep = (healStep * healStep * 0.5 + 1.5 * healStep + 1) / 10
		yield(sys.get_tree().create_timer(0.5), "timeout")
		resetLimit()
		for cha in sys.main.btChas:
			if cha != null and cha.team == 1:
				if cha.isDeath and healStep == 3:
					# cha.isDeath = false
					cha.revive(cha.att.maxHp)

				cha.plusHp(cha.att.maxHp * healStep)
				Utils.createEffect("heal", cha.position, Vector2(0, -30), 7, 2)
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