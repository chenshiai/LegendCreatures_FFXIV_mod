extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "无锋剑柯塔纳%s"
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.atk = 20
	att.maxHp = 210
	_randomAtt("atk", "maxHp")

func updateAtt():
	att.atk += 6
	att.maxHp += 40
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])

func _connect():
	._connect()
	self.connect("randomAtt", self, "_randomAtt", ["atk", "maxHp"])
	self.connect("updateAtt", self, "updateAtt")
