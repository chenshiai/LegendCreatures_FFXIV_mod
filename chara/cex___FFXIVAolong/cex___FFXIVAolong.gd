extends Chara

func _info():
		pass

func _ready():
	get_node("../").queue_free()

func _connect():
	._connect()
func _extInit():
	._extInit()
	chaName = "工具人"
	attCoe.maxHp = 1
	lv = 4