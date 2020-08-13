extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "月神之弓%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.atk = 30
	att.spd = 0.1

func updateAtt():
	att.atk += 7
	att.spd += 0.03
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("atk", "spd")
	self.connect("randomAtt", self, "_randomAtt", ["atk", "spd"])
	self.connect("updateAtt", self, "updateAtt")
