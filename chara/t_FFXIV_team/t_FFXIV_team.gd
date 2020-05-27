extends Talent
func init():
	name = "队伍编制"


func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
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

func get_info():
	return """根据当前上场人数提供额外加成
轻锐小队：4人及以上，所有友方单位双攻提高10%
满编小队：8人及以上，所有友方单位双攻提高20%"""

class LightTeam:
	extends Buff

	func _init():
		attInit()
		isNegetive = false
		att.atkL = 0.1
		att.mgiAtkL = 0.1

class FullTeam:
	extends Buff

	func _init():
		attInit()
		isNegetive = false
		att.atkL = 0.2
		att.mgiAtkL = 0.2