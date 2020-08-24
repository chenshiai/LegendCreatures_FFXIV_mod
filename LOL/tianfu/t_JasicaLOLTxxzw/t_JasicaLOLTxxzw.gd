extends Talent

func init():
	name = "献血滋味"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return "造成伤害时恢复自身{0}点生命".format({"0":10 + lv*2})
	#print(lv)

class Bf extends Buff:
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		
	func run(atkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF && atkInfo.atkType != Chara.AtkType.MISS:
			masCha.plusHp(10+self.lv*2)
