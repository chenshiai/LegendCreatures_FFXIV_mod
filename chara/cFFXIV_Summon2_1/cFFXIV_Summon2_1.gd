extends "../cFFXIV_Summon2/cFFXIV_Summon2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "迦楼罗之灵"
	lv = 3
	evos = ["cFFXIV_Summon2_1_1"]

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
