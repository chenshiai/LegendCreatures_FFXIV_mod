extends Item
func init():
	name = "狂徒铠甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 800
	att.reHp = 0.2
	att.cd = 0.1
	info = "唯一·狂徒:每次命中减少技能剩余CD的1%"
	info += "\n唯一·狂徒:每受到普攻或技能8次伤害恢复最大生命的3%"
	info += "\n唯一·狂徒:如果最大生命大于5000则回复2%"
	#info += "\n唯一·狂徒:每5秒回复150生命"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")

func _upS():
	pass
func run():
	masCha.addBuff(w_kuangtu.new())

class w_kuangtu extends Buff:
	func _init(lv = 1):
		attInit()
		id = "w_kuangtu"
	func init():
		pass
	func _connect():
		masCha.connect("onHurtEnd",self,"run")
	# var t = 0 #计时
	func _upS():
		# t += 1
		# if t == 5:
		# 	masCha.plusHp(150)
		# 	t = 0
		pass
	var n = 0
	func run(atkInfo:AtkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL || atkInfo.atkType == Chara.AtkType.SKILL:
			n += 1
		if n == 15:
			if masCha.att.maxHp > 5000:
				masCha.plusHp(masCha.att.maxHp * 0.01)
			else:
				masCha.plusHp(masCha.att.maxHp * 0.03)
			n = 0
		if atkInfo.isMiss :
			for i in masCha.skills:
				i.nowTime+=i.nowTime*0.01

	