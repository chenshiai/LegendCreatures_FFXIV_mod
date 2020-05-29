extends Talent
func init():
	name = "阿尔法战斗记录"

var bg = false
func _connect():
	player.connect("onAddTalent", self, "bgChange")
	sys.main.connect("onBattleStart", self, "run")

func run():
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Bf.new(lv))

func bgChange(talent:Talent):
	if !bg && talent.name == "阿尔法战斗记录":
		var utils = globalData.infoDs["g_FFXIVUtils"]
		utils.backGroundChange("SpaceTimeSlit")
		bg = true

func get_info():
	return """体验时空狭缝中经过夸大的激昂战斗
所有敌方双攻提高%d%%，战斗后额外获得%d金币
场地变为[欧米茄时空狭缝 阿尔法幻境]""" % [(0.15 - lv * 0.01) * 100, 5 + lv]

class Bf:
	extends Buff
	func _init(lv):
		attInit()
		id = "LightHard"
		isNegetive = false
		att.atkL += 0.15 - lv * 0.01
		att.mgiAtkL += 0.15 - lv * 0.01
		self.lv = lv