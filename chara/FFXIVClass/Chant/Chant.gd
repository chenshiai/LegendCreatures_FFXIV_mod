extends "../BaseClass.gd"

var chantBar = null
var position = Vector2(380, 45)
var chantBarUnder = ImageTexture.new()
var chantBarProgress = ImageTexture.new()
var laber = null

var allTime = 0
var nowTime = 0
var skillName = "测试文案"

func _init(position = null):
	createChantBar(position)
	pass

func createChantBar(position):
	position = position
	if position == null:
		position = Vector2(380, 45)
	chantBar = TextureProgress.new()
	laber = Label.new()

	chantBarUnder = Utils.loadImgTexture("/img/chantBar_under.png")
	chantBar.texture_under = chantBarUnder

	chantBarProgress = Utils.loadImgTexture("/img/chantBar_progress.png")
	chantBar.texture_progress = chantBarProgress

	chantBar.value = 0
	chantBar.visible = false
	chantBar.rect_position = position
	sys.main.get_node("ui").add_child(chantBar)

	laber.text = skillName
	laber.rect_position = position + Vector2(120, 5)
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
