extends Talent
func init():
	name = "队伍编制"


func _connect():
	sys.main.connect("onBattleStart", self, "run")
	player.connect("onAddTalent", self, "population")
	player.connect("onPlusLv", self, "population")

func population(talent:Talent = null):
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
	return """根据当前上场人数提供额外加成
轻锐小队：4人及以上，所有友方单位基础面板提高%d%%
满编小队：8人及以上，所有友方单位基础面板提高%d%%
[注意]：最大人口数量将被固定为10""" % [(0.05 + lv * 0.01) * 100, (0.1 + lv * 0.02) * 100]

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