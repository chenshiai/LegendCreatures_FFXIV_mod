extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "穿心枪盖博尔格%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.atk = 30
	att.pen = 20

func updateAtt():
	att.atk += 6
	att.pen += 5
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("atk", "pen")
	self.connect("randomAtt", self, "_randomAtt", ["atk", "pen"])
	self.connect("updateAtt", self, "updateAtt")
