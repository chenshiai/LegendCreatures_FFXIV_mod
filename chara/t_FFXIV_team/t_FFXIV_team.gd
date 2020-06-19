extends Talent
var TEXT = globalData.infoDs["g_bFFXIVText"]

func init():
	name = "队伍编制"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	player.connect("onAddTalent", self, "population")
	player.connect("onPlusLv", self, "population")

func population(talent = null):
	player.renKou = 10

func run():
	var count = 0
	for i in sys.main.btChas:
		if i.team == 1:
			count += 1

	for cha in sys.main.btChas:
		if cha.team == 1:
			if count >= 8:
				cha.addBuff(FullTeam.new(lv))
			elif count >= 4:
				cha.addBuff(LightTeam.new(lv))

func get_info():
	return TEXT.T_TEAM % [(0.05 + lv * 0.01) * 100, (0.1 + lv * 0.02) * 100]

class LightTeam:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.maxHpL = 0.05 + lv * 0.01
		att.atkL = 0.05 + lv * 0.01
		att.mgiAtkL = 0.05 + lv * 0.01
		att.defL = 0.05 + lv * 0.01
		att.mgiDefL = 0.05 + lv * 0.01

class FullTeam:
	extends Buff
	func _init(lv):
		attInit()
		isNegetive = false
		self.lv = lv
		att.maxHpL = 0.1 + lv * 0.02
		att.atkL = 0.1 + lv * 0.02
		att.mgiAtkL = 0.1 + lv * 0.02
		att.defL = 0.1 + lv * 0.02
		att.mgiDefL = 0.1 + lv * 0.02