extends Item
func init():
	name = "斯特拉克的挑战护手"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 450
	info = "护盾：0"
	info += "\n提供单位100%的基础攻击力"
	info += "\n3秒内受到5%最大生命以上伤害时获得最大生命25%的护盾(冷却时间：20秒)"
	info += "\n每回合战斗开始护盾值衰减10%"
	
func _connect():
	#masCha.defStatus = 0
	masCha.connect("onHurt",self,"run") #护盾免伤计算
	masCha.connect("onHurtEnd",self,"run2") #护盾获得
	#print(masCha.attAdd.atk)
	att.atk = (masCha.attCoe.atk*8.5) as int
	sys.main.connect("onBattleStart",self,"run3") #护盾衰减
	#print(self)

var infos = "护盾：{0}\n提供单位100%的基础攻击力\n受到{1}点以上伤害时获得最大生命25%的护盾(冷却时间：20秒)\n每回合战斗开始护盾值衰减10%" 
var t = 20
var t2 = 0

func _upS():
	t += (masCha.att.cd+1)*1
	t2 += 1
	if t2 >= 3:
		t2 = 0
		ahp = 0
var d = 0 #护盾值
var ahp = 0 #受到伤害
func run(atkInfo:AtkInfo):
	if d > 0:
		atkInfo.hurtVal = 0
		d -= atkInfo.atkVal
		if d < 0:
			d = 0
		info = infos.format({"0":d, "1":masCha.att.maxHp*0.05})
	#print(d)
func run2(atkInfo):
	ahp += atkInfo.hurtVal
	if t > 20 && ahp > masCha.att.maxHp*0.05:
		d = masCha.att.maxHp*0.25
		t = 0
		t2 = 0
		ahp = 0
		info = infos.format({"0":d, "1":masCha.att.maxHp*0.05})
func run3():
	#print(d)
	if d > 0:
		d = d*0.9
		info = infos.format({"0":d, "1":masCha.att.maxHp*0.05})
