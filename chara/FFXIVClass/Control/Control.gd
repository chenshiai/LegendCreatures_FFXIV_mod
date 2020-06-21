extends "../BaseClass.gd"

var ControlPanel # 控制面板节点
var SwitchButton # 开关节点
var PlayerChas = [] # 被控制的角色列表

var ButtonConfig
var MapArea

var AreaQueue = []
var throttle = false # 命令节流 防止重复命令导致程序崩溃
var infomation
var textGrid

func _init():
	print("最终幻想14：—————— 控制面板加载 ——————")
	setConfig()
	pass


func createControl():
	SwitchButton = Utils.createUiButton("展开", Vector2(1073, 495), self, "switch", {"return": true})
	sys.main.get_node("ui").add_child(SwitchButton)
	randerPanel()
	sys.main.connect("onBattleStart", self, "moveControlInit")
	sys.main.connect("onBattleEnd", self, "controlFree")

func randerPanel():
	ControlPanel = NinePatchRect.new()
	ControlPanel.rect_position = Vector2(400, 430)

	for button in ButtonConfig:
		var bt = Utils.createUiButton(button.text, button.position, button.target, button.callback, button.config)
		ControlPanel.add_child(bt)

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
	yield(sys.get_tree().create_timer(1), "timeout")
	throttle = false

# 延时定点
func delay():
	for cha in PlayerChas:
		if cha.hasBuff("b_StaticTime"):
			BUFF_LIST.b_StaticTime.new(2, cha)

# 定点移动，让角色向目标点移动，true表示移动成功，false表示移动失败
func movement(cha, cell) -> bool:
	if !cha.isDeath:
		if cha.setCell(cell):
			BUFF_LIST.b_StaticTime.new(2, cha) # 移动成功时关闭ai，防止反复横跳
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
		if cha.cell.x <= 3:
			if cha.cell.y >= 2:
				select_area(cha, mapArea, "left_bottom")
			else:
				select_area(cha, mapArea, "left_top")
		elif cha.cell.y >= 2:
			select_area(cha, mapArea, "right_bottom")
		else:
			select_area(cha, mapArea, "right_top")

# 选择当前区域内最近地点移动
func select_area(cha, mapArea, area):
	var minDistance = 20
	var targetCell = Vector2(0, 0)

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
		# 此处不留爷，自有留爷处。当前区域没有位置了，前往下一个区域
		match area:
			"left_bottom": select_area(cha, mapArea, "left_top")
			"left_top": select_area(cha, mapArea, "right_top")
			"right_bottom": select_area(cha, mapArea, "left_bottom")
			"right_top": select_area(cha, mapArea, "right_bottom")

func showLimitInfo():
	infomation = sys.newMsg("jiangLiMsg")
	infomation.get_node("Panel/Label").text = TEXT.LimitBreakInfomation.title
	infomation.get_node("Panel/Button").connect("pressed", self, "MsgOk")
	textGrid = Label.new()
	textGrid.text = TEXT.LimitBreakInfomation.content
	infomation.get_node("Panel/CenterContainer").add_child(textGrid)
	infomation.show()

func MsgOk():
	pass

func setConfig():
	ButtonConfig = [
		{
			"text": "说明书",
			"position": Vector2(610, 0),
			"target": self,
			"callback": "showLimitInfo",
			"config": {
				"args": [],
				"return": true
			},
		},
		{
			"text": "退避",
			"position": Vector2(495, 0),
			"target": Retreat,
			"callback": "changeHateTarget",
			"config": {
				"args": [],
				"return": true
			},
		},
		{
			"text": "防护",
			"position": Vector2(440, 22),
			"target": Limit,
			"callback": "limit_protect",
			"config": {
				"args": [],
				"return": true
			},
		},
		{
			"text": "进攻",
			"position": Vector2(495, 50),
			"target": Limit,
			"callback": "limit_attack",
			"config": {
				"args": [],
				"return": true
			},
		},
		{
			"text": "治疗",
			"position": Vector2(550, 22),
			"target": Limit,
			"callback": "limit_treatment",
			"config": {
				"args": [],
				"return": true
			},
		},
		{
			"text": "左移",
			"position": Vector2(0, 22),
			"target": self,
			"callback": "horizontal_move",
			"config": {
				"args": [Vector2(-1, 0)],
				"return": true
			},
		},
		{
			"text": "右移",
			"position": Vector2(110, 22),
			"target": self,
			"callback": "horizontal_move",
			"config": {
				"args": [Vector2(1, 0)],
				"return": true
			},
		},
		{
			"text": "上移",
			"position": Vector2(55, 0),
			"target": self,
			"callback": "horizontal_move",
			"config": {
				"args": [Vector2(0, -1)],
				"return": true
			},
		},
		{
			"text": "下移",
			"position": Vector2(55, 50),
			"target": self,
			"callback": "horizontal_move",
			"config": {
				"args": [Vector2(0, 1)],
				"return": true
			},
		},
		{
			"text": "分散",
			"position": Vector2(275, 50),
			"target": self,
			"callback": "complex_move",
			"config": {
				"args": ["scatter"],
				"return": true
			},
		},
		{
			"text": "平行",
			"position": Vector2(275, 0),
			"target": self,
			"callback": "complex_move",
			"config": {
				"args": ["parallel"],
				"return": true
			},
		},
		{
			"text": "左集",
			"position": Vector2(220, 22),
			"target": self,
			"callback": "complex_move",
			"config": {
				"args": ["aggregate_left"],
				"return": true
			},
		},
		{
			"text": "右集",
			"position": Vector2(330, 22),
			"target": self,
			"callback": "complex_move",
			"config": {
				"args": ["aggregate_right"],
				"return": true
			},
		},
	]

	MapArea = {
		"scatter": {
			"left_top": [Vector2(0, 1), Vector2(2, 0)],
			"left_bottom": [Vector2(0, 3), Vector2(1, 4), Vector2(3, 4)],
			"right_top": [Vector2(4, 0), Vector2(6, 0), Vector2(7, 1)],
			"right_bottom": [Vector2(5, 4), Vector2(7, 3)]
		},
		"parallel": {
			"left_top": [Vector2(0, 0), Vector2(1, 0), Vector2(2, 0), Vector2(3, 0)],
			"left_bottom": [Vector2(0, 4), Vector2(1, 4), Vector2(2, 4), Vector2(3, 4)],
			"right_top": [Vector2(4, 0), Vector2(5, 0), Vector2(6, 0), Vector2(7, 0)],
			"right_bottom": [Vector2(4, 4), Vector2(5, 4), Vector2(6, 4), Vector2(7, 4)]
		},
		"aggregate_left": {
			"left_top": [Vector2(2, 0), Vector2(1, 1), Vector2(2, 1)],
			"left_bottom": [Vector2(0, 2), Vector2(1, 2), Vector2(1, 3)],
			"right_top": [Vector2(2, 2), Vector2(2, 3), Vector2(2, 4)],
			"right_bottom": [Vector2(3, 1), Vector2(3, 2), Vector2(3, 3)]
		},
		"aggregate_right": {
			"right_top": [Vector2(5, 0), Vector2(5, 1), Vector2(5, 1)],
			"right_bottom": [Vector2(6, 2), Vector2(7, 2), Vector2(6, 3)],
			"left_bottom": [Vector2(5, 2), Vector2(5, 3), Vector2(5, 4)],
			"left_top": [Vector2(4, 1), Vector2(4, 2), Vector2(4, 3)]
		},
	}