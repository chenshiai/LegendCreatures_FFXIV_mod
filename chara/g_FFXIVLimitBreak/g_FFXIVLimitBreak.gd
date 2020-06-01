# 这个文件尚未完成迁移
# 暂时没有使用
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var Path = Utils.Path

var im = Image.new()
var limitUnder = ImageTexture.new()
var limitProgress = ImageTexture.new()
var limitProgress0 = ImageTexture.new()
var limitProgress1 = ImageTexture.new()
var limitProgress2 = ImageTexture.new()

var limitBreak # 极限技UI节点
var limitBreakLevel:float = 0 # 极限技等级
var limitBreakVal:float = 0 # 攒满极限技所需要的点数

func _init():
	print("最终幻想14：---------极限技功能加载-----------")
	pass

func testInit():
	pass

func createLimitBreak():
	limitBreak = TextureProgress.new()

	im.load(Path + "/img/limitBreak_progress0.png")
	limitProgress0.create_from_image(im)
	limitBreak.texture_progress = limitProgress0

	im.load(Path + "/img/limitBreak_progress1.png")
	limitProgress1.create_from_image(im)
	im.load(Path + "/img/limitBreak_progress2.png")
	limitProgress2.create_from_image(im)
	im.load(Path + "/img/limitBreak_progress.png")
	limitProgress.create_from_image(im)

	limitBreak.value = 0.0
	limitBreak.visible = true
	limitBreak.grow_vertical = 0
	limitBreak.anchor_top = 20
	limitBreak.anchor_bottom = 1
	limitBreak.margin_left = 50
	limitBreak.margin_bottom = -7
	sys.main.get_node("kuang/NinePatchRect3").add_child(limitBreak)

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

func reset():
	limitBreakLevel = 0
	limitBreak.value = 0
	limitBreak.texture_progress = limitProgress0

func now(value):
	if value >= 100:
		limitBreak.texture_progress = limitProgress
		limitBreakLevel = 3
	elif value >= 67:
		limitBreak.texture_progress = limitProgress2
		limitBreakLevel = 2
	elif value >= 33:
		limitBreak.texture_progress = limitProgress1
		limitBreakLevel = 1

func limitBreakUp():
	pass

func limit_protect():
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(1.0), "timeout")
		reset()
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				i.addBuff(limit_protect.new(lv))
				Utils.createEffect("defense", i.position, Vector2(0, -60), 14)
				yield(sys.get_tree().create_timer(0.1), "timeout")
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_attack(allAtt, toolman):
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		yield(sys.get_tree().create_timer(1.0), "timeout")
		reset()
		for i in sys.main.btChas:
			if i != null and i.team == 2:
				toolman.hurtChara(i, (allAtt["atk"] + allAtt["mgiAtk"]) * lv, Chara.HurtType.REAL, Chara.AtkType.SKILL)
				Utils.createEffect("fireII", i.position, Vector2(0, -60), 15, 2)
				pass
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")

func limit_treatment():
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		var h:float = lv
		h = (h * h * 0.5 + 1.5 * h + 1) / 10
		yield(sys.get_tree().create_timer(1.0), "timeout")
		reset()
		for i in sys.main.btChas:
			if i != null and i.team == 1:
				i.plusHp(i.att.maxHp * h)
				Utils.createEffect("heal", i.position, Vector2(0, -30), 7)
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