extends Item
func init():
	name = "荆棘之甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 80
	att.maxHp = 350
	info = "唯一·荆棘:被普通攻击时,会反弹10%护甲值加上35的魔法伤害，并施加重伤3秒(回复量减少50%)"
	info += "\n唯一·寒铁:被普通攻击时,减少攻击者20%攻击速度持续1秒"
	#effId = "sk_yunShi"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")
func _upS():
	pass
func run():
	masCha.addBuff(w_jingji.new())

class w_jingji extends Buff:
	var n = 0 
	func _init(lv = 1):
		attInit()
		#life = lv
		id = "w_kuangbao"
		#isNegetive=true
	
	func init():
		pass
	
	func _connect():
		masCha.connect("onHurt",self,"run")
	func _upS():
		pass
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL :
			atkInfo.atkCha.addBuff(b_zhongshang.new(3))
			atkInfo.atkCha.addBuff(w_hantie.new(1))
			masCha.hurtChara(atkInfo.atkCha,masCha.att.def*0.1 + 35,Chara.HurtType.MGI,Chara.AtkType.EFF )

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

class w_hantie extends Buff:
	var n = 0 
	func _init(lv = 1):
		attInit()
		life = lv
		id = "w_kuangbao"
		#isNegetive=true
		att.spd = -0.20
	
	func init():
		pass
	
	func _connect():
		pass
	func _upS():
		pass