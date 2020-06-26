extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "白金龙"
	attCoe.atkRan = 1
	attCoe.maxHp = 6
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 0
	attCoe.mgiDef = 0
	lv = 3
	evos = []
	atkEff = "atk_dao"
	addSkillTxt("神龙的眷属")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
