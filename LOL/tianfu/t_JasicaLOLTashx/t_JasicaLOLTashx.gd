extends Talent

func init():
	name = "奥数彗星"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return "每使用技能造成伤害时会在其位置召唤一颗彗星造成魔法攻击{1}+{0}%的伤害".format({"0":1 + lv,"1":10+lv*10})
	#print(lv)

class Bf extends Buff:
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.SKILL:
			masCha.hurtChara(atkInfo.hitCha,(10+self.lv*10)+(1+self.lv)*masCha.att.mgiAtk*0.01,Chara.HurtType.MGI,Chara.AtkType.EFF)
