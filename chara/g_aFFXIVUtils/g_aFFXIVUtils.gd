var handle = sys.get_node("../Control")
var Path = null

func _init():
	print("最终幻想14：—————— 完整性检测中 ——————")
	call_deferred("testInit")
	pass


func _ready():
	pass


func getPath():
	return Path


func testInit():
	Path = chaData.infoDs["cFFXIV_zTatalu"].dir
	if Path != null:
		pass
	else:
		var label = Label.new()
		label.text = "最终幻想14：BUFF列表读取失败！请在创意工坊内重新订阅"
		print(label.text)
		handle.add_child(label)


func loadImgTexture(imgPath):
	var im = Image.new()
	var imt = ImageTexture.new()
	im.load(Path + imgPath)
	imt.create_from_image(im)
	return imt


func backGroundChange(imgPath):
	sys.main.get_node("scene/bg/bg").set_texture(loadImgTexture(imgPath))


func createEffect(effectName:String, position:Vector2, deviation:Vector2, frame = 15, scale = 1, repeat = false): 
	var eff = sys.newEff("animEff", position)
	var direc = Path + "/effects/" + effectName
	eff.setImgs(direc, frame, repeat)
	eff.normalSpr.position = deviation
	eff.scale *= scale
	return eff


func createTimeAxis(skillAxis):
	var timeAxis = {}
	for skillName in skillAxis:
		for timePoint in skillAxis[skillName]:
			timeAxis[timePoint] = skillName
	return timeAxis


func createUiButton(text, position, target = self, callback = "defaultCallback", config = {}):
	var button = Button.new()
	button.text = text
	button.rect_position = position

	if config.has("set_size"):
		button.set_size = config["set_size"]
	if config.has("margin_left"):
		button.margin_left = config["margin_left"]
	if config.has("margin_right"):
		button.margin_right = config["margin_right"]
	if config.has("margin_top"):
		button.margin_top = config["margin_top"]
	if config.has("margin_bottom"):
		button.margin_bottom = config["margin_bottom"]

	button.connect("pressed", target, callback)
	sys.main.get_node("ui").add_child(button)
	return button


func defaultCallback():
	sys.newBaseMsg("测试", "并未连接到任何函数")

func createShadow(img, startPositon:Vector2, endPositon:Vector2, speed = 25):
	var distance = endPositon - startPositon
	var rs = preload("res://core/ying.tscn")
	var n = distance.length() / speed
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = img.texture_normal
		spr.position = startPositon + speed * (i + 1) * distance.normalized() - Vector2(img.texture_normal.get_width() / 2, img.texture_normal.get_height())
		spr.init(255 / n * i + 100)

# 数据处理类
class Calculation:
	static func sort_MaxMgiAtk(a, b):
		if a.att.mgiAtk > b.att.mgiAtk:
			return true
		return false

	static func sort_MaxAtk(a, b):
		if a.att.atk > b.att.atk:
			return true
		return false
	
	static func sort_MinHpP(a, b):
		if (a.att.hp / a.att.maxHp) < (b.att.hp / b.att.maxHp):
			return true
		return false

	static func sort_MinHp(a, b):
		if a.att.hp < b.att.hp:
			return true
		return false

	static func getEnemyPower(team):
		var att = {
			"maxHp": 0,
			"atk": 0,
			"mgiAtk": 0,
			"def": 0,
			"mgiDef": 0,
			"lv": 0,
			"spd": 0,
			"num": 0
		}

		for i in sys.main.btChas:
			if i.team != team:
				att.maxHp += i.att.maxHp
				att.atk += i.att.atk
				att.mgiAtk += i.att.mgiAtk
				att.def += i.att.def
				att.mgiDef += i.att.mgiDef
				att.spd += i.att.spd
				att.lv += i.lv
				att.num += 1

		return att