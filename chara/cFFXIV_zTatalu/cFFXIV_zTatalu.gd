extends Chara

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

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	isDeath = false
	plusHp(att.maxHp * 1)
	