extends Chara

func _info():
		pass

func _ready():
	# get_node("../").queue_free()
	pass

func _connect():
	._connect()
func _extInit():
	._extInit()
	attCoe.atkRan = 8
	chaName = "工具人"
	attCoe.maxHp = 1
	lv = 4
	addSkillTxt('[我是工具人]：\uE415')