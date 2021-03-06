extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "绿瞳列传%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.mgiAtk = 35
	att.cd = 0.05

func updateAtt():
	att.mgiAtk += 7
	att.cd += 0.02
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("mgiAtk", "cd")
	self.connect("randomAtt", self, "_randomAtt", ["mgiAtk", "cd"])
	self.connect("updateAtt", self, "updateAtt")
