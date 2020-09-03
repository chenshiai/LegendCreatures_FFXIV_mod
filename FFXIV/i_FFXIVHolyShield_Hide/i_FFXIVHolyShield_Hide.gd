extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "神圣盾%s"
	Skill_info = "[格挡]：受到伤害时有30%%的概率进行格挡，使伤害降低%d%%" % [Level * 2 + 5]
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.maxHp = 80
	att.def = 10

func updateAtt():
	att.def += 6
	att.maxHp += 20
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])
	Skill_info = "[格挡]：受到伤害时有30%%的概率进行格挡，使伤害降低%d%%" % [Level * 2 + 5]


func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("def", "maxHp")
	self.connect("randomAtt", self, "_randomAtt", ["def", "maxHp"])
	self.connect("updateAtt", self, "updateAtt")

func _onHurt(atkInfo:AtkInfo):
	if sys.rndPer(30):
		atkInfo.hurtVal *= 1 - (Level * 0.02 + 0.05)
