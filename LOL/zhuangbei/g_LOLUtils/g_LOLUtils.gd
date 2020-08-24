var Path = ""

func _init():
	print("英雄联盟装备：—————— 全局加载完毕 ——————")
	call_deferred("dataInit")


func dataInit():
	Path = itemData.infoDs["i_JasicaLOLAhkskjyxyd"].dir
	if !Path:
		var label = Label.new()
		label.text = "英雄联盟装备：MOD文件路径读取失败，请在创意工坊内重新订阅。"
		sys.get_node("../Control").add_child(label)
		print("英雄联盟装备：MOD文件路径读取失败，请在创意工坊内重新订阅。")


func getVal(object, name, default = null):
	if object.has(name):
		return object[name]
	else:
		return default


# 加载图片纹理
# @param {string} path - mod路径
# @param {string} imgPath - mod下的图片路径
# @return {ImageTexture}
func load_texture(path, imgPath) -> ImageTexture:
	var im = Image.new()
	var imt = ImageTexture.new()
	im.load("%s%s" % [path, imgPath])
	imt.create_from_image(im)
	return imt


# 更换背景
# @param {string} path - mod路径
# @param {string} imgPath - mod下的图片路径
func bg_change(path, imgPath):
	var background = load_texture(path, imgPath)
	sys.main.get_node("scene/bg/bg").set_texture(background)


# 创建特效的，支持跨mod使用
# @param {dictionary} config -
# @param {string} config.name - 特效文件夹名（必填）
# @param {string} config.dir - 特效文件夹路径（必填） 两个必填至少有一个，优先读取name
# @param {Vector2} config.pos - 特效定位
# @param {number} config.fps - 特效播放速度（单位秒）
# @param {boolean} config.rep - 是否重复播放
# @param {Vector2} config.dev - 特效图片偏移
# @param {rad} config.rotation - 特效旋转弧度
# @param {number} config.scale - 特效缩放大小（百分比）
# @param {boolean} config.top - 是否盖住人物
# @return {Eff}
func draw_effect(config):
	var direc = ""
	if config.has("name"):
		direc =  Path + "/images/effects/" + config.name
	elif config.has("dir"):
		direc = config.dir
	var position = getVal(config, "pos", Vector2(350, 150))
	var frame = getVal(config, "fps", 15)
	var repeat = getVal(config, "rep", false)

	var eff = sys.newEff("animEff", position)
	eff.setImgs(direc, frame, repeat)
	eff.normalSpr.position = getVal(config, "dev", Vector2(0, 0))
	eff.rotation = getVal(config, "rotation", deg2rad(0))
	eff.scale *= getVal(config, "scale", 1)
	eff.show_on_top = getVal(config, "top", true)
	return eff


# 绘制残影
# @param {Image} img - 目标图片
# @param {Vector2} startPositon - 起点
# @param {Vector2} endPositon - 终点
# @param {number} speed - 消逝速度
func draw_shadow(img, startPositon, endPositon, speed = 25):
	var distance = endPositon - startPositon
	var rs = preload("res://core/ying.tscn")
	var n = distance.length() / speed
	var texture = img.texture_normal
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = texture
		spr.position = startPositon + speed * (i + 1) * distance.normalized() - Vector2(texture.get_width() / 2, texture.get_height())
		spr.init(255 / n * i + 100)


# -------------------- 地面选取 ---------------------------
func get_area_chas(type, x = Vector2(0, 1), y = Vector2(0, 1)):
	var chas = []
	var x1 = 0
	var x2 = 0
	var y1 = 0
	var y2 = 0
	match type:
		"left_top":
			x1 = 0
			x2 = 4
			y1 = 0
			y2 = 2
		"left_bottom":
			x1 = 0
			x2 = 4
			y1 = 3
			y2 = 6
		"right_top":
			x1 = 5
			x2 = 10
			y1 = 0
			y2 = 2
		"right_bottom":
			x1 = 5
			x2 = 10
			y1 = 2
			y2 = 3
		"custom":
			x1 = x.x
			x2 = y.x
			y1 = x.y
			y2 = y.y
	for i in range(x1, x2 + 1):
		for j in range(y1, y2 + 1):
			var cha = sys.main.matCha(Vector2(i, j))
			if cha != null:
				chas.append(cha)
	return chas