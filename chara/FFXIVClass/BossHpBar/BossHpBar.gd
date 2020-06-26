extends "../BaseClass.gd"

var hpBar = null

var im = Image.new()
var hpBarUnder = ImageTexture.new()
var hpBarProgress = ImageTexture.new()

func _init():
	createHpBar()
	pass

func createHpBar():
	hpBar = TextureProgress.new()
	hpBarUnder = Utils.load_texture(Utils.Path, "/img/hpbar_under.png")
	hpBar.set_under_texture(hpBarUnder)

	hpBarProgress = Utils.load_texture(Utils.Path, "/img/hpbar_progress.png")
	hpBar.set_progress_texture(hpBarProgress)

	hpBar.set_max(10000)
	hpBar.set_min(0)
	hpBar.set_step(0.01)
	hpBar.set_value(0)
	hpBar.set_visible(false)
	hpBar.grow_vertical = 0
	hpBar.anchor_top = 1
	hpBar.anchor_bottom = 1
	hpBar.margin_left = 50
	hpBar.margin_bottom = -17
	sys.main.get_node("kuang/NinePatchRect3").add_child(hpBar)

func show():
	hpBar.set_visible(true)
	hpBar.set_value(10000)

func hidden():
	hpBar.set_visible(false)

func hpDown(atkInfo:AtkInfo):
	var cha = atkInfo.hitCha
	hpBar.set_value(cha.att.hp * 10000 / cha.att.maxHp)