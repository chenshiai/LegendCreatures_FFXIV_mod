extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "银龙"
	attCoe.atkRan = 1
	attCoe.maxHp = 5
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 0
	attCoe.mgiDef = 0
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addSkillTxt("神龙的眷属")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
