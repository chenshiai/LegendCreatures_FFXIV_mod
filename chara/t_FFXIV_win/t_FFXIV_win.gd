extends Talent
var TEXT = globalData.infoDs["g_bFFXIVText"]

func init():
	name = "光之加护"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(LightHard.new())

func get_info():
	return TEXT.T_LIGHT

class LightHard:
	extends Buff

	func _init():
		attInit()
		id = "LightHard"
		isNegetive = false
		att.defL = 0.15
		att.mgiDefL = 0.15

	func _del():
		for i in sys.main.btChas:
			if i.team == 2 and !i.isDeath:
				masCha.addBuff(LightHard.new())
		# sys.main.get_node("ui/player/GridContainer").add_child(preload("res://ui/talentBtn/talentBtn.tscn").instance())