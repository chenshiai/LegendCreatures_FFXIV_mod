var Path = ""
enum AtkType = { LASER = 64, BULLET, DARK, LIGHT, ELECTRIC, VIBRATE}
# 镭射攻击，实体攻击，暗物质攻击，光线攻击，电能攻击，振动攻击

func _init():
	print("Novea：—————— 诺维亚空间构建中 ——————")
	call_deferred("dataInit")


func dataInit():
	Path = chaData.infoDs["cNovea_robot"].dir
  if Path != null:
    pass
	else:
		var label = Label.new()
		label.text = "Novea：MOD文件路径读取失败，请在创意工坊内重新订阅。"
		sys.get_node("../Control").add_child(label)


