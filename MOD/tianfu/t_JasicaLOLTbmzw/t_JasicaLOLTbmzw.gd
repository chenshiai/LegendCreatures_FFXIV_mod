extends Talent
var tools
var type = true
func init():
	name = "不灭之握"
func _init():
	._init()
	tools = globalData.infoDs["g_JasicaTool_LOLT"]
	tools.javar.obj["t_JasicaLOLTbmzw"] = 0
func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	type = false
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	#var http = HTTPRequest.new()
	#http.request("http://0uu.cc/shop/")
	#get_buffinfo()
	if type:
		return "在战斗每过10秒下一次普攻附加{0}的魔法伤害并储存{1}的生命能量(能量在战斗开始时为所有友方单位提供最大生命值)".format({"0":5 * lv + 5, "1": lv + 1})
	else:
		return "生命能量:{2}\n在战斗每过10秒下一次普攻附加{0}的魔法伤害并储存{1}的生命能量(能量在战斗开始时为所有友方单位提供最大生命值)".format({"0":5 * lv + 5, "1":lv + 1, "2":tools.javar.obj["t_JasicaLOLTbmzw"]})
	#print(lv)

func get_buffinfo():
	if sys.main != null:
		for i in sys.main.btChas:
			if i.team == 1:
				var cha = i
				var tools = globalData.infoDs["g_JasicaTool_LOLT"].javar
				var masChaId = cha.get_instance_id()
				if !tools.obj["t_JasicaLOLTbmzw"].has(masChaId):
					tools.obj["t_JasicaLOLTbmzw"][masChaId] = 0
				var hp = tools.obj["t_JasicaLOLTbmzw"][masChaId]
				print("{0}:{1}".format({"0":cha.chaName,"1":hp}))

class Bf extends Buff:
	var tools
	var masChaId
	func _init(lv):
		self.lv = lv
		attInit()
		tools = globalData.infoDs["g_JasicaTool_LOLT"].javar
		
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		#t = 0
	var t = 10
	func _upS():
		t += 1
		att.maxHp = tools.obj["t_JasicaLOLTbmzw"]
	func run(atkInfo):
		#print(masChaId)
		#print(tools.obj["t_JasicaLOLTbmzw"][masChaId])
		if t >= 10 && atkInfo.atkType == Chara.AtkType.NORMAL:
			masCha.hurtChara(atkInfo.hitCha,5 + 5*self.lv,Chara.HurtType.MGI,Chara.AtkType.EFF)
			#print(masCha.att.maxHp)
			tools.obj["t_JasicaLOLTbmzw"] += self.lv + 1
			att.maxHp = tools.obj["t_JasicaLOLTbmzw"]
			#print(masCha.att.maxHp)
			#print(self.lv)
			t = 0

