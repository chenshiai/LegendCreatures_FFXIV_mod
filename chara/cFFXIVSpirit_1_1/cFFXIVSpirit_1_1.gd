extends "../cFFXIVSpirit_1/cFFXIVSpirit_1.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "东天之星-昼"
	lv = 3
	evos = []

func _connect():
	._connect() #保留继承的处理