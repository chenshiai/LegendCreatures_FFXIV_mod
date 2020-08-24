extends Item
func init():
	name = "斯塔缇克电刃"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.6
	att.cri = 0.25
	att.atkRan = 2
	info = "每8次攻击会造成120额外魔法伤害并最多弹射5个单位"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")

var c = 0 #弹射次数
var n = 0 #攻击次数
func run(atkInfo:AtkInfo):
	n += 1
	#print(masCha.getAllChas(1))
	#print(masCha.rndChas(masCha.getAllChas(1),5))
	if n >= 8:
		for arr in masCha.getCellChas(atkInfo.hitCha.cell,5,1):
			if c < 5 && atkInfo.atkType == Chara.AtkType.NORMAL:
				#print(arr)
				masCha.hurtChara(arr,120,Chara.HurtType.MGI,Chara.AtkType.EFF)
			c += 1
		n = 0
		c = 0
