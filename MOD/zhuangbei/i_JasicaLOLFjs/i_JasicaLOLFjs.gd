extends Item
func init():
	name = "救赎"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 200
	att.cd = 0.1
	info = "唯一·救赎:每5秒为所有队友回复10+玩家等级*20的生命"
	info += "\n唯一·救赎:每5秒给所有敌人造成最大生命2%的真实伤害"
	#effId = "sk_yunShi"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")

func _upS():
	pass
func run():
	masCha.addBuff(w_jiushu.new())
class w_jiushu extends Buff:
	func _init(lv = 1):
		attInit()
		id = "w_jiushu"
	func init():
		pass
	func _connect():
		t = 0
	var t = 0 #计时
	func _upS():
		t += 1
		if t >= 5:
			for arr in masCha.getCellChas(masCha.cell,8,2):
				arr.plusHp(10+sys.main.player.lv*20)
			for arr in masCha.getCellChas(masCha.cell,8,1):
				masCha.hurtChara(arr,masCha.att.maxHp*0.02,Chara.HurtType.REAL,Chara.AtkType.EFF)
			t = 0

