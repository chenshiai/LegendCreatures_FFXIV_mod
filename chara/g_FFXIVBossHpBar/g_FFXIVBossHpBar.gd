var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var hpBar = null

var im = Image.new()
var hpBarUnder = ImageTexture.new()
var hpBarProgress = ImageTexture.new()

func _init():
	pass

func createHpBar():
	hpBar = TextureProgress.new()
	hpBarUnder = Utils.loadImgTexture("/img/hpbar_under.png")
	hpBar.texture_under = hpBarUnder

	hpBarProgress = Utils.loadImgTexture("/img/hpbar_progress.png")
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