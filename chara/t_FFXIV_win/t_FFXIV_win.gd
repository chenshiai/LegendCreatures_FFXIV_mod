extends Talent
var TEXT = globalData.infoDs["g_bFFXIVText"]

func init():
	name = "光之加护"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(LightHard.new(lv))

func get_info():
	return TEXT.T_LIGHT % [(0.1 + lv * 0.01)*100]

class LightHard:
	extends Buff

	func _init(lv):
		attInit()
		id = "LightHard"
		isNegetive = false
		att.defL = 0.1 + lv * 0.01
		att.mgiDefL = 0.1 + lv * 0.01
		self.lv = lv

		# sys.main.get_node("ui/player/GridContainer").add_child(preload("res://ui/talentBtn/talentBtn.tscn").instance())