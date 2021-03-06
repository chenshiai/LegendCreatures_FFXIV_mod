extends "../BaseClass.gd"

var Chant
var allAtt = {}
var isLock = false # 极限技锁
var limitBreak = null
var limitBreakLevel:float = 0 # 极限技等级
var limitBreakVal:float = 1000 # 攒满极限技所需要的点数
var limitBreakNow:float = 0 # 已有极限点数

var limitUnder = ImageTexture.new()
var limitProgress = ImageTexture.new()
var limitProgress0 = ImageTexture.new()
var limitProgress1 = ImageTexture.new()
var limitProgress2 = ImageTexture.new()

func _init():
	draw_limitBreak()
	pass

func draw_limitBreak():
	Chant = Utils.FFXIVClass.Chant.new(Vector2(400, 500))
	limitBreak = TextureProgress.new() # 极限技UI节点

	limitUnder = Utils.load_texture(Utils.Path, "/img/limitBreak_under.png")

	limitProgress0 = Utils.load_texture(Utils.Path, "/img/limitBreak_progress0.png")

	limitProgress1 = Utils.load_texture(Utils.Path, "/img/limitBreak_progress1.png")
	limitProgress2 = Utils.load_texture(Utils.Path, "/img/limitBreak_progress2.png")
	limitProgress = Utils.load_texture(Utils.Path, "/img/limitBreak_progress.png")

	limitBreak.set_under_texture(limitUnder)
	limitBreak.set_progress_texture(limitProgress0)
	limitBreak.set_max(1000)
	limitBreak.set_step(0.01)
	limitBreak.set_min(0)
	limitBreak.set_value(0)
	limitBreak.set_visible(true)
	limitBreak.set_position(Vector2(380, 626))
	sys.main.get_node("ui").add_child(limitBreak)


func init_limitBreak():
	var layer = sys.main.guankaMsg.lvStep
	allAtt = Utils.Calculation.getEnemyPower(2)
	limitBreakVal = (allAtt["atk"] + allAtt["mgiAtk"] + layer + 40) * 50


func reset_limitBreak():
	limitBreakLevel = 0
	limitBreakNow = 0
	limitBreak.set_value(0)
	limitBreak.set_progress_texture(limitProgress0)
	isLock = false


func set_limitBreak_level(value):
	if value >= 1000:
		limitBreak.set_progress_texture(limitProgress)
		limitBreakLevel = 3
	elif value >= 667:
		limitBreak.set_progress_texture(limitProgress2)
		limitBreakLevel = 2
	elif value >= 333:
		limitBreak.set_progress_texture(limitProgress1)
		limitBreakLevel = 1


func limitBreak_up(atkInfo):
	if limitBreak.value < 1000 and atkInfo.atkCha != atkInfo.hitCha:
		limitBreakNow += atkInfo.atkVal
		limitBreak.set_value(limitBreakNow * 1000 / limitBreakVal)
		set_limitBreak_level(limitBreak.value)


func use_limitBreak(type):
	if limitBreakLevel != 0:
		var lv = limitBreakLevel
		if isLock:
			return
		isLock = true
		match type:
			"protect": limit_protect(lv)
			"attack": limit_attack(lv)
			"treatment": limit_treatment(lv)
	else:
		sys.newBaseMsg("无法释放!", "极限技槽还没有满一格！！！")
	

func limit_protect(lv):
	Chant.chantStart("极限技-防护", 1)
	yield(sys.get_tree().create_timer(1), "timeout")
	reset_limitBreak()
	for cha in sys.main.btChas:
		if cha != null and cha.team == 1 and !cha.isDeath:
			cha.addBuff(limit_protect.new(lv))
			Utils.draw_effect("shield2", cha.position, Vector2(0, -30), 14, 1)
			yield(sys.get_tree().create_timer(0.1), "timeout")


func limit_attack(lv):
	var toolman = sys.main.newChara("cFFXIV_Tatalu", 1)
	toolman.name = "极限技"
	Chant.chantStart("极限技-进攻", 1)
	yield(sys.get_tree().create_timer(1), "timeout")
	reset_limitBreak()
	for cha in sys.main.btChas:
		if cha != null and cha.team == 2 and !cha.isDeath:
			toolman.hurtChara(cha, (allAtt["atk"] + allAtt["mgiAtk"]) * lv, Chara.HurtType.REAL, Chara.AtkType.SKILL)
			Utils.draw_effect("fireII", cha.position, Vector2(0, -40), 15, 4)
			return
	toolman.queue_free()


func limit_treatment(lv):
	lv = (lv * lv * 0.5 + 1.5 * lv + 1) / 10
	Chant.chantStart("极限技-治疗", 1)
	yield(sys.get_tree().create_timer(1), "timeout")
	reset_limitBreak()
	for cha in sys.main.btChas:
		if cha != null and cha.team == 1:
			if !cha.isDeath:
				cha.plusHp(cha.att.maxHp * lv)
			elif lv == 1:
				cha.isDeath = false
				cha.anim.play("del", 100)
				cha.plusHp(cha.att.maxHp)
				cha.revive(cha.att.maxHp)
				cha.set_visible(true)
				cha.aiOn = true
			yield(sys.get_tree().create_timer(0.1), "timeout")


class limit_protect	extends Buff:
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