extends Item


func init():
	name = "黑色切割者"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 400
	att.atk = 40
	att.cd = 0.20
	info = "唯一·切割者:造成物理伤害时减少目标4%护甲,持续6秒(最多叠加6次,减少24%护甲)"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
	sys.main.connect("onBattleStart",self,"run1")

var n = 0
func run1():
	n = 0
func run(atkInfo):
	#print("黑色切割者:%s" % atkInfo.hitCha.att.def)
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		n += 1
		if n > 6:
			n = 6
		atkInfo.hitCha.addBuff(w_qiegezhe.new(6))
		#print("黑色切割者:%s" % atkInfo.hitCha.hasBuff("w_qiegezhe").life)
		atkInfo.hitCha.hasBuff("w_qiegezhe").life = 6
		atkInfo.hitCha.hasBuff("w_qiegezhe").n = n
		
		#print("黑色切割者:%s" % atkInfo.hitCha.hasBuff("w_qiegezhe"))

class w_qiegezhe extends Buff:
	var n setget set_n, get_n
	func set_n(val):
		n = val
	func get_n():
		return n
	func _init(lv = 1):
		attInit()
		effId = "p_zhonDu"
		life = lv
		id = "w_qiegezhe"
		#isNegetive=true
	
	func init():
		pass
	
	func _connect():
		pass
	func _upS():
		#masCha.hurtChara(masCha,masCha.att.maxHp * (0.01 + life * 0.001) * pw,Chara.HurtType.REAL,Chara.AtkType.EFF)
		att.defL = - 0.04 * n
		#print("黑色切割者:%s" % life)
		if life > 6:
			life = 6 
		eff.amount = clamp(life,1,25)
		#print("黑色切割者:%s" % life)
	