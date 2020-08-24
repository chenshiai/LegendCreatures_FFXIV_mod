extends Item
func init():
	name = "冥火之拥"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 80
	att.cd = 0.15
	info = "唯一·冥火:在回合开始时对随机目标造成目标当前25%的魔法伤害(每100点法强增加3.5%)最少200点伤害"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")

func run():
	masCha.addBuff(w_minghuo.new())
	#print("3.冥火之拥")

class w_minghuo extends Buff:
	func _init(lv = 1):
		attInit()
		self.lv = lv
		#print("4.冥火之拥")
		#effId = "p_liuXue"
		#life = lv
		#isNegetive=true
	func init():
		pass
	func _connect():
		pass
	var n = 0
	func _upS():
		if n<1:
			n+=1
			var cha:Chara = sys.rndListItem(masCha.getAllChas(1))
			#print("5.冥火之拥:%s" % cha)
			var ahp = (masCha.att.mgiAtk/100)*0.035+0.25
			var hp = ahp*cha.att.hp
			#print("2.冥火之拥:%s" % hp)
			if hp<200:
				hp=200
			#print("1.冥火之拥:%s" % ahp)
			
			masCha.hurtChara(cha,hp,Chara.HurtType.MGI,Chara.AtkType.EFF)
	