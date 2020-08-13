# 最终幻想14 工具类
# 版本号 0.1.4
# 修改时间 2020/07/13
# 描述：集合了一些比较常用的方法和变量
var Path = null
var FFXIVClass = null
var FFControl = null

var infomation = null
var textGrid = null


func _init():
	print("最终幻想14：—————— 完整性检测中 ——————")
	call_deferred("dataInit")


func dataInit():
	Path = chaData.infoDs["cFFXIV_Tatalu"].dir
	if Path != null:
		FFXIVClass = load(Path + "/FFXIVClass/FFXIVClass.gd").new()
	else:
		var label = Label.new()
		label.text = "最终幻想14：MOD文件路径读取失败，请在创意工坊内重新订阅。"
		sys.get_node("../Control").add_child(label)


# 返回控制器实例
# 没有实例则新建一个实例再返回
func getFFControl():
	if FFControl == null:
		FFControl = FFXIVClass.FFControl.new()
		sys.main.connect("tree_exited", self, "gameExit")
	return FFControl


# 返回标题时
# 释放控制器实例以及信息面板实例
func gameExit():
	FFControl = null
	infomation = null
	textGrid = null


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
func background_change(path, imgPath):
	var background = load_texture(path, imgPath)
	sys.main.get_node("scene/bg/bg").set_texture(background)


# 创建mod本体拥有的特效
# @param {string} effctName - 特效文件夹名
# @param {Vector2} position - 特效生成定位
# @param {Vector2} deviation - 特效图片偏移
# @param {number} frame - 特效播放速度（单位秒）
# @param {number} scale - 特效缩放大小（百分比）
# @param {boolean} repeat - 是否重复播放
# @param {rad} rotation - 特效旋转弧度
# @return {Eff}
func draw_effect(
		effectName,
		position,
		deviation,
		frame = 15,
		scale = 1,
		repeat = false,
		rotation = deg2rad(0)
	):
	var eff = sys.newEff("animEff", position)
	var direc = Path + "/effects/" + effectName
	eff.setImgs(direc, frame, repeat)
	eff.normalSpr.position = deviation
	eff.rotation = rotation
	eff.scale *= scale
	return eff


# 创建跨mod的特效
# @param {string} effdirec - 特效文件夹路径
# 其余参数同上
func draw_effect_out(
		effdirec,
		position,
		deviation,
		frame = 15,
		scale = 1,
		repeat = false,
		rotation = deg2rad(0)
	):
	var eff = sys.newEff("animEff", position)
	eff.setImgs(effdirec, frame, repeat)
	eff.normalSpr.position = deviation
	eff.rotation = rotation
	eff.scale *= scale
	return eff


# 创建特效的新接口，支持跨mod使用
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
func draw_effect_v2(config):
	var direc = ""
	if config.has("name"):
		direc =  Path + "/effects/" + config.name
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


# 浮动文字特效
# @param {string} text - 需要显示的文字
# @param {Vector2} position - 特效定位
# @param {string} color - 文字颜色
# @param {boolean} up - 显示向上箭头
func draw_efftext(text, position, color = "#ffffff", up = true):
	var eff = sys.newEff("numHit", position)
	var dev = 0
	var y = sys.rndListItem([-80, -70, -60, -50, -40, -30, -20, -10, 0, 10, 20])
	eff.normalSpr.position = Vector2(0, y)
	eff.scale.x *= -1
	eff.anim.set_speed_scale(0)

	if up:
		text = "▲%s▲" % [text]
	else:
		text = "▼%s▼" % [text]

	eff.setText(text, color)
	eff._initFlyPos(position + Vector2(20, 0), 20)


# 绘制按钮UI - 废弃不维护
# @param {string} text - 按钮文案
# @param {Vector2} position - 按钮定位（相对父级）
# @param {Object} target - 连接到的对象
# @param {string} callback - 被连接对象的方法名
# @param {dictionary} config -
# @param {array} config.args - callback的参数数组
# @param {boolean} config.return - 是否返回按钮实例
func draw_ui_button(text, position, target, callback, config):
	var args = getVal(config, "args", [])
	var button = Button.new()
	button.text = text
	button.rect_position = position
	button.connect("pressed", target, callback, args)

	if getVal(config, "return", false):
		return button
	else:
		sys.main.get_node("ui").add_child(button)

