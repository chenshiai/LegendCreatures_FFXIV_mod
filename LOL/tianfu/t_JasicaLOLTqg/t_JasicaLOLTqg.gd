extends Talent

func init():
	name = "强攻"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	
	return "每造成三次伤害减少目标{0}%不满{0}时按{0}点计算防御(物理与法术独立计算)".format({"0":1 + lv})
	#print(lv)

class Bf extends Buff:
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	var p1 = 0
	var p2 = 0
	var n = 0
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			p1 += 1
			if p1 >= 3:
				n = atkInfo.hitCha.att.mgiDef * (1 + self.lv) / 100
				if n < (1 + self.lv):n=(1 + self.lv)
				#print(atkInfo.hitCha.att.def)
				atkInfo.hitCha.att.def -= n
				#print(atkInfo.hitCha.att.def)
				p1 = 0
		if atkInfo.atkType == Chara.AtkType.SKILL:
			p2 += 1
			if p2 >= 3:
				n = atkInfo.hitCha.att.mgiDef * (1 + self.lv) / 100
				if n < (1 + self.lv):n=(1 + self.lv)
				#print(atkInfo.hitCha.att.mgiDef)
				atkInfo.hitCha.att.mgiDef -= n
				#print(atkInfo.hitCha.att.mgiDef)
				p2 = 0
