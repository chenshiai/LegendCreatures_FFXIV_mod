extends Talent
var TEXT = globalData.infoDs["g_bFFXIVText"]

func init():
	name = "队伍编制"

func get_info():
	return TEXT.T_TEAM

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
				cha.addBuff(FullTeam.new())
			elif count >= 4:
				cha.addBuff(LightTeam.new())


class LightTeam:
	extends Buff
	func _init():
		attInit()
		id = "FFXIVLightTeam"
		isNegetive = false
		att.maxHpL = 0.1
		att.atkL = 0.1
		att.mgiAtkL = 0.1
		att.defL = 0.1
		att.mgiDefL = 0.1

	func _del():
		for i in sys.main.btChas:
			if i.team == 2:
				masCha.addBuff(LightTeam.new())

class FullTeam:
	extends Buff
	func _init():
		attInit()
		id = "FFXIVFullTeam"
		isNegetive = false
		att.maxHpL = 0.2
		att.atkL = 0.2
		att.mgiAtkL = 0.2
		att.defL = 0.2
		att.mgiDefL = 0.2

	func _del():
		for i in sys.main.btChas:
			if i.team == 2 and !i.isDeath:
				masCha.addBuff(FullTeam.new())
