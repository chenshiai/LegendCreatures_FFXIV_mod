extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "吉光%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.atk = 24
	att.spd = 0.12

func updateAtt():
	att.atk += 7
	att.spd += 0.02
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("atk", "spd")
	self.connect("randomAtt", self, "_randomAtt", ["atk", "spd"])
	self.connect("updateAtt", self, "updateAtt")
