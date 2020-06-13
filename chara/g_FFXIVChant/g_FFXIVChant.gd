var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var chantBar = null

var im = Image.new()
var chantBarUnder = ImageTexture.new()
var chantBarProgress = ImageTexture.new()
var laber = null

var allTime = 0
var nowTime = 0
var skillName = "测试文案"


func _init():
	print("最终幻想14：—————— 魔法正在咏唱 ——————")
	pass

func createChantBar():
	var Path = Utils.getPath()
	chantBar = TextureProgress.new()
	laber = Label.new()
	im.load(Path + "/img/chantBar_under.png")
	chantBarUnder.create_from_image(im)
	chantBar.texture_under = chantBarUnder

	im.load(Path + "/img/chantBar_progress.png")
	chantBarProgress.create_from_image(im)
	chantBar.texture_progress = chantBarProgress

	chantBar.value = 0
	chantBar.visible = false
	chantBar.rect_position = Vector2(380, 45)
	sys.main.get_node("ui").add_child(chantBar)

	laber.text = skillName
	laber.rect_position = Vector2(380, 50)
	sys.main.get_node("ui").add_child(laber)
	laber.visible = false

func chantStart(text, duration):
	chantBar.set_visible(true)
	laber.visible = true
	laber.text = "%s %.1f" % [text, duration]
	var n = duration
	for i in range(n * 10):
		yield(sys.get_tree().create_timer(0.1), "timeout")
		duration -= 0.1
		chantBar.value = 100 - (duration / n) * 100
		laber.text = "%s %.1f" % [text, duration]

	chantBar.set_visible(false)
	laber.visible = false
	chantBar.value = 0
