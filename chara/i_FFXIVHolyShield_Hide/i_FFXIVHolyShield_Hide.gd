extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "神圣盾%s"
	Skill_info = "[格挡]：受到非暴击伤害时有30%%的概率进行格挡，使伤害降低%d%%" % [(Level + 2) * 2]
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.maxHp = 80
	att.def = 10
	_randomAtt("def", "maxHp")

func updateAtt():
	att.def += 6
	att.maxHp += 20
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])
	Skill_info = "[格挡]：受到非暴击伤害时有30%%的概率进行格挡，使伤害降低%d%%" % [(Level + 2) * 2]


func _connect():
	._connect()
	self.connect("randomAtt", self, "_randomAtt", ["def", "maxHp"])
	self.connect("updateAtt", self, "updateAtt")
	masCha.connect("onHurt", self, "run")

func run(atkInfo:AtkInfo):
	if atkInfo.isCri:
		return
	if sys.rndPer(30):
		atkInfo.hurtVal *= 1 - (Level + 2) * 2
