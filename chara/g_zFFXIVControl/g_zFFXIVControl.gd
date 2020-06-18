var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var Limit = globalData.infoDs["g_FFXIVLimitBreak"] # 极限技类
var Retreat = globalData.infoDs["g_FFXIVRetreat"] # 退避机制

var ControlPanel = null
var SwitchButton = null

var ButtonConfig = [
	{
		"text": "说明",
		"position": Vector2(0, 0),
		"target": Retreat,
		"callback": "showInfo",
		"config": {"return": true},
	},
	{
		"text": "退避",
		"position": Vector2(60, 0),
		"target": Retreat,
		"callback": "changeHateTarget",
		"config": {"return": true},
	},
	{
		"text": "防护",
		"position": Vector2(120, 0),
		"target": Limit,
		"callback": "limit_protect",
		"config": {"return": true},
	},
	{
		"text": "进攻",
		"position": Vector2(180, 0),
		"target": Limit,
		"callback": "limit_attack",
		"config": {"return": true},
	},
	{
		"text": "治疗",
		"position": Vector2(240, 0),
		"target": Limit,
		"callback": "limit_treatment",
		"config": {"return": true},
	},
]

func _init():
	print("最终幻想14：—————— 控制面板加载 ——————")
	pass

func createControl():
	SwitchButton = Utils.createUiButton("收起", Vector2(380, 550), self, "switch", {"return": true})
	sys.main.get_node("ui").add_child(SwitchButton)
	randerPanel()


func randerPanel():
	ControlPanel = NinePatchRect.new()
	ControlPanel.rect_position = Vector2(440, 550)

	for button in ButtonConfig:
		var bt = Utils.createUiButton(button.text, button.position, button.target, button.callback, button.config)
		ControlPanel.add_child(bt)

	sys.main.get_node("ui").add_child(ControlPanel)


func switch():
	ControlPanel.visible = !ControlPanel.visible
	if !ControlPanel.visible:
		SwitchButton.text = "展开"
	else:
		SwitchButton.text = "收起"
