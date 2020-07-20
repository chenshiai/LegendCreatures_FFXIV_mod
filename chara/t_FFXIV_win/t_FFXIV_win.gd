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
	var resolve = false
	func _init():
		attInit()
		id = "LightHard"
		isNegetive = false
		att.defL = 0.15
		att.mgiDefL = 0.15

	func _connect():
		sys.main.connect("onCharaDel", self, "run")
	
	func run(cha):
		if cha == masCha:
			resolve = true

	func _del():
		if resolve:
			masCha.addBuff(LightHard.new())
			resolve = false
	
		# sys.main.get_node("ui/player/GridContainer").add_child(preload("res://ui/talentBtn/talentBtn.tscn").instance())