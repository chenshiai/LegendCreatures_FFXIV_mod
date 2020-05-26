extends Talent

func init():
	name = "队伍编制"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
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
轻锐小队：4人及以上，所有友方单位双攻提高5%
满编小队：8人及以上，所有友方单位双攻提高10%"""

class LightTeam:
	extends Buff

	func _init(lv):
		attInit()
		isNegetive = false
		att.atkL = 0.05
		att.mgiAtkL = 0.05

	func _del():
		.del()
		masCha.addBuff(LightTeam.new())

class FullTeam:
	extends Buff

	func _init(lv):
		attInit()
		isNegetive = false
		att.atkL = 0.10
		att.mgiAtkL = 0.10

	func _del():
		.del()
		masCha.addBuff(FullTeam.new())