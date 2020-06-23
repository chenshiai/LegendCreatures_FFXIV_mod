extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

var Summoner = null

func _extInit():
	._extInit()
	chaName = "召唤兽模板"
	attCoe.atkRan = 1
	attCoe.maxHp = 1
	attCoe.atk = 1
	attCoe.mgiAtk = 1
	attCoe.def = 1
	attCoe.mgiDef = 1
	isSumm = true
	isDeath = true

		