extends Item


func init():
	name = "鬼索的狂暴之刃"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 35
	att.mgiAtk = 35
	att.spd = 0.25
	att.pen = 25
	att.mgiPen = 25
	info = "唯一·狂暴:普通攻击提供8%攻速,持续5秒(最多6层).满层时触发鬼索之怒"
	info += "\n鬼索之怒:每三次普通攻击造成50点真实伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
	sys.main.connect("onBattleStart",self,"run1")

func run1():
	masCha.addBuff(w_kuangbao.new(5))
func run(atkInfo):
	#print("黑色切割者:%s" % atkInfo.hitCha.att.def)
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		var bf:Buff = masCha.hasBuff("w_kuangbao")
		#print("1.鬼索的狂暴之刃:%s" % masCha.att.spd)
		#print("6.鬼索的狂暴之刃:%s" % bf)

		if bf != null:
			bf.life = 5
			
		#print("鬼索的狂暴之刃:%s" % masCha.att.spd)
		#masCha.hasBuff("w_kuangbao").life = 5
		#masCha.hasBuff("w_kuangbao").nn = n
		#print("鬼索的狂暴之刃:%s" % masCha.hasBuff("w_kuangbao").nn)
		#print("黑色切割者:%s" % atkInfo.hitCha.hasBuff("w_qiegezhe"))

class w_kuangbao extends Buff:
	var nn:float = 0
	func _init(lv = 1):
		attInit()
		#print("2.鬼索的狂暴之刃:%s" % nn)
		effId = "p_zhonDu"
		life = lv
		id = "w_kuangbao"
		if nn == null:
			nn = 0
		#isNegetive=true
	
	func init():
		pass
	
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func _upS():
		#masCha.hurtChara(masCha,masCha.att.maxHp * (0.01 + life * 0.001) * pw,Chara.HurtType.REAL,Chara.AtkType.EFF)
		# print("3.鬼索的狂暴之刃:%s" % nn)
		# print("4.鬼索的狂暴之刃:%s" % (0.08 * nn))
		if nn == null:
			nn = 0
		att.spd = 0
		att.spd = 0.08 * nn
		#print("5.鬼索的狂暴之刃:%s" % att.spd)
		if life > 5:
			life = 5
		eff.amount = clamp(life,1,25)
		#print("黑色切割者:%s" % life)
	var n2 = 0 
	func run(atkInfo):
		if nn == null:
			nn = 0
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			nn += 1
			if nn > 6:
				nn = 6
			if nn >= 6:
				n2 += 1
				if n2 == 3:
					n2 = 0
					masCha.hurtChara(atkInfo.hitCha,50,Chara.HurtType.REAL,Chara.AtkType.EFF)
	