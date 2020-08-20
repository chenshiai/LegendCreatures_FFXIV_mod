var Path = ""
# 镭射攻击，实体攻击，暗物质攻击，光线攻击，电能攻击，振动攻击
enum AtkType { LASER = 64, BULLET, DARK, LIGHT, ELECTRIC, VIBRATE }

func _init():
	print("Novea：—————— 诺维亚空间构建中 ——————")
	call_deferred("dataInit")


func dataInit():
	Path = chaData.infoDs["cNovea_robot_Hide"].dir
	if !Path:
		var label = Label.new()
		label.text = "Novea：MOD文件路径读取失败，请在创意工坊内重新订阅。"
		sys.get_node("../Control").add_child(label)
		print("Novea：MOD文件路径读取失败，请在创意工坊内重新订阅。")


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