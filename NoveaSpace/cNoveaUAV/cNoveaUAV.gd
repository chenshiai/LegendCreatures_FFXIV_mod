extends "../Base/BaseChara.gd"


func _extInit():
	._extInit()
	chaName = "无人机"
	lv = 1
	attCoe.atkRan = 4
	attCoe.maxHp = 6
	attCoe.atk = 8
	attCoe.mgiAtk = 6
	attCoe.def = 1.5
	attCoe.mgiDef = 1.5
	evos = ["cNoveaUAV_1", "cNoveaUAV_2"]
	atkEff = "atk_dao"