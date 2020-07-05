extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "星辰杖%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.mgiAtk = 25
	att.mgiPen = 10

func updateAtt():
	att.def += 6
	att.mgiPen += 3
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("mgiAtk", "mgiPen")

	self.connect("randomAtt", self, "_randomAtt", ["mgiAtk", "mgiPen"])
	self.connect("updateAtt", self, "updateAtt")
