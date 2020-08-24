extends Item
func init():
	type = config.EQUITYPE_EQUI
	attInit()

func _connect():
	pass

class jab_hudun extends Buff:
	var d setget set_d, get_d
	var type: bool setget set_type, get_type
	func set_d(val):
		d = val
	func get_type():
		return type
	func set_type(val: bool):
		type = val
	func get_d():
		return d
	func _init(lv = 1,val = false,var2 = 0):
		attInit()
		d = var2
		type = val
		effId = "p_diYu"
		life = lv
		id = "jab_hudun"
		isNegetive=true
	func init():
		pass
	func _connect():
		masCha.connect("onHurt",self,"onHurt")#护盾免伤计算
	func _upS():
		if !type:
			eff.amount = clamp(life,1,10)
	func onHurt(atkInfo:AtkInfo):
		#print("钢铁烈阳之匣:%s" % d)
		#print(hd)
		if d > 0:
			atkInfo.hurtVal = 0
			d -= atkInfo.atkVal
			if d < 0:
				d = 0
