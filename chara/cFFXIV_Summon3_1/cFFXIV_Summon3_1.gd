extends "../cFFXIV_Summon3/cFFXIV_Summon3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "泰坦之灵"
	lv = 3
	evos = ["cFFXIV_Summon3_1_1"]

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)