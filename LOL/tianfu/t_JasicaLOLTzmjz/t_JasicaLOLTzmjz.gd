extends Talent

func init():
	name = "致命节奏"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return "造成伤害获得{1}层[急速](冷却时间{0}秒)".format({"0":60-10*lv,"1":1+lv})
	#print(lv)

class Bf extends Buff:
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	var t = 60
	func _upS():
		t += 1
		#print("致命节奏:%s" % masCha.hasBuff("b_jiSu").life)
	func run(atkInfo):
		#print("致命节奏:%s" % t)
		if t >= (60-10*self.lv) && atkInfo.atkType != Chara.AtkType.EFF && atkInfo.atkType != Chara.AtkType.MISS:
			masCha.addBuff(b_jiSu.new(self.lv+1))
			#print("致命节奏:buff获得")
			t = 0
