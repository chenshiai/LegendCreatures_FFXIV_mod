extends Item


func init():
	name = "饮血剑"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.suck = 0.20
	info = "护盾：0" 
	info += "\n生命偷取溢出的生命会变成护盾最多存储1500"
	info += "\n每回合战斗开始护盾值衰减30%"
	
func _connect():
	masCha.connect("onAtkChara",self,"run1")
	masCha.connect("onPlusHp",self,"run")
	masCha.connect("onHurt",self,"run2")
	sys.main.connect("onBattleStart",self,"run3") #护盾衰减
var hp = 0
var d = 0
var infos = "护盾：%s\n生命偷取溢出的生命会变成护盾最多存储1500\n每回合战斗开始护盾值衰减30%%" 
func run1(atkInfo):
	if masCha.att.hp > (masCha.att.maxHp - atkInfo.hurtVal*masCha.att.suck):
		hp = atkInfo.hurtVal*masCha.att.suck - (masCha.att.maxHp - masCha.att.hp)
func run(val):
	if hp > 0:
		var n = val - (masCha.att.maxHp - masCha.att.hp)
		if n > 0:
			d += hp
			if d > 1500:
				d = 1500
			hp = 0
			info = infos % d as int
func run2(atkInfo):
	if d > 0:
		atkInfo.hurtVal = 0
		d -= atkInfo.atkVal
		if d < 0:
			d = 0
		info = infos % d as int
func run3():
	if d > 0:
		d = d*0.7
		info = infos % d as int
