extends Talent

func init():
	name = "理财大师"

func _connect():
	sys.main.connect("onBattleStart",self,"run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	var gd = (1+lv*0.5) as int
	if lv == 5:
		gd += 1
	return "技能与普通攻击每杀死1个敌人获得{0}金币\n每回合每个单位最多触发一次".format({"0":gd})

	#print(lv)

class Bf extends Buff:
	var n = 0
	func _init(lv):
		self.lv = lv
		attInit()
	func _connect():
		masCha.connect("onKillChara",self,"run")
		n = 0
	

	func run(atkInfo):
		var gd = (1+self.lv*0.5) as int
		if self.lv == 5:
			gd += 1
		if n == 0 && atkInfo.atkType == Chara.AtkType.NORMAL:
			sys.main.player.plusGold(gd)
			n += 1

		if n == 0 && atkInfo.atkType == Chara.AtkType.SKILL:
			sys.main.player.plusGold(gd)
			n += 1
