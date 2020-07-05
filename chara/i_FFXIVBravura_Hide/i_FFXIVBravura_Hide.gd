extends "../FFXIVItem/AncientWeapons/AncientWeapons.gd"

func _init():
	._init()
	ItemName = "勇悍斧%s"
	Skill_info = "[招架]：受到普通攻击时有30%%的概率进行招架，使伤害降低%d%%" % [Level * 2 + 10]
	name = ItemName % [STEP[Level]]
	info = _getEpilogue()
	att.maxHp = 80
	att.atk = 25

func updateAtt():
	att.atk += 5
	att.maxHp += 20
	for item in randAtt:
		att[item.attr] += rand_range(item.up[0], item.up[1])
	Skill_info = "[招架]：受到普通攻击时有30%%的概率进行招架，使伤害降低%d%%" % [Level * 2 + 10]

func _connect():
	._connect()
	if !randAtt.size() > 0:
		_randomAtt("atk", "maxHp")
	self.connect("randomAtt", self, "_randomAtt", ["atk", "maxHp"])
	self.connect("updateAtt", self, "updateAtt")
	masCha.connect("onHurt", self, "run")

func run(atkInfo:AtkInfo):
	if atkInfo.atkType != Chara.AtkType.NORMAL:
		return
	if sys.rndPer(30):
		atkInfo.hurtVal *= 1 - (Level * 0.02 + 0.1)
