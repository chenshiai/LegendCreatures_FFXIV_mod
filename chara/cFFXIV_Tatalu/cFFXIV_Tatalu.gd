extends "../BaseChara/FFXIVBaseChara.gd"

func _info():
	pass

func _ready():
	pass

func _extInit():
	._extInit()
	chaName = "塔塔露（吉祥物）"
	attCoe.atkRan = 3
	attCoe.maxHp = 2
	attCoe.atk = 10
	attAdd.spd = 2
	lv = 4
	addSkillTxt("""上！我的奴仆
宝石兽！
……
临阵脱逃可是要被处刑的！
快回来啊！！
哎呀、哎呀呀呀呀！
怎、怎么办啊……
呜啊啊！
为什么要跑啊？！
啊啊啊啊啊！
哇啊啊！
救救我啊！""")

# func normalAtkChara(cha):
# 	toAtk(cha)
# 	yield(reTimer(0.1), "timeout")
# 	toAtk(cha)
# 	yield(reTimer(0.1), "timeout")
# 	toAtk(cha)
	


# func toAtk(cha):
# 	var eff = newEff(atkEff, sprcPos)
# 	eff._initFlyCha(cha, 500)
# 	_onNormalAtk(cha)
# 	yield(eff, "onReach")
#		if sys.isClass(cha, "Chara"):
# 		atkInfo.rate = 1
# 		atkInfo.isCri = false
# 		atkInfo.canCri = true
# 		atkInfo.atkVal = att.atk
# 		atkInfo.hurtType = HurtType.PHY
# 		atkInfo.atkType = AtkType.NORMAL
# 		atkRun(cha)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	# print(self.atkInfo.rate)
	# print(self.atkInfo.isCri)
	# print(self.atkInfo.canCri)
	# print(self.atkInfo.atkVal)
	# print(self.atkInfo.hurtType)
	# print(self.atkInfo.atkType)

func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal = 0

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	isDeath = false
	plusHp(att.maxHp * 1)
