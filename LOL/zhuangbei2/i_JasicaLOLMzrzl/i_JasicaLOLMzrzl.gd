extends Item
func init():
	name = "自然之力"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiDef = 120
	info = "唯一·自然:每秒回复最大生命的0.35%(最多200)"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")


func run():
	masCha.addBuff(w_ziran.new())

class w_ziran extends Buff:
	func _init(lv = 1):
		attInit()
		#effId = "p_liuXue"
		#life = lv
		#isNegetive=true
	func init():
		pass
	func _connect():
		pass
	func _upS():
		var ahp = masCha.att.maxHp*0.0035
		#print("1.冥火之拥:%s" % ahp)
		masCha.plusHp(ahp,true)
	