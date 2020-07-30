extends "../BaseClass.gd"

var Keyboard # 键盘监听实例
var ControlPanel # 控制面板节点
var SwitchButton # 开关节点
var PlayerChas = [] # 被控制的角色列表

var Limit
var HpBar # boss血条类
var FFMusic
var Crusade

var ButtonConfig
var MapArea
var CheckBoxConfig

var AreaQueue = []
var throttle = false # 命令节流 防止重复命令导致程序崩溃

func _init():
	print("最终幻想14：—————— 控制面板加载 ——————")
	createControl()
	pass


# 隐藏控制面板，并关闭键盘监听
func hiddenControl():
	SwitchButton.visible = false
	ControlPanel.visible = false
	Keyboard.close()

# 显示控制面板，并开启键盘监听
func showControl():
	SwitchButton.visible = true
	SwitchButton.text = "展开"
	Keyboard.open()

func createControl():
	Limit = Utils.FFXIVClass.LimitBreak.new() # 创建极限技实例
	HpBar = Utils.FFXIVClass.BossHpBar.new() # 创建血条实例
	FFMusic = Utils.FFXIVClass.FFMusic.new() # 创建音乐控制实例
	Retreat.initRetreat()
	set_config()
	keyboard_connect()

	sys.main.connect("onBattleStart", self, "moveControlInit")
	sys.main.connect("onBattleEnd", self, "controlFree")

	SwitchButton = Utils.draw_button_v2({
		"text": "展开",
		"target": self,
		"position": Vector2(1073, 595),
		"callback": "switch",
		"return": true,
	})
	sys.main.get_node("ui").add_child(SwitchButton)
	render_panel()


func render_panel():
	ControlPanel = NinePatchRect.new()
	ControlPanel.rect_position = Vector2(350, 530)

	Crusade = Utils.FFXIVClass.Crusade.new() # 创建讨伐管理面板实例
	ControlPanel.add_child(Crusade.CrusadeMsg)

	for button in ButtonConfig:
		var btn = Utils.draw_button_v2(button)
		ControlPanel.add_child(btn)

	sys.main.get_node("ui").add_child(ControlPanel)
	switch()


func switch():
	ControlPanel.visible = !ControlPanel.visible
	if !ControlPanel.visible:
		SwitchButton.text = "展开"
	else:
		SwitchButton.text = "收起"


func moveControlInit():
	for cha in sys.main.btChas:
		if cha.team == 1:
			PlayerChas.append(cha) # 获取战场上的友方单位

func controlFree():
	PlayerChas = [] # 清空友方单位列表


# 节流冷却
func order_throttle():
	throttle = true
	yield(sys.get_tree().create_timer(0.6), "timeout")
	throttle = false


# 延时定点
func delay():
	for cha in PlayerChas:
		if cha.hasBuff("b_StaticTime"):
			BUFF_LIST.b_StaticTime.new({"cha": cha, "dur": 1})


# 定点移动，让角色向目标点移动，true表示移动成功，false表示移动失败
func movement(cha, cell) -> bool:
	if !cha.isDeath:
		if cha.setCell(cell):
			BUFF_LIST.b_StaticTime.new({"cha": cha, "dur": 2}) # 移动成功时关闭ai，防止反复横跳
			return true
		else:
			return false
	else:
		return false


# 水平的移动指令
func horizontal_move(direction: Vector2):
	for cha in PlayerChas:
		movement(cha, cha.cell + direction)


# 复杂的移动指令
func complex_move(mapArea):
	if throttle: # 节流状态，不下达指令
		delay()
		return

	order_throttle() # 开启节流，下达指令
	for cha in PlayerChas:
		if cha.cell.x <= 4:
			if cha.cell.y > 3:
				select_area(cha, mapArea, "left_bottom")
			else:
				select_area(cha, mapArea, "left_top")
		elif cha.cell.y > 3:
			select_area(cha, mapArea, "right_bottom")
		else:
			select_area(cha, mapArea, "right_top")


# 选择当前区域内最近地点移动
func select_area(cha, mapArea, area, count = 1):
	var minDistance = 30
	var targetCell = Vector2(0, 0)

	if count >= 4:
		return
	for cell in MapArea[mapArea][area]:
		if cha.matCha(cell) == null:
			var distance = cha.cellRan(cell)
			if distance < minDistance:
				minDistance = distance
				targetCell = cell
		elif cha.cell == cell:
			targetCell = cell

	if targetCell != Vector2(0, 0):
		movement(cha, targetCell)
	else:
		count += 1
		match area:
			"left_bottom": select_area(cha, mapArea, "right_bottom", count)
			"left_top": select_area(cha, mapArea, "left_bottom", count)
			"right_bottom": select_area(cha, mapArea, "right_top", count)
			"right_top": select_area(cha, mapArea, "left_top", count)

func showCrusade():
	Crusade.CrusadeMsg.popup_centered()


