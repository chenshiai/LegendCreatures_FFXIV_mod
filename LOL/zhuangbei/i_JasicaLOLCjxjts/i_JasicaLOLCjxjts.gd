extends Item
func init():
	name = "巨型九头蛇"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 450
	att.atk = 40
	att.cd = 0.1
	att.reHp = 0.1
	info = "每次攻击对敌人造成20+最大生命1.5%对物理伤害"
	info += "\n并且对敌人周围一格周围敌人造成50+最大生命3%对物理伤害"
	info += "\n穿戴单位变为近战"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
	sys.main.connect("onBattleStart",self,"run2")
	att.atkRan = 0
func _upS():
	if masCha.attCoe.atkRan >= 1:
		var jl = (masCha.att.atkRan - 1) * -1
		#print("巨型九头蛇:%s" % jl)
		if masCha.att.atkRan > 1:
			att.atkRan = (masCha.att.atkRan - 1) * -1
		else:
			#print("巨型九头蛇:%s" % masCha.att.atkRan * -1 - 1)
			att.atkRan += jl
func run(atkInfo:AtkInfo):

	if atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.hitCha,masCha.att.maxHp*0.015+20,Chara.HurtType.PHY,Chara.AtkType.EFF)
		for arr in masCha.getCellChas(atkInfo.hitCha.cell,1,1):
			masCha.hurtChara(arr,masCha.att.maxHp*0.03+50,Chara.HurtType.PHY,Chara.AtkType.EFF)
func run2():
	#att.atkRan = (masCha.att.atkRan - 1) * -1
	# print("巨型九头蛇:attCoe:%s" % masCha.attCoe.atkRan)
	# print("巨型九头蛇:att:%s" % masCha.att.atkRan)
	# print("巨型九头蛇:attInfo:%s" % masCha.attInfo.atkRan)
	# print("巨型九头蛇:attAdd:%s" % masCha.attAdd.atkRan)
	if masCha.attCoe.atkRan >= 1:
		var jl = (masCha.att.atkRan - 1) * -1
		#print("巨型九头蛇:%s" % jl)
		if masCha.att.atkRan > 1:
			att.atkRan = (masCha.att.atkRan - 1) * -1
		else:
			#print("巨型九头蛇:%s" % masCha.att.atkRan * -1 - 1)
			att.atkRan += jl
	