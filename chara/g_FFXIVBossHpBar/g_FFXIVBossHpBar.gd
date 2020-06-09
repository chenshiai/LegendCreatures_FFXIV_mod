const Utils = load("g_aFFXIVUtils") # 全局工具
var hpBar = null

var im = Image.new()
var hpBarUnder = ImageTexture.new()
var hpBarProgress = ImageTexture.new()

func _init():
	print("最终幻想14：—————— 高难机制加载 ——————")
	pass

func createHpBar():
	const Path = Utils.getPath()
	hpBar = TextureProgress.new()
	im.load(Path + "/img/hpbar_under.png")
	hpBarUnder.create_from_image(im)
	hpBar.texture_under = hpBarUnder

	im.load(Path + "/img/hpbar_progress.png")
	hpBarProgress.create_from_image(im)
	hpBar.texture_progress = hpBarProgress

	hpBar.value = 100
	hpBar.visible = false
	hpBar.grow_vertical = 0
	hpBar.anchor_top = 1
	hpBar.anchor_bottom = 1
	hpBar.margin_left = 50
	hpBar.margin_bottom = -17
	sys.main.get_node("kuang/NinePatchRect3").add_child(hpBar)

func setVisible(switch):
  hpBar.set_visible(switch)

func setValue(value = 100):
  hpBar.value = value

func hpDown(atkInfo:AtkInfo):
  var cha = atkInfo.hitCha
  hpBar.value = cha.att.hp / cha.att.maxHp * 100