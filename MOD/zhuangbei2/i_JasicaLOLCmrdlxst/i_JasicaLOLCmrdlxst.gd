extends Item
func init():
	name = "麦瑞德裂血手套"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 40
	att.spd = 0.4
	att.def = 25
	
	info = "唯一·裂血:物力攻击时附加目标最大生命4%的魔法伤害"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	masCha.addBuff(w_liexue.new())

class w_liexue extends Buff:
	func _init(lv = 1):
		attInit()
		#effId = "p_liuXue"
		#life = lv
		#isNegetive=true
	func init():
		pass
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func _upS():
		pass
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			masCha.hurtChara(atkInfo.hitCha,atkInfo.hitCha.att.maxHp*0.04,Chara.HurtType.MGI,Chara.AtkType.EFF)
	