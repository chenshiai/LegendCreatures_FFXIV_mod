extends "../BaseClass.gd"
var CrusadeMsg
var CrusadeCheck = {}
var AllCheck = null
var infoBtn
func _init():
	initCrusade()


func allCheck():
	if AllCheck.pressed:
		for id in FFChara.CrusadeConfig.keys():
			FFChara.CrusadeConfig[id].checked = true
			CrusadeCheck[id].pressed = true
	else:
		for id in FFChara.CrusadeConfig.keys():
			FFChara.CrusadeConfig[id].checked = false
			CrusadeCheck[id].pressed = false
	
func checkChange(id):
	var checkStr = ""
	if CrusadeCheck[id].pressed:
		FFChara.CrusadeConfig[id].checked = true
		checkStr = "已开启"
	else:
		FFChara.CrusadeConfig[id].checked = false
		AllCheck.pressed = false
		checkStr = "已关闭"

	print("最终幻想14：%s %s" % [CrusadeCheck[id].text, checkStr])


func initCrusade():
	CrusadeMsg = WindowDialog.new()
	CrusadeMsg.set_size(Vector2(400,500))

	var CrusadeBox = VBoxContainer.new()
	CrusadeBox.name = "CrusadeBox"
	CrusadeBox.set_alignment(1)

	var MsgScroll = ScrollContainer.new()
	MsgScroll.name = "Scroll"
	MsgScroll.set_anchors_preset(15)
	MsgScroll.anchor_bottom -= 0.2
	MsgScroll.anchor_right -= 0.1
	MsgScroll.set_margin(0, 30)
	MsgScroll.set_margin(1, 25)

	infoBtn = Button.new()
	infoBtn.text = "最终幻想14更新记录"
	infoBtn.set_size(Vector2(360,50))
	infoBtn.connect("pressed", Utils, "showInfomation", [TEXT.UpdateInfo])	
	infoBtn.set_h_size_flags(4)
	CrusadeBox.add_child(infoBtn)

	AllCheck = Utils.draw_check("全选", "allCheck")
	AllCheck.connect("pressed", self, "allCheck")
	AllCheck.set_size(Vector2(380,30))
	CrusadeBox.add_child(AllCheck)

	for config in FFChara.CrusadeConfig.keys():
		var item = FFChara.CrusadeConfig[config]
		var c = Utils.draw_check(item.text, item.id, item.checked)
		c.connect("pressed", self, "checkChange", [item.id])
	
		CrusadeCheck[item.id] = c
		CrusadeBox.add_child(c)

	MsgScroll.add_child(CrusadeBox)
	CrusadeMsg.add_child(MsgScroll)
