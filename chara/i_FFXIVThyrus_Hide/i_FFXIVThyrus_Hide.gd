extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "酒神杖%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.mgiAtk = 30
	att.def = 10

func updateAtt():
	att.mgiAtk += 6
	att.def += 10
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("mgiAtk", "def")
	self.connect("randomAtt", self, "_randomAtt", ["def", "mgiAtk"])
	self.connect("updateAtt", self, "updateAtt")
