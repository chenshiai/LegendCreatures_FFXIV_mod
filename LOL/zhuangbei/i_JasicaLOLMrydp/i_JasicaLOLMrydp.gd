extends Item
func init():
	name = "日炎斗篷"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 500
	att.def = 60
	info = "唯一·日炎:对周围2格敌对单位造成每秒最大生命1.5% + 0%的伤害(每1500生命增加1%最多3%)"
	#effId = "sk_yunShi"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")
	n = (masCha.att.maxHp/1500) as int
var n = 0
func _upS():
	n = (masCha.att.maxHp/1500) as int
	if n > 3:
		n = 3
	#print("日炎斗篷:%s" % masCha.hasBuff("w_riyan"))
	#print("日炎斗篷:%s" % masCha.hasBuff("w_riyan").tkp)
	masCha.hasBuff("w_riyan").tkp = (masCha.att.maxHp*(0.015+n*0.01)) as int
	info = "对周围2格敌对单位造成每秒最大生命1.5% + {s}%的伤害(每1500生命增加1%加成最多3%)".format({"s":n})
		
func run():
	masCha.addBuff(w_riyan.new())
	#print("日炎斗篷:%s" % masCha.hasBuff("w_riyan"))
	#print("日炎斗篷:%s" % masCha.hasBuff("w_riyan").tkp)
	masCha.hasBuff("w_riyan").tkp = (masCha.att.maxHp*(0.015+n*0.01)) as int

class w_riyan extends Buff:
	var tkp:int setget set_tkp, get_tkp
	func set_tkp(val):
		tkp = val
	func get_tkp():
		return tkp
	func _init(lv = 1):
		tkp = 0
		attInit()
		id = "w_riyan"
	func init():
		pass
	func _connect():
		pass
	func _upS():
		for arr in masCha.getCellChas(masCha.cell,2,1):
			masCha.hurtChara(arr,tkp,Chara.HurtType.MGI,Chara.AtkType.EFF)
	
