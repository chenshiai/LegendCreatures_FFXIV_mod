extends Talent

func init():
	name = "致命一击"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return "目标生命低于70%增加{0}%伤害\n低于{1}%斩杀\n对于召唤生物直接斩杀".format({"0":1+lv,"1":1+lv})
	#print(lv)

class Bf extends Buff:
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		var atkR = (1+self.lv) * 0.01
		if (atkInfo.hitCha.att.hp/atkInfo.hitCha.att.maxHp) < 0.7 && atkInfo.atkType != Chara.AtkType.EFF && atkInfo.atkType != Chara.AtkType.MISS:
			att.atkR = atkR
		else:
			att.atkR = 0
			#print("致命一击:伤害增加")
		if ((atkInfo.hitCha.att.hp < 0.01*(1+self.lv)*atkInfo.hitCha.att.maxHp) || atkInfo.hitCha.isSumm) &&  atkInfo.atkType != Chara.AtkType.MISS && atkInfo.atkType != Chara.AtkType.EFF:
			masCha.hurtChara(atkInfo.hitCha,5 + atkInfo.hitCha.att.hp,Chara.HurtType.REAL,Chara.AtkType.EFF)
			#print("致命一击:斩杀")

