extends Item
func init():
	name = "莫雷洛秘典"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 80
	att.maxHp = 300
	att.mgiPen = 30
	info = "每次技能攻击会为该目标添加3秒重伤(回复量减少50%)"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")


func run(atkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.hitCha.addBuff(b_zhongshang.new(3))

class b_zhongshang extends Buff:
	func _init(lv = 1):
		attInit()
		effId = "p_liuXue"
		life = lv
		isNegetive=true
	func init():
		pass
	func _connect():
		masCha.connect("onPlusHp",self,"onHurt")
	func _upS():
		eff.amount = clamp(life,1,10)
	func onHurt(val):
		masCha.att.hp -= val*0.5
	