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
	position = position # 这语句好像是多余的
	if position == null:
		position = Vector2(380, 45)
	chantBar = TextureProgress.new()
	laber = Label.new()

	chantBarUnder = Utils.loadImgTexture("/img/chantBar_under.png")
	chantBar.set_under_texture(chantBarUnder)

	chantBarProgress = Utils.loadImgTexture("/img/chantBar_progress.png")
	chantBar.set_progress_texture(chantBarProgress)
	chantBar.set_step(0.1)
	chantBar.set_value(0)
	chantBar.set_visible(false) 
	chantBar.rect_position = position
	sys.main.get_node("ui").add_child(chantBar)

	laber.text = skillName
	laber.rect_position = position + Vector2(120, 5)
	sys.main.get_node("ui").add_child(laber)
	laber.set_visible(false) 

func chantStart(text, duration):
	var n = duration
	chantBar.set_max(n)
	chantBar.set_visible(true)
	laber.set_visible(true) 
	laber.text = "%s %.1f" % [text, duration]

	for i in range(n * 10):
		duration -= 0.1
		chantBar.set_value(n - duration)
		laber.text = "%s %.1f" % [text, duration]
		yield(sys.get_tree().create_timer(0.1), "timeout")

	chantBar.set_visible(false)
	laber.set_visible(false) 
	chantBar.set_value(0)