func keyboard_connect():
	Keyboard = Utils.FFXIVClass.Keyboard.new()
	sys.main.add_child(Keyboard)
	# 先就这样，懒得封装
	Keyboard.connect("key_w", self, "horizontal_move", [Vector2(0, -1)])
	Keyboard.connect("key_a", self, "horizontal_move", [Vector2(-1, 0)])
	Keyboard.connect("key_s", self, "horizontal_move", [Vector2(0, 1)])
	Keyboard.connect("key_d", self, "horizontal_move", [Vector2(1, 0)])

	Keyboard.connect("key_t", self, "complex_move", ["parallel"])
	Keyboard.connect("key_q", self, "complex_move", ["aggregate_left"])
	Keyboard.connect("key_r", self, "complex_move", ["scatter"])
	Keyboard.connect("key_e", self, "complex_move", ["aggregate_right"])

	Keyboard.connect("key_z", Limit, "use_limitBreak", ["treatment"])
	Keyboard.connect("key_x", Limit, "use_limitBreak", ["attack"])
	Keyboard.connect("key_v", Retreat, "changeHateTarget")
	Keyboard.connect("key_c", Limit, "use_limitBreak", ["protect"])


func set_config():
	ButtonConfig = [
		{
			"text": "控制说明",
			"position": Vector2(610, 0),
			"target": Utils,
			"callback": "showInfomation",
			"args": [TEXT.Instructions],
			"return": true
		},
		{
			"text": "讨伐设置",
			"position": Vector2(610, 50),
			"target": self,
			"callback": "showCrusade",
			"return": true
		},
		{
			"text": "退避",
			"position": Vector2(495, 0),
			"target": Retreat,
			"callback": "changeHateTarget",
			"return": true
		},
		{
			"text": "防护",
			"position": Vector2(440, 22),
			"target": Limit,
			"callback": "use_limitBreak",
			"args": ["protect"],
			"return": true
		},
		{
			"text": "进攻",
			"position": Vector2(495, 50),
			"target": Limit,
			"callback": "use_limitBreak",
			"args": ["attack"],
			"return": true
		},
		{
			"text": "治疗",
			"position": Vector2(550, 22),
			"target": Limit,
			"callback": "use_limitBreak",
			"args": ["treatment"],
			"return": true
		},
		{
			"text": "左移",
			"position": Vector2(0, 22),
			"target": self,
			"callback": "horizontal_move",
			"args": [Vector2(-1, 0)],
			"return": true
		},
		{
			"text": "右移",
			"position": Vector2(110, 22),
			"target": self,
			"callback": "horizontal_move",
			"args": [Vector2(1, 0)],
			"return": true
		},
		{
			"text": "上移",
			"position": Vector2(55, 0),
			"target": self,
			"callback": "horizontal_move",
			"args": [Vector2(0, -1)],
			"return": true
		},
		{
			"text": "下移",
			"position": Vector2(55, 50),
			"target": self,
			"callback": "horizontal_move",
			"args": [Vector2(0, 1)],
			"return": true
		},
		{
			"text": "分散",
			"position": Vector2(275, 50),
			"target": self,
			"callback": "complex_move",
			"args": ["scatter"],
			"return": true
		},
		{
			"text": "平行",
			"position": Vector2(275, 0),
			"target": self,
			"callback": "complex_move",
			"args": ["parallel"],
			"return": true
		},
		{
			"text": "左集",
			"position": Vector2(220, 22),
			"target": self,
			"callback": "complex_move",
			"args": ["aggregate_left"],
			"return": true
		},
		{
			"text": "右集",
			"position": Vector2(330, 22),
			"target": self,
			"callback": "complex_move",
			"args": ["aggregate_right"],
			"return": true
		},
	]

	MapArea = {
		"scatter": {
			"left_top": [Vector2(0, 0), Vector2(2, 0), Vector2(4, 0), Vector2(0, 2)],
			"left_bottom": [Vector2(0, 4), Vector2(1, 5), Vector2(3, 5)],
			"right_top": [Vector2(6, 0), Vector2(8, 0), Vector2(9, 1)],
			"right_bottom": [Vector2(5, 5), Vector2(7, 5), Vector2(9, 5), Vector2(9, 3)]
		},
		"parallel": {
			"left_top": [Vector2(4, 0), Vector2(1, 0), Vector2(2, 0), Vector2(3, 0)],
			"left_bottom": [Vector2(4, 5), Vector2(1, 5), Vector2(2, 5), Vector2(3, 5)],
			"right_top": [Vector2(5, 0), Vector2(6, 0), Vector2(7, 0), Vector2(8, 0)],
			"right_bottom": [Vector2(8, 5), Vector2(5, 5), Vector2(6, 5), Vector2(7, 5)]
		},
		"aggregate_left": {
			"left_top": [Vector2(1, 1), Vector2(2, 1), Vector2(1, 2), Vector2(2, 2)],
			"left_bottom": [Vector2(1, 2), Vector2(2, 2), Vector2(1, 3), Vector2(2, 3)],
			"right_top": [Vector2(2, 1), Vector2(3, 1), Vector2(2, 2), Vector2(3, 2)],
			"right_bottom": [Vector2(2, 2), Vector2(3, 2), Vector2(2, 3), Vector2(3, 3)]
		},
		"aggregate_right": {
			"right_top": [Vector2(7, 1), Vector2(8, 1), Vector2(7, 2), Vector2(8, 2)],
			"right_bottom": [Vector2(8, 2), Vector2(7, 2), Vector2(8, 3), Vector2(7, 3)],
			"left_bottom": [Vector2(7, 2), Vector2(7, 3), Vector2(6, 2), Vector2(6, 3)],
			"left_top": [Vector2(6, 1), Vector2(6, 2), Vector2(7, 1), Vector2(7, 2)]
		},
	}