# 绘制按钮UI - 新版本按钮绘制
func draw_button_v2(btnConfig):
	var button = Button.new()
	var target = getVal(btnConfig, "target", self)
	var callback = getVal(btnConfig, "callback", "")
	var args = getVal(btnConfig, "args", [])
	button.connect("pressed", target, callback, args)

	var key = getVal(btnConfig, "key", false)
	if key:
		var sc = ShortCut.new()
		var keyborad = InputEventKey.new()
		keyborad.scancode = key
		sc.set_shortcut(keyborad)
		button.shortcut = sc
		button.shortcut_in_tooltip = true

	button.text = getVal(btnConfig, "text", "按钮")
	button.rect_position = getVal(btnConfig, "position", Vector2(0, 0))


	if btnConfig.has("size"):
		button.set_size(btnConfig.size)

	if getVal(btnConfig, "return", false):
		return button
	else:
		sys.main.get_node("ui").add_child(button)


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


# 绘制选项
# @param {string} text - 选项文案
# @param {string} name - 选项唯一标识
# @param {boolean} pressed - 是否选中
# @param {boolean} disabled - 是否隐藏
# @return {CheckBox}
func draw_check(text, name = "", pressed = false, disabled = false):
	var c = CheckBox.new()
	c.text = text
	c.disabled = disabled
	c.pressed = pressed
	if name != "":
		c.name = name
	return c


# 新建一个信息面板
func initInfomation():
	textGrid = RichTextLabel.new()
	textGrid.rect_min_size = Vector2(1000, 400)
	textGrid.margin_left = 50
	textGrid.margin_top = 80
	textGrid.bbcode_enabled = true

	infomation = sys.newMsg("jiangLiMsg")
	infomation.get_node("Panel").add_child(textGrid)
	infomation.get_node("Panel/Button").connect("pressed", self, "MsgOk")


# 展示信息面板
# @param {dictionary} config -
# @param {string} config.title - 信息面板标题
# @param {string} config.content - 信息面板内容
func showInfomation(config):
	if !infomation:
		initInfomation()
	infomation.get_node("Panel/Label").text = getVal(config, "title", "信息面板")
	textGrid.bbcode_text = getVal(config, "content", "暂无内容")
	infomation.show()


func MsgOk():
	pass


# 创建时间轴
# @param {dictionary} skillAxis - 时间轴配置
# {
# 	"skill": [1, 2, 3]
# }
# ↓↓↓
# @return {dictionary}
# {
# 	1: "skill",
# 	2: "skill",
# 	3: "skill",
# }
func create_timeAxis(skillAxis):
	var timeAxis = {}
	for skillName in skillAxis:
		for timePoint in skillAxis[skillName]:
			timeAxis[timePoint] = skillName
	return timeAxis


# 获取直线范围的角色
# @param {Vector2} aCell - 起点坐标
# @param {Vector2} bCell - 终点坐标
# @param {number} num - 长度（单位100）
# @return {array}
func lineChas(aCell, bCell, num):	
	if !sys.main.isMatin(aCell) or !sys.main.isMatin(bCell):
		return []

	var toolman = sys.main.newChara("cFFXIV_Tatalu", 2)
	var chas = []
	var aPos = sys.main.map.map_to_world(aCell) + Vector2(50, 50)
	var bPos = sys.main.map.map_to_world(bCell) + Vector2(50, 50)
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


# 距离衰减aoe计算
# @param {Vector2} startCell - 起点坐标
# @param {Vector2} targetCell - 目标点坐标
# @param {number} damage - 最大伤害值
# @return {number} 衰减后的伤害值
func attenuationDamage(startCell, targetCell, damage):
	var toolman = sys.main.newChara("cFFXIV_Tatalu", 2)
	var length = toolman.cellRan(startCell, targetCell)
	return damage / (1 + length)


# 寻找距离最近的单位计算
# @param {Vector2} startCell - 起点坐标
# @param {array} chas - 角色数组
# @return {Chara}
func distanceMinCha(startCell, chas):
	var minDistance = 20
	var target = null
	for cha in chas:
		var distance = cha.cellRan(startCell)
		if distance < minDistance:
			minDistance = distance
			target = cha
	return target


func getVal(object, name, default = null):
	if object.has(name):
		return object[name]
	else:
		return default


# 数据处理类
class Calculation:
	static func sort_MaxMgiAtk(a, b):
		return a.att.mgiAtk > b.att.mgiAtk

	static func sort_MaxAtk(a, b):
		return a.att.atk > b.att.atk

	static func sort_MaxDefAndMgiDef(a, b):
		return (a.att.def + a.att.mgiDef) > (b.att.def + b.att.mgiDef)

	static func sort_MinHpP(a, b):
		return (a.att.hp / a.att.maxHp) < (b.att.hp / b.att.maxHp)

	static func sort_MinHp(a, b):
		return a.att.hp < b.att.hp

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
	static func scan(path:String):
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
