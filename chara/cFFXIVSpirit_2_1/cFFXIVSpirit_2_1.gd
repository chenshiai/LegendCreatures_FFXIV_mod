extends "../cFFXIVSpirit_2/cFFXIVSpirit_2.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "东天之星-夜"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 3
	evos = []

func _connect():
	._connect() #保留继承的处理