extends "../cFFXIVRuga_2/cFFXIVRuga_2.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "复教之拳"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	attAdd.spd += 0.18
	attAdd.atkR += 0.05
	lv = 3
	evos = []

func _connect():
	._connect() #保留继承的处理