extends Item
func init():
	name = "血色之刃"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 60
	att.suck = 0.15
	att.pen = 25
	info = "每次攻击获得8层[急速]"
	info += "\n每过5秒清除所有[急速]"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")

var t = 0 #计时
func _upS():
	t += 1
	if t == 5:
		#print("血色之刃:%s" % masCha.att.spd)
		masCha.delBuff(masCha.hasBuff("b_jiSu"))
		#print("血色之刃:%s" % masCha.att.spd)
		t = 0
func run(atkInfo:AtkInfo):
	#print("血色之刃:%s" % masCha.att.spd)
	masCha.addBuff(b_jiSu.new(8))
	#print("血色之刃:%s" % masCha.att.spd)