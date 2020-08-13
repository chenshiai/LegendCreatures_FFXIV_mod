extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "释法来%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.atk = 27
	att.suck = 0.1

func updateAtt():
	att.atk += 6
	att.suck += 0.02
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("atk", "suck")
	self.connect("randomAtt", self, "_randomAtt", ["atk", "suck"])
	self.connect("updateAtt", self, "updateAtt")
