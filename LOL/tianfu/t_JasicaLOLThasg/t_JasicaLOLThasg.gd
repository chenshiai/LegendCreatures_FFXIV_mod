extends Talent
func init():
	name = "黑暗收割"

func _connect():
	tJasicaLOLThasgVar.tkp = 0
	tJasicaLOLThasgVar.t = 5
	#sys.main.add_child(tJasicaLOLThasgVar)
	sys.main.connect("onBattleStart",self,"run")

var tJasicaLOLThasgVar = JaVar.new()
var type = true
func run():
	type = false
	tJasicaLOLThasgVar.is_t = true
	#print("黑暗收割:%s" % 	tJasicaLOLThasgVar.tkp)
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv,tJasicaLOLThasgVar))


func get_info():
	if type:
		return "每次击杀获得一点灵魂(冷却时间{0}秒)\n每次攻击附加灵魂值的魔法伤害".format({"0":60/(1+lv)})
	else:
		return "存储灵魂:{1}(存档不会保存此值会被重置)\n每次击杀获得一点灵魂(冷却时间{0}秒)\n每次攻击附加灵魂值的魔法伤害".format({"0":60/(1+lv),"1":tJasicaLOLThasgVar.tkp})
	#print(lv)

class Bf extends Buff:
	var jaVar
	func _init(lv,tJasicaLOLThasgVar):
		self.lv = lv
		jaVar = tJasicaLOLThasgVar
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		masCha.connect("onKillChara",self,"run1")
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL || atkInfo.atkType == Chara.AtkType.SKILL:
			masCha.hurtChara(atkInfo.hitCha,jaVar.tkp,Chara.HurtType.MGI,Chara.AtkType.EFF)
			#print(atkInfo.hitCha.att.def)
	func run1(atkInfo):
		if jaVar.t > 60/(1+lv):
			jaVar.tkp += 1
			jaVar.t = 0
	func _upS():
		#var tJasicaLOLThasgVar = JaVar.new()
		#var character_node = sys.main.get_node('JaVar')
		#jaVar.tkp += 1
		if jaVar.is_t:
			jaVar.t += 1
		#print("黑暗收割:%s" % 	jaVar.t)
		

class JaVar:
	var tkp setget set_tkp, get_tkp
	func set_tkp(val):
		tkp = val
	func get_tkp():
		return tkp
	var t:float setget set_t, get_t
	func set_t(val):
		t = val
	func get_t():
		return t
	var is_t:bool setget set_is_t, get_is_t
	func set_is_t(val):
		is_t = val
	func get_is_t():
		return is_t

