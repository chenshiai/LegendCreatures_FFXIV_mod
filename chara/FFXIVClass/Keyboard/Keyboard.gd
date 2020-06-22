extends Node

func _ready():
  pass

func _input(e):
	if e is InputEventKey and e.pressed and not e.echo: 
	#筛选键盘输入事件 and 键盘按下事件 and 非一直按下状态
		match e.scancode:
			KEY_1:
				print("1")
			KEY_2:
				print("2")
			KEY_3:
				print("3")
			_:
        print("_")
