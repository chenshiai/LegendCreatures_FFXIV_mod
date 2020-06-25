var handle = sys.get_node("../Control")
var Path = null
var FFXIVClass = null
var FFControl = null

func _init():
	print("最终幻想14：—————— 完整性检测中 ——————")
	call_deferred("dataInit")
	pass

func dataInit():
	Path = chaData.infoDs["cFFXIV_zTatalu"].dir
	if Path != null:
		FFXIVClass = load(Path + "/FFXIVClass/FFXIVClass.gd").new()
	else:
		var label = Label.new()
		label.text = "最终幻想14：MOD文件路径读取失败，请在创意工坊内重新订阅。"
		handle.add_child(label)

func initFFControl():
	if FFControl == null:
		FFControl = FFXIVClass.FFControl.new()
		sys.main.connect("tree_exited", self, "gameExit")
	return FFControl

# 返回标题释放控制器实例
func gameExit():
	FFControl = null


# 如果是mod本体图片加载，则自动拼接Path
# 如果不是mod本体图片加载，则imgPath应当为完整的绝对路径
func load_texture(imgPath, local = true):
	var im = Image.new()
	var imt = ImageTexture.new()

	if local:
		im.load(Path + imgPath)
	else:
		im.load(imgPath)
	imt.create_from_image(im)
	return imt


# 更换背景
func background_change(imgPath, local = true):
	sys.main.get_node("scene/bg/bg").set_texture(load_texture(imgPath, local))


# 创建本体的自定义特效
func draw_effect(effectName, position, deviation, frame = 15, scale = 1, repeat = false, rotation = deg2rad(0)): 
	var eff = sys.newEff("animEff", position)
	var direc = Path + "/effects/" + effectName
	eff.setImgs(direc, frame, repeat)
	eff.normalSpr.position = deviation
	eff.rotation = rotation
	eff.scale *= scale
	return eff


# 创建非本体的自定义特效
func draw_effect_out(effdirec, position, deviation, frame = 15, scale = 1, repeat = false, rotation = deg2rad(0)): 
	var eff = sys.newEff("animEff", position)
	eff.setImgs(effdirec, frame, repeat)
	eff.normalSpr.position = deviation
	eff.rotation = rotation
	eff.scale *= scale
	return eff


# 浮动文字特效
func draw_efftext(text, position, deviation, color = "#ffffff", speed = 0):
	var eff = sys.newEff("numHit", position)
	var dev = 0
	eff.normalSpr.position = deviation
	eff.scale.x *= -1
	eff.setText(text, color)
	eff.anim.set_speed_scale(0)
	while dev < 10:
		dev += 1
		eff.normalSpr.position = deviation + Vector2(0, -3) * dev
		yield(sys.get_tree().create_timer(0.1), "timeout")
	eff.queue_free()


# 创建Boss时间轴
func create_timeAxis(skillAxis):
	var timeAxis = {}
	for skillName in skillAxis:
		for timePoint in skillAxis[skillName]:
			timeAxis[timePoint] = skillName
	return timeAxis


# 绘制按钮UI
func draw_ui_button(
		text,
		position,
		target = self,
		callback = "defaultCallback",
		config = {
			"args": [],
			"return": false
		}
	):
	# 这个默认值过于愚蠢
	var args = []
	if config.has("args"):
		args = config.args
	
	var button = Button.new()
	button.text = text
	button.rect_position = position
	button.connect("pressed", target, callback, args)

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
	if config.has("return") and config["return"]:
		return button
	else:
		sys.main.get_node("ui").add_child(button)


func defaultCallback():
	sys.newBaseMsg("测试", "并未连接到任何函数")


# 绘制残影
func draw_shadow(img, startPositon:Vector2, endPositon:Vector2, speed = 25):
	var distance = endPositon - startPositon
	var rs = preload("res://core/ying.tscn")
	var n = distance.length() / speed
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = img.texture_normal
		spr.position = startPositon + speed * (i + 1) * distance.normalized() - Vector2(img.texture_normal.get_width() / 2, img.texture_normal.get_height())
		spr.init(255 / n * i + 100)


# 获取直线范围的角色
func lineChas(aCell, bCell, num):
	var toolman = sys.main.newChara("cFFXIV_zTatalu", 2)
	var chas = []
	var aPos = sys.main.map.map_to_world(aCell)
	var bPos = sys.main.map.map_to_world(bCell)
	var n = (bPos - aPos).normalized()
	var oldCell = null
	for i in range(num):
		var ac = sys.main.map.world_to_map(aPos)
		aPos += n * 100
		if oldCell != ac :
			oldCell = ac
			if toolman.matCha(ac) != null:
				chas.append(toolman.matCha(ac))
	return chas

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

	static func sort_MaxDefAndMgiDef(a, b):
		if (a.att.def + a.att.mgiDef) > (b.att.def + b.att.mgiDef):
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

# 文件路径遍历
class FileHelper:
	static func scan(path:String) -> Array:
		var file_name := ""
		var files := []
		var dir := Directory.new()
		if dir.open(path) != OK:
			print("Failed to open:" + path)
		else:
			dir.list_dir_begin(true)
			file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					var sub_path = path + "/" + file_name
					files += scan(sub_path)
				else:
					var name := path + "/" + file_name
					files.push_back(name)
				file_name = dir.get_next()
			dir.list_dir_end()
		return files